import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insudox_app/classes/policy_model.dart';
import 'package:insudox_app/classes/user_model.dart';
import 'package:insudox_app/drawer/components/drawer_card_field.dart';
import 'package:insudox_app/globals.dart';

class RequestsInfoCard extends StatelessWidget {
  const RequestsInfoCard({Key? key, required this.policy}) : super(key: key);

  /// The policy information to be displayed
  final PolicyModel policy;

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
      color: GlobalColor.secondary,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            drawerCardField(
              "Insurance Type",
              policy.insuranceType.name,
              screenHeight,
              screenWidth,
            ),
            drawerCardField(
              "Insurance Service",
              policy.insuranceStatus.name,
              screenHeight,
              screenWidth,
            ),
            drawerCardField(
              "Insurance Comapny name",
              policy.insuranceCompanyName,
              screenHeight,
              screenWidth,
            ),
            drawerCardField(
              "Request Status",
              policy.requestStatus.name,
              screenHeight,
              screenWidth,
            ),
          ],
        ),
      ),
    );
  }
}
