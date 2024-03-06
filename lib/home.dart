import 'package:flutter/material.dart';
import 'package:dvmapp/navigation.dart';
import 'package:dvmapp/content/content.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedText = 'GRASS'; // Default selected state

  void handleNavigationButtonTap(String text) {
    setState(() {
      selectedText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'POKEDEX',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontFamily: 'Milord Book',
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          buildContentWidget(),
          // Vertical Navigation Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NavigationButton(
                  text: 'GRASS',
                  selected: selectedText == 'GRASS',
                  onTap: () => handleNavigationButtonTap('GRASS'),
                ),
                SizedBox(height: 8),
                NavigationButton(
                  text: 'ICE',
                  selected: selectedText == 'ICE',
                  onTap: () => handleNavigationButtonTap('ICE'),
                ),
                SizedBox(height: 8),
                NavigationButton(
                  text: 'FIRE',
                  selected: selectedText == 'FIRE',
                  onTap: () => handleNavigationButtonTap('FIRE'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContentWidget() {
    switch (selectedText) {
      case 'GRASS':
        return PokemonContentList(type: '12');
      case 'ICE':
        return PokemonContentList(type: '15');
      case 'FIRE':
        return PokemonContentList(type: '10');
      default:
        return Container();
    }
  }
}
