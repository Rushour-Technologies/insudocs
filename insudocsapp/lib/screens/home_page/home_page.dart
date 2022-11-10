import 'package:flutter/material.dart';
import 'package:insudox_app/classes/user_model.dart';
import 'package:insudox_app/globals.dart';
import 'package:insudox_app/screens/home_page/components/play_yt_vid.dart';
import 'package:insudox_app/screens/home_page/components/request_values_card.dart';
import 'package:insudox_app/screens/home_page/components/testimony_carousel.dart';
import 'package:insudox_app/services/Firebase/firestore/firestore.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel userModel = UserModel.getModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDocumentReference().get().then((value) {
      UserModel.initializeFromMap(value.data()!);
      setState(() {});
    });
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

    List<bool> statusList = [true, true, false];
    LineStyle reachedLineStyle = const LineStyle(
      color: Colors.black,
      thickness: 2,
    );
    LineStyle notReachedLineStyle = const LineStyle(
      color: Colors.grey,
      thickness: 2,
    );

    IndicatorStyle reachedIndicatorStyle = IndicatorStyle(
      indicator: Container(
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
      ),
    );
    IndicatorStyle notReachedIndicatorStyle = IndicatorStyle(
      indicator: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );

    List<Map<String, dynamic>> vidMap = [
      {
        "title": "HEALTH INSURANCE",
        "desc":
            "Health insurance claim settlement is a procedure where a policyholder makes a request to his or her insurer in order to avail of the medical services listed under the health plan. A health insurance policyholder can either get reimbursed or can opt for direct cashless treatment. This video will help you understand both Cashless & Reimbursement Claim procedure in detail. Hope this will make your Health Insurance Claim Settlement Smoother & Hassle Free.",
        "link": "https://www.youtube.com/watch?v=FjT_lMTFciE",
      },
      {
        "title": "LIFE INSURANCE",
        "desc":
            "Life insurance is a method of income replacement. What matters is that the claim process remains smooth for the family. Most of the companies offer a smooth claim settlement but it’s important to be aware of the procedure to save yourself from the hassles at the time of filing a claim. In this video, we will look at how the Claim Settlement process works in Life Insurance Policy.",
        "link": "https://www.youtube.com/watch?v=FjT_lMTFciE",
      }
    ];

    Map<String, int> requestValueMap = {
      "Raised Requests": userModel.raisedRequests,
      "Current Requests": userModel.currentRequests,
      "Closed Requests": userModel.closedRequests,
    };

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.02, bottom: screenHeight * 0.01),
                    child: Text(
                      "Welcome!",
                      style: TextStyle(
                        fontFamily: "Cabin",
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "Track the status of your requests to file or track your claim with our verified services under InsuDox.\n",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Cabin",
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                  Stack(
                    children: [
                      Column(
                        children: [
                          TimelineTile(
                            isFirst: true,
                            endChild: Text(
                              "\n  Filing\n",
                              style: TextStyle(
                                  fontSize: screenWidth * 0.07,
                                  fontWeight: FontWeight.bold),
                            ),
                            afterLineStyle: (statusList[0])
                                ? reachedLineStyle
                                : notReachedLineStyle,
                            indicatorStyle: (statusList[0])
                                ? reachedIndicatorStyle
                                : notReachedIndicatorStyle,
                          ),
                          TimelineTile(
                            endChild: Text(
                              "\n  Tracking\n",
                              style: TextStyle(
                                  fontSize: screenWidth * 0.07,
                                  fontWeight: FontWeight.bold),
                            ),
                            afterLineStyle: (statusList[1])
                                ? reachedLineStyle
                                : notReachedLineStyle,
                            beforeLineStyle: (statusList[1])
                                ? reachedLineStyle
                                : notReachedLineStyle,
                            indicatorStyle: (statusList[1])
                                ? reachedIndicatorStyle
                                : notReachedIndicatorStyle,
                          ),
                          TimelineTile(
                            isLast: true,
                            endChild: Text(
                              "\n  Approved\n",
                              style: TextStyle(
                                  fontSize: screenWidth * 0.07,
                                  fontWeight: FontWeight.bold),
                            ),
                            beforeLineStyle: (statusList[2])
                                ? reachedLineStyle
                                : notReachedLineStyle,
                            afterLineStyle: (statusList[2])
                                ? reachedLineStyle
                                : notReachedLineStyle,
                            indicatorStyle: (statusList[2])
                                ? reachedIndicatorStyle
                                : notReachedIndicatorStyle,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          "assets/images/statusIndicatorImage.png",
                          width: screenWidth * 0.5,
                          height: screenHeight * 0.37,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.02, bottom: screenHeight * 0.01),
                    child: Text(
                      "All REQUESTS",
                      style: TextStyle(
                          fontFamily: "Cabin",
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff32324D)),
                    ),
                  ),
                  Row(
                    children: requestValueMap.keys.map((String key) {
                      return Expanded(
                        child: requestValueCard(key, requestValueMap[key] ?? 0),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.04),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Learn about claiming insurances!",
                        style: TextStyle(
                          fontFamily: "Cabin",
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: vidMap.map((vid) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.03),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                PlayVid(
                                  link: vid["link"],
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(screenWidth / 30),
                                  topRight: Radius.circular(screenWidth / 30),
                                ),
                                child: PlayVid(
                                  link: vid["link"],
                                ),
                              ),
                            ),
                            Container(
                              color: (vidMap.indexOf(vid) == 0)
                                  ? Color(0xFFFFE3D5)
                                  : Color(0xFF8D4130),
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth / 30,
                                  vertical: screenHeight / 60),
                              child: Column(
                                children: [
                                  Text(
                                    vid["title"],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: (vidMap.indexOf(vid) == 0)
                                          ? Colors.black
                                          : Colors.white,
                                      fontFamily: "Cabin",
                                      fontSize: screenWidth * 0.06,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.02),
                                    child: Text(
                                      vid["desc"],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: (vidMap.indexOf(vid) == 0)
                                            ? Colors.black
                                            : Colors.white,
                                        fontFamily: "Cabin",
                                        fontSize: screenWidth * 0.04,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.03),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Testimonials",
                        style: TextStyle(
                            fontFamily: "Cabin",
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.01, bottom: screenHeight * 0.2),
                    child: const TestimonyCarouselSlider(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
