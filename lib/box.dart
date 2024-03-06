import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomPaperBox extends StatefulWidget {
  final String pokemon_name;
  final String pokemon_number;
  final String pokemon_url;
  final String pokemon_description;

  const CustomPaperBox({
    super.key,
    required this.pokemon_name,
    required this.pokemon_number,
    required this.pokemon_url,
    required this.pokemon_description,
  });

  @override
  State<CustomPaperBox> createState() => _CustomPaperBoxState();
}

class _CustomPaperBoxState extends State<CustomPaperBox> {
  late bool expandedPaperBox;

  @override
  void initState() {
    super.initState();
    // Set expandedPaperBox to true only for the first item, and false for others
    expandedPaperBox = widget.pokemon_number == '#01';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            // Update state on tap
            expandedPaperBox = !expandedPaperBox;
          },
        );
      },
      child: Stack(
        children: [
          Center(
            child: Stack(
              children: [
                Image.asset(
                  expandedPaperBox
                      ? 'assets/images/Frame_Main.png'
                      : 'assets/images/Frame_Small.png',
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, expandedPaperBox ? 311 : 172, 0, 0),
                  child: Image.asset(
                    'assets/images/Frame_Tear.png',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(270, 10, 0, 0),
            child: CachedNetworkImage(
              imageUrl: widget.pokemon_url,
              height: 150,
              width: 150,
              placeholder: (context, url) => CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 5,
              ), // Customize the placeholder
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                size: 64,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(112, 25, 70, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.pokemon_number, // Use formattedIndex for numbering
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Futura BdCn BT',
                      color: Colors.black87),
                ),
                Text(
                  widget.pokemon_name,
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Futura BdCn BT',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/grass.png',
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Image.asset(
                      'assets/images/purple.png',
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Image.asset(
                      expandedPaperBox
                          ? 'assets/images/shrink.png'
                          : 'assets/images/menu.png',
                    ),
                  ],
                ),
                Visibility(
                  visible: expandedPaperBox,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: Text(
                          widget.pokemon_description,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Product Sans',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
