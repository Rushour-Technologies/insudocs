import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insudox_app/classes/user_model.dart';
import 'package:insudox_app/drawer/components/drawer_card_field.dart';
import 'package:insudox_app/globals.dart';
import 'package:insudox_app/services/Firebase/fireauth/fireauth.dart';

class DrawerUserInfoCard extends StatefulWidget {
  const DrawerUserInfoCard({Key? key}) : super(key: key);

  @override
  State<DrawerUserInfoCard> createState() => _DrawerUserInfoCardState();
}

class _DrawerUserInfoCardState extends State<DrawerUserInfoCard> {
  UserModel userModel = UserModel.getModel();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      color: const Color(0xFF3E3763),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth / 7,
              height: screenWidth / 7,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    DEFAULT_PROFILE_PICTURE,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: Text(
                _auth.currentUser?.displayName?.toUpperCase() ?? "",
                softWrap: true,
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: screenHeight * 0.025,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: screenHeight * 0.02),
            //   child: (userDetailsModelOne.role != "")
            //       ? Text(
            //           "${userDetailsModelOne.role[0].toUpperCase()}${userDetailsModelOne.role.substring(1).toLowerCase()}",
            //           softWrap: true,
            //           style: TextStyle(
            //             fontFamily: "DM Sans",
            //             fontSize: screenHeight * 0.025,
            //             // fontWeight: FontWeight.bold,
            //             color: Colors.grey,
            //           ),
            //         )
            //       : Text(
            //           userDetailsModelOne.role,
            //           softWrap: true,
            //           style: TextStyle(
            //             fontFamily: "DM Sans",
            //             fontSize: screenHeight * 0.025,
            //             // fontWeight: FontWeight.bold,
            //             color: Colors.grey,
            //           ),
            //         ),
            // ),
            drawerCardField("Insurance Type", userModel.insuranceType,
                screenHeight, screenWidth),
            drawerCardField("Insurance Service", userModel.claimTrack,
                screenHeight, screenWidth),
            drawerCardField("Insurance Comapny name",
                userModel.insuranceCompanyName, screenHeight, screenWidth),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.01),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 3,
                    color: const Color(0xFFF94141),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.015),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.006,
                          horizontal: screenWidth * 0.1),
                      child: GestureDetector(
                        onTap: () async {
                          if (await checkLoggedIn()) {
                            await signOut();
                            await signOutGoogle();
                            UserModel.clear();
                          }
                          await Navigator.pushNamedAndRemoveUntil(
                              context, "/signup", ((route) => false));
                        },
                        child: Text(
                          "Logout",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: screenHeight * 0.03,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
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
