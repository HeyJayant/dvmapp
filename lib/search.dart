import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  CustomSearchBar({
    Key? key,
    required this.searchController,
    required this.onSearchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: TextField(
        controller: searchController,
        onChanged: onSearchChanged,
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontFamily: 'Product Sans',
        ),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Product Sans',
          ),
          icon: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 32,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
