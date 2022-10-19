import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insudox_app/screens/walkthrough/wtpages/wtone.dart';
import 'package:insudox_app/screens/walkthrough/wtpages/wtthree.dart';
import 'package:insudox_app/screens/walkthrough/wtpages/wttwo.dart';

class WalkThrough extends StatefulWidget {
  /// A WalkThrough to give initial information about the app and give options to move further.
  const WalkThrough({Key? key}) : super(key: key);

  @override
  State<WalkThrough> createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough>
    with TickerProviderStateMixin {
  int wtPageNumber = 1;
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this, upperBound: 1)
      ..forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      floatingActionButton: (wtPageNumber != 3)
          ? SizedBox(
              width: screenWidth * 0.9,
              height: screenHeight * 0.06,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff615793),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenHeight * 0.01),
                  ),
                ),
                onPressed: () {
                  wtPageNumber++;
                  setState(() {});
                  _animationController = AnimationController(
                      duration: const Duration(milliseconds: 500),
                      vsync: this,
                      upperBound: wtPageNumber.toDouble())
                    ..forward(from: wtPageNumber - 1);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "NEXT",
                      style: TextStyle(
                        fontFamily: 'Cabin',
                        fontSize: screenWidth * 0.06,
                        color: const Color(0xffA5A5BA),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.28),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        color: const Color(0xffA5A5BA),
                        size: screenWidth * 0.07,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Wrap(
              children: [
                SizedBox(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.06,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff615793),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(screenHeight * 0.01),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                        fontFamily: 'Cabin',
                        fontSize: screenWidth * 0.06,
                        color: const Color(0xffA5A5BA),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.04,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: "Nunito",
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xff1A67F9),
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              height: screenHeight,
              width: screenWidth,
              child: AnimatedCrossFade(
                duration: const Duration(seconds: 1),
                firstChild: SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                  child: (wtPageNumber == 1)
                      ? const WTOne()
                      : const WTThree(), // This trick is used to get animation to more than one page as this make wttree take position of wtone when moving forward and currently at wttwo and vice-versa.
                ),
                secondChild: SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                  child: const WTTwo(),
                ),
                crossFadeState: (wtPageNumber == 1 || wtPageNumber == 3)
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
            ),
            Positioned(
              top: 0,
              width: screenWidth * 0.6,
              right: screenWidth * 0.2,
              child: SafeArea(
                child: Container(
                  width: screenWidth * 0.6,
                  padding: EdgeInsets.only(top: screenHeight * 0.52),
                  child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (_, __) {
                        return SliderTheme(
                          data: SliderThemeData(
                            inactiveTrackColor: Colors.grey[200],
                            activeTrackColor: const Color(0xff615793),
                            trackHeight: screenHeight * 0.007,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 0,
                            ),
                            thumbColor: Colors.transparent,
                            overlayColor: Colors.transparent,
                            overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 0,
                            ),
                          ),
                          child: Slider(
                            value: _animationController.value,
                            min: 0,
                            max: 3,
                            onChanged: (value) {},
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
