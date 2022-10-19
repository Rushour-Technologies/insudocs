import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:insudox/src/common_widgets/base_components.dart';
import 'package:insudox/globals.dart';
import 'package:insudox/src/main/tabs/home/components.dart';
import 'package:insudox/services/Firebase/fireauth/fireauth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User? user;
  bool? isStateSet = false;

  @override
  void initState() {
    user = getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = getCurrentUser();

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return mainViewAppBar(
      width: screenWidth,
      height: screenHeight,
      name: user != null ? user!.displayName ?? user!.email : '',
      page: 'DASHBOARD',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.025),
            child: Container(
              height: screenHeight * 0.3,
              // width: screenWidth * 0.6,
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
                          'Welcome Super Admin!',
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
  }
}
