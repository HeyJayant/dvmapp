import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dvmapp/box.dart';
import 'package:dvmapp/content/pokeapi.dart';
import 'package:dvmapp/search.dart';

class PokemonContentList extends StatefulWidget {
  final String type;

  const PokemonContentList({Key? key, required this.type}) : super(key: key);

  @override
  State<PokemonContentList> createState() => _PokemonContentListState();
}

class _PokemonContentListState extends State<PokemonContentList> {
  List<dynamic> modifiedPokemonList = []; // Updated variable name
  List<dynamic> displayedPokemonList =
      []; // List for displaying based on search

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPokemonContent();
  }

  @override
  void didUpdateWidget(PokemonContentList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.type != widget.type) {
      // If the type has changed, fetch data again
      fetchPokemonContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildPokemonContent();
  }

  Widget buildPokemonContent() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: CustomSearchBar(
            searchController: searchController,
            onSearchChanged: onSearchChanged,
          ),
        ),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height - 220,
            child: displayedPokemonList.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : ListView.builder(
                    itemCount: displayedPokemonList.length,
                    itemBuilder: (context, index) {
                      return CustomPaperBox(
                        pokemon_name: displayedPokemonList[index]['pokemon']
                            ['name'],
                        pokemon_number: PokeAPI.formatPokemonId(
                            displayedPokemonList[index]['pokemon']['id']),
                        // pokemon_number: '#0' + '${index + 1}',
                        pokemon_url: PokeAPI.getPicUrlFromPokemon(
                            displayedPokemonList[index]['pokemon']['url']),
                        pokemon_description: PokeAPI.modifyPokemonDescription(
                            displayedPokemonList[index]['pokemon']
                                ['description']),
                      );
                    },
                  ),
          ),
        ),
        Text(
          'Made with ❤️ by Jayant Yadav',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Product Sans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void fetchPokemonContent() async {
    final data = await PokeAPI.fetchData(widget.type);
    setState(() {
      modifiedPokemonList = data;
      displayedPokemonList = List.from(modifiedPokemonList);
    });
  }

  void onSearchChanged(String query) {
    setState(() {
      displayedPokemonList = modifiedPokemonList
          .where((pokemon) => pokemon['pokemon']['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }
}
