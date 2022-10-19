import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insudox_app/common_widgets/backgrounds/bigOneSmallOneBg.dart';
import 'package:insudox_app/drawer/components/drawer_listtile.dart';
import 'package:insudox_app/drawer/drawer_tabs/faqs/faq.dart';
import 'package:insudox_app/drawer/drawer_tabs/send_feedback/send_feedback.dart';
import 'package:insudox_app/drawer/drawer_user_info_card.dart';

class CommonDrawer extends StatefulWidget {
  const CommonDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  List<String> drawerTabs = [
    "Licenses",
    "FAQs",
    "Send Feedback",
    "Report Problems",
  ];

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // leading: const SizedBox.shrink(),
        toolbarHeight: screenHeight * 0.5,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: SizedBox(
          width: screenWidth,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.arrow_back_ios_new_rounded)),
            ),
            const DrawerUserInfoCard()
          ]),
        ),
      ),
      body: Container(
        color: Colors.white,
        height: screenHeight,
        width: screenWidth,
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
              height: screenHeight,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.007),
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.02),
                            child: Column(
                              children: drawerTabs
                                  .map(
                                    (drawerOption) => Padding(
                                      padding: EdgeInsets.only(
                                          bottom: screenHeight * 0.015),
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05),
                                        ),
                                        child: drawerListTile(
                                          screenWidth: screenWidth,
                                          title: drawerOption,
                                          icon: (drawerOption == "Licenses")
                                              ? Icons.file_copy
                                              : (drawerOption == "FAQs")
                                                  ? CupertinoIcons
                                                      .question_square
                                                  : (drawerOption ==
                                                          "Send Feedback")
                                                      ? Icons.feedback_outlined
                                                      : CupertinoIcons
                                                          .exclamationmark_octagon,
                                          onTap: (drawerOption == "FAQs")
                                              ? () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Faq()));
                                                }
                                              : (drawerOption ==
                                                      "Send Feedback")
                                                  ? () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const SendFeedback()));
                                                    }
                                                  : (drawerOption == "Licenses")
                                                      ? () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const LicensePage()));
                                                        }
                                                      : () {},
                                          index:
                                              drawerTabs.indexOf(drawerOption),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
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
