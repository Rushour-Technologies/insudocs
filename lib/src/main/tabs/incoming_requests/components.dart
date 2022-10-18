import 'package:flutter/material.dart';
import 'package:insudox/globals.dart';
import 'package:insudox/src/classes/insurance_enums.dart';
import 'package:insudox/src/main/tabs/incoming_requests/incoming_requests_page.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    this.clientRequestInfo,
    this.saviourRequestInfo,
  });
  final ClientRequestInfo? clientRequestInfo;
  final SaviourRequestInfo? saviourRequestInfo;

  bool get isClient => clientRequestInfo != null;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.175,
      height: screenHeight * (isClient ? 0.45 : 0.55),
      decoration: BoxDecoration(
        color: GlobalColor.white,
        borderRadius: BorderRadius.circular(screenWidth / 180),
        boxShadow: [
          BoxShadow(
            color: GlobalColor.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
        child: isClient
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  profileCard(
                    name: clientRequestInfo!.name,
                    photoURL: clientRequestInfo!.photoURL,
                    width: screenWidth * 0.05,
                    height: screenHeight * 0.15,
                  ),
                  SizedBox(
                    height: screenHeight * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        headingInfo(
                          width: screenWidth,
                          height: screenHeight,
                          heading: 'UID',
                          info: clientRequestInfo!.uid,
                        ),
                        headingInfo(
                          width: screenWidth,
                          height: screenHeight,
                          heading: 'Insurance Type',
                          info: InsuranceType
                              .values[clientRequestInfo!.insuranceType].data,
                        ),
                        headingInfo(
                          width: screenWidth,
                          height: screenHeight,
                          heading: 'Insurance Status',
                          info: InsuranceStatus
                              .values[clientRequestInfo!.insuraceStatus].data,
                        ),
                        acceptDeny(height: screenHeight, width: screenWidth),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  profileCard(
                    name: saviourRequestInfo!.name,
                    photoURL: saviourRequestInfo!.photoURL,
                    width: screenWidth * 0.05,
                    height: screenHeight * 0.15,
                  ),
                  SizedBox(
                    height: screenHeight * 0.35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        headingInfo(
                          width: screenWidth,
                          height: screenHeight,
                          heading: 'UID',
                          info: saviourRequestInfo!.uid,
                        ),
                        headingInfo(
                          width: screenWidth,
                          height: screenHeight,
                          heading: 'Qualification',
                          info: saviourRequestInfo!.qualificationSummary,
                        ),
                        headingInfo(
                          width: screenWidth,
                          height: screenHeight,
                          heading: 'Specialization',
                          info: saviourRequestInfo!.specilizationSummary,
                        ),
                        headingInfo(
                          width: screenWidth,
                          height: screenHeight,
                          heading: 'Experience',
                          info:
                              "${saviourRequestInfo!.yearsOfExperience} years",
                        ),
                        downloadButton(
                          height: screenHeight,
                          width: screenWidth,
                          title: 'Qualification File',
                          url: saviourRequestInfo!.qualificationFileLink,
                        ),
                        downloadButton(
                          height: screenHeight,
                          width: screenWidth,
                          title: 'Specilization File',
                          url: saviourRequestInfo!.specializationFileLink,
                        ),
                        acceptDeny(height: screenHeight, width: screenWidth),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

Widget headingInfo({
  required double width,
  required double height,
  required String heading,
  required String info,
}) {
  return Container(
    width: width * 0.1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: TextStyle(
            color: GlobalColor.black,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.bold,
            fontSize: height * 0.02,
          ),
        ),
        Text(
          info,
          style: TextStyle(
            color: GlobalColor.black,
            fontFamily: 'DM Sans',
            fontSize: height * 0.015,
          ),
        ),
      ],
    ),
  );
}

Widget profileCard({
  required double width,
  required double height,
  required String name,
  required String photoURL,
}) {
  return Container(
    width: width,
    height: height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(photoURL),
        ),
        Text(
          name,
          style: TextStyle(
            color: GlobalColor.black,
            fontFamily: 'DM Sans',
            fontSize: width * 0.2,
          ),
        ),
      ],
    ),
  );
}

Widget acceptDeny({required double height, required double width}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: GlobalColor.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 120),
          ),
          fixedSize: Size(width * 0.07, height * 0.01),
        ),
        onPressed: () {},
        icon: Icon(
          Icons.check_rounded,
        ),
        label: Text(
          'Accept',
          style: TextStyle(
            color: GlobalColor.white,
            fontFamily: 'DM Sans',
            fontSize: width * 0.0085,
          ),
        ),
      ),
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(width * 0.07, height * 0.01),
          primary: GlobalColor.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 120),
          ),
        ),
        onPressed: () {},
        icon: Icon(
          Icons.close_rounded,
        ),
        label: Text(
          'Deny',
          style: TextStyle(
            color: GlobalColor.white,
            fontFamily: 'DM Sans',
            fontSize: width * 0.0085,
          ),
        ),
      ),
    ],
  );
}

Widget downloadButton(
    {required double height,
    required double width,
    required String title,
    required String url}) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      primary: GlobalColor.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(height / 120),
      ),
      fixedSize: Size(width * 0.04, height * 0.01),
    ),
    onPressed: () async {
      await canLaunchUrlString(url)
          ? await launchUrlString(url)
          : throw 'Could not launch $url';
    },
    icon: Icon(
      Icons.download_rounded,
    ),
    label: Text(
      title,
      style: TextStyle(
        color: GlobalColor.white,
        fontFamily: 'DM Sans',
        fontSize: width * 0.01,
      ),
    ),
  );
}
