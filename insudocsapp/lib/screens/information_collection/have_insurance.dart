import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insudox_app/common_widgets/backgrounds/bigOneSmallOneBg.dart';

import 'package:insudox_app/common_widgets/no_insurance_dialogbox.dart';
import 'package:insudox_app/globals.dart';
import 'package:insudox_app/screens/information_collection/info_collection.dart';

class HaveInsurance extends StatefulWidget {
  const HaveInsurance({Key? key}) : super(key: key);

  @override
  State<HaveInsurance> createState() => _HaveInsuranceState();
}

class _HaveInsuranceState extends State<HaveInsurance> {
  String broughtInsurance = "";

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
      resizeToAvoidBottomInset: false,
      floatingActionButton: SizedBox(
        width: screenWidth * 0.9,
        height: screenHeight * 0.06,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff615793),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenHeight * 0.01),
            ),
          ),
          onPressed: () async {
            Navigator.pushNamed(context, '/postLoginMain');
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
              child: const BigOneSmallOneBG(),
            ),
            Positioned(
              top: 0,
              width: screenWidth,
              bottom: 0,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.007),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: Text(
                              "BACK",
                              style: TextStyle(
                                fontFamily: "Cabin",
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff615793),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.05),
                          child: Image.asset(
                            '$POST_LOGIN_IMAGES/studentPLInfoCollectWt.png',
                            width: screenWidth * 0.85,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: screenHeight * 0.1,
                          ),
                          child: Text(
                            "Do you have any insurance yet?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: screenWidth * 0.08,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.001,
                              bottom: screenHeight * 0.1),
                          child: Wrap(children: [
                            RadioListTile(
                              title: const Text("Yes"),
                              value: "Yes",
                              groupValue: broughtInsurance,
                              onChanged: (value) async {
                                setState(() {
                                  broughtInsurance = "Yes";
                                });
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            InformationCollection()));
                              },
                            ),
                            RadioListTile(
                              title: const Text("No"),
                              value: "No",
                              groupValue: broughtInsurance,
                              onChanged: (value) async {
                                setState(() {
                                  broughtInsurance = "No";
                                });
                                await Navigator.of(context).push(
                                  PageRouteBuilder(
                                    barrierDismissible: true,
                                    barrierColor: Colors.black.withOpacity(0.5),
                                    opaque: false,
                                    transitionDuration:
                                        const Duration(milliseconds: 750),
                                    pageBuilder: (_, __, ___) =>
                                        const NoInsuranceDialogBox(),
                                  ),
                                );
                              },
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
