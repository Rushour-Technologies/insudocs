import 'package:flutter/material.dart';

drawerCardField(
        String title, String text, double screenHeight, double screenWidth) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 4,
          child: Text(
            title,
            style: TextStyle(
              fontFamily: "DM Sans",
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Text(
            ":",
            style: TextStyle(
              fontFamily: "DM Sans",
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: "DM Sans",
              fontSize: screenWidth * 0.035,
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
