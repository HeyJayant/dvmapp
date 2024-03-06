import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PokeAPI {
  // Base URL for the Pokemon API
  static const String baseUrl = 'https://pokeapi.co/api/v2/type/';

  // Keys for caching different types of Pokemon data
  static const String grassKey = 'grassData';
  static const String iceKey = 'iceData';
  static const String fireKey = 'fireData';

  // Function to prefetch data for Grass, Ice, and Fire types
  static Future<void> preFetchData() async {
    _fetchDataForType('12'); // Fetch Grass data
    _fetchDataForType('15'); // Fetch Ice data
    _fetchDataForType('10'); // Fetch Fire data
  }

  // Function to fetch Pokemon data for a specific type
  static Future<List<dynamic>> fetchData(String type) async {
    print('fetchData called');
    // Check if data is cached
    List<dynamic> cachedData = await _getCachedData(type);

    if (cachedData.isNotEmpty) {
      // Use cached data if available
      print('Using cached data for type: $type');
      return cachedData;
    } else {
      // Fetch data from the internet if not cached
      print('Fetching data from the internet for type: $type');
      final url = '$baseUrl$type/';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);

      List<Map<String, dynamic>> modifiedPokemonList = [];
      for (var entry in json['pokemon']) {
        final pokemonData = entry['pokemon'];
        final pokemonName =
            convertToUppercaseAndReplaceHyphens(pokemonData['name']);
        final pokemonId = extractIdFromPokemonUrl(pokemonData['url']);

        // Start fetching Pokemon description asynchronously
        final pokemonDescriptionFuture = _fetchPokemonDescription(pokemonId);

        final modifiedPokemonEntry = {
          'pokemon': {
            'name': pokemonName,
            'url': pokemonData['url'],
            'id': pokemonId,
            'type': int.parse(type),
            'description': '', // Initial value, will be updated later
          },
          'slot': entry['slot'],
        };
        modifiedPokemonList.add(modifiedPokemonEntry);

        // Update description when available
        pokemonDescriptionFuture.then((pokemonDescription) {
          modifiedPokemonEntry['pokemon']['description'] = pokemonDescription;

          // Notify the UI to update as soon as a description is available
          _updateUI(modifiedPokemonList);
        });
      }

      // Print the modified Pokemon list here
      print('Modified Pokemon List: $modifiedPokemonList');

      // Cache the fetched data
      await _cacheData(type, modifiedPokemonList);
      print('fetchData completed');
      return modifiedPokemonList;
    }
  }

// Function to update the UI when a description is available
  static void _updateUI(List<Map<String, dynamic>> modifiedPokemonList) {
    // Notify the UI to rebuild when a description is available
    // You may use a state management solution like Provider or Riverpod
    // to handle this update in the UI layer.
    // For simplicity, you can print the updated list here.
    print('Updated Pokemon List: $modifiedPokemonList');
  }

  // Function to fetch Pokemon description for a specific ID
  static Future<String> _fetchPokemonDescription(String id) async {
    try {
      final descriptionUrl = 'https://pokeapi.co/api/v2/pokemon-species/$id/';
      final uri = Uri.parse(descriptionUrl);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);

      // Assuming English language entry is at index 0, adjust accordingly
      return json['flavor_text_entries'][0]['flavor_text'];
    } catch (error) {
      // Handle error, return an empty string in case of failure
      print('Error fetching description for Pokemon $id: $error');
      return '';
    }
  }

  // Function to cache Pokemon data
  static Future<void> _cacheData(String type, List<dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _getCacheKey(type);
    prefs.setString(key, jsonEncode(data));
  }

  // Function to get cached Pokemon data
  static Future<List<dynamic>> _getCachedData(String type) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _getCacheKey(type);
    final cachedData = prefs.getString(key);

    if (cachedData != null) {
      return jsonDecode(cachedData);
    } else {
      return [];
    }
  }

  // Function to fetch data for a specific Pokemon type
  static Future<void> _fetchDataForType(String type) async {
    try {
      print('Fetching data for type: $type');
      fetchData(type);
    } catch (error) {
      // Handle errors during data fetching
      print('Error fetching data for type $type: $error');
    }
  }

  // Function to generate cache key based on Pokemon type
  static String _getCacheKey(String type) {
    switch (type) {
      case '12':
        return grassKey;
      case '15':
        return iceKey;
      case '10':
        return fireKey;
      default:
        return '';
    }
  }

  // Function to convert text to uppercase and replace hyphens with spaces
  static String convertToUppercaseAndReplaceHyphens(String text) {
    String upperCaseText = text.toUpperCase();
    String replacedText = upperCaseText.replaceAll('-', ' ');
    return replacedText;
  }

  // Function to extract ID from Pokemon URL
  static String extractIdFromPokemonUrl(String pokemonUrl) {
    // Extract the ID efficiently:
    String pokemonId = pokemonUrl.substring(34, pokemonUrl.length - 1);
    // Generate the complete image URL:
    return pokemonId;
  }

  // Function to get the image URL for a Pokemon
  static String getPicUrlFromPokemon(String pokemonUrl) {
    // Extract the ID efficiently:
    String pokemonId = pokemonUrl.substring(34, pokemonUrl.length - 1);
    // Generate the complete image URL:
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonId.png';
  }

  // Function to modify Pokemon description
  static String modifyPokemonDescription(String pokemonDescription) {
    // Replace '\n' and '\f' with spade using character classes
    String modifiedDescription =
        pokemonDescription.replaceAll(RegExp(r'[\n\f]'), '');
    return modifiedDescription;
  }

  static String formatPokemonId(String pokemonId) {
    // Attempt to parse the ID to an integer, handling potential errors
    int parsedId = int.tryParse(pokemonId) ?? 0; // Use null-coalescing operator

    if (parsedId < 10) {
      return '#0' + pokemonId;
    } else {
      return '#' + pokemonId;
    }
  }
}
