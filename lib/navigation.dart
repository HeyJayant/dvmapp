import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap; // Callback function for button press

  NavigationButton({
    super.key,
    required this.text,
    this.selected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger the callback when the button is tapped
      child: Container(
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          border: Border(
            top: BorderSide(color: Colors.white, width: 5),
            right: BorderSide(color: Colors.white, width: 5),
            bottom: BorderSide(color: Colors.white, width: 5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset(6, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          child: SizedBox(
            height: 40,
            width: selected ? 90 : 70,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: selected ? 28 : 24,
                    fontFamily: 'Milord Book'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
