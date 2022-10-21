import 'package:flutter/material.dart';

drawerCardField(
        String title, String text, double screenHeight, double screenWidth) =>
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$title  :  ",
          style: TextStyle(
            fontFamily: "DM Sans",
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontFamily: "DM Sans",
            fontSize: screenWidth * 0.045,
            color: Colors.white,
          ),
        ),
      ],
    );
