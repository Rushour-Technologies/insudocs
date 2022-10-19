import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insudox/globals.dart';
import 'package:insudox/src/common_widgets/base_components.dart';
import 'package:insudox/src/main/tabs/home/components.dart';

Widget clientHome({
  required double screenWidth,
  required double screenHeight,
  required User user,
}) {
  return mainViewAppBar(
    width: screenWidth,
    height: screenHeight,
    name: user.displayName ?? user.email,
    page: 'DASHBOARD',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.025),
          child: Container(
            height: screenHeight * 0.3,
            decoration: BoxDecoration(
              color: GlobalColor.dashboard,
              borderRadius: BorderRadius.circular(screenHeight / 50),
            ),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/dashboard.png',
                    width: screenWidth * 0.15,
                    height: screenHeight * 0.225,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome Saviour!',
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: screenHeight * 0.035,
                          color: GlobalColor.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        child: Text(
                          'Explore, view, notify and manage all the clients and saviors on our InsuDox software using this portal. Accept the requests of incoming volunteers wanting to become saviors by checking their CV and work experience to select the best candidates to help file their claim.',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: screenHeight * 0.0275,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.025),
          child: ClientCard(),
        ),
        Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.025),
          child: Graph(),
        ),
      ],
    ),
  );
  ;
}
