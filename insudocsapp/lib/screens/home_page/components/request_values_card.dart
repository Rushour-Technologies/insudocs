import 'package:flutter/material.dart';
import 'package:insudox_app/globals.dart';

Builder requestValueCard(String title, int val) => Builder(
      builder: (context) {
        final List<double> tempDimensions = [
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height
        ];
        final double screenHeight = tempDimensions[0] > tempDimensions[1]
            ? tempDimensions[0]
            : tempDimensions[1];
        final double screenWidth = tempDimensions[0] > tempDimensions[1]
            ? tempDimensions[1]
            : tempDimensions[0];
        return Card(
          color: COLOR_THEME['tertiary'],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                screenHeight * 0.02,
              ),
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    val.toString(),
                    style: TextStyle(
                      fontSize: screenWidth * 0.07,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
