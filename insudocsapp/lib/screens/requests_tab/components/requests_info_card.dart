import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insudox_app/classes/user_model.dart';
import 'package:insudox_app/drawer/components/drawer_card_field.dart';

class RequestsInfoCard extends StatefulWidget {
  const RequestsInfoCard({Key? key}) : super(key: key);

  @override
  State<RequestsInfoCard> createState() => _RequestsInfoCardState();
}

class _RequestsInfoCardState extends State<RequestsInfoCard> {
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
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            drawerCardField("Insurance Type", userModel.insuranceType,
                screenHeight, screenWidth),
            drawerCardField("Insurance Service", userModel.claimTrack,
                screenHeight, screenWidth),
            drawerCardField("Insurance Comapny name",
                userModel.insuranceCompanyName, screenHeight, screenWidth),
          ],
        ),
      ),
    );
  }
}
