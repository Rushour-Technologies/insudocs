import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:insudox_app/globals.dart';

class NoInsuranceDialogBox extends StatelessWidget {
  const NoInsuranceDialogBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      elevation: 2,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: screenHeight * 0.03,
            top: screenHeight * 0.04,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05),
        child: Column(
          children: [
            Icon(CupertinoIcons.exclamationmark_circle,
                size: screenWidth * 0.5,
                color: COLOR_THEME['backgroundComponents0']),
            Text(
              "We can assist you with claiming the most possible out of your policies in these times of need. Please visit us again once you wish to claim or track your and your insurance’s beneficiaries rightful compensations!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "DM Sans",
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: GestureDetector(
                onTap: () {
                  SystemNavigator.pop();
                },
                child: Card(
                  color: COLOR_THEME['buttonBackground'],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.01),
                    child: Text(
                      "Exit",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "DM Sans",
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
