import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insudox/src/common_widgets/base_components.dart';
import 'package:insudox/globals.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  /// The route name for this page.
  static const routeName = '/ ';

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return baseBackground(
      height: screenHeight,
      width: screenWidth,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A one-stop personalized guide to navigate all your career related confusions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenHeight * 0.03,
                fontFamily: 'DM Sans',
              ),
            ),
            Image.asset(
              APP_ICON,
              width: screenWidth * 0.2,
              height: screenWidth * 0.2,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: GlobalColor.secondary,
                fixedSize: Size(screenWidth * 0.35, screenHeight * 0.055),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    screenHeight * 0.01,
                  ),
                ),
              ),
              onPressed: () async {
                print('SIGN UP PRESSED');
                Navigator.of(context).restorablePushNamed('/signup');
              },
              child: Text(
                'SIGN UP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenHeight * 0.035,
                  fontFamily: 'DM Sans',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.045,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.01,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).restorablePushNamed('/login');
                  },
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,

                      // fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: screenWidth * 0.01,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
