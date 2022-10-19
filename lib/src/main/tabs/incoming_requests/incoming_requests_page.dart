import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:insudox/globals.dart';
import 'package:insudox/services/Firebase/fireauth/fireauth.dart';
import 'package:insudox/services/Firebase/firestore/firestore.dart';
import 'package:insudox/src/classes/insurance_enums.dart';
import 'package:insudox/src/common_widgets/base_components.dart';
import 'package:insudox/src/main/tabs/incoming_requests/components.dart';

class IncomingRequestPage extends StatefulWidget {
  const IncomingRequestPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<IncomingRequestPage> createState() => _IncomingRequestPageState();
}

class _IncomingRequestPageState extends State<IncomingRequestPage> {
  late User? user;
  final bool protoTypeMode = false;

  @override
  void initState() {
    user = getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final noRequestStyle = TextStyle(
      color: GlobalColor.black,
      fontFamily: 'DM Sans',
      fontSize: screenHeight * 0.025,
    );
    return mainViewAppBar(
      width: screenWidth,
      height: screenHeight,
      name: user != null ? user!.displayName ?? user!.email : '',
      page: widget.title,
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.025),
        child: protoTypeMode
            ? Wrap(
                runSpacing: screenHeight * 0.02,
                spacing: screenWidth * 0.01,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: saviourRequestInfoList.map((requestStatus) {
                  return RequestCard(saviourRequestInfo: requestStatus);
                }).toList())
            : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: firestore
                    .collection('saviours')
                    .where('approvalStatus',
                        isEqualTo: ApprovalStatus.PENDING.data)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      print(snapshot.data!.docs.length);
                      if (snapshot.data!.docs.isNotEmpty) {
                        return Wrap(
                            runSpacing: screenHeight * 0.02,
                            spacing: screenWidth * 0.01,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: snapshot.data!.docs.map((e) {
                              final Map<String, dynamic> requestStatus =
                                  e.data();

                              return RequestCard(
                                  saviourRequestInfo:
                                      SaviourRequestInfo.fromMap(
                                          requestStatus));
                            }).toList());
                      } else {
                        return Center(
                          child: Text(
                            'No Requests',
                            style: noRequestStyle,
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: Text(
                          'No Requests',
                          style: noRequestStyle,
                        ),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
      ),
    );
  }
}

List<ClientRequestInfo> clientRequestInfoList = List.generate(
  20,
  (index) => const ClientRequestInfo(
    name: 'John Doe',
    insuranceType: 1,
    insuraceStatus: 1,
    email: 'pataderushikesh@gmail.com',
    reportLink: 'https://www.google.com',
    photoURL: DEFAULT_PROFILE_PICTURE,
    uid: 'sdf',
  ),
);

List<SaviourRequestInfo> saviourRequestInfoList = List.generate(
  20,
  (index) => SaviourRequestInfo(
    name: 'John Doe',
    email: 'water@gmail.com',
    photoURL: DEFAULT_PROFILE_PICTURE,
    adhaarNumber: '123456789012',
    gender: 'M',
    qualificationFileLink: 'https://www.google.com',
    experienceFileLink: 'https://www.google.com',
    experience: "2",
    universityName: 'IIT',
    uid: 'sdf',
    specialization: 'Heath Claim',
    qualification: 'B.Tech',
    approvalStatus: ApprovalStatus.PENDING.data,
  ),
);

class IncomingRequestInfo {
  final String name;
  final String email;
  final String photoURL;
  final String uid;

  const IncomingRequestInfo({
    required this.name,
    required this.email,
    required this.photoURL,
    required this.uid,
  });
}

class ClientRequestInfo extends IncomingRequestInfo {
  const ClientRequestInfo({
    required super.photoURL,
    required super.name,
    required this.insuranceType,
    required this.insuraceStatus,
    required super.email,
    required this.reportLink,
    required super.uid,
  });

  factory ClientRequestInfo.fromMap(Map<String, dynamic> map) =>
      ClientRequestInfo(
        email: map['email'] as String,
        name: map['name'] as String,
        insuraceStatus: map['insuranceStatus'] as int,
        insuranceType: map['insuranceType'] as int,
        photoURL: map['photoURL'] as String,
        reportLink: map['reportLink'] as String,
        uid: map['uid'] as String,
      );

  final int insuranceType;
  final int insuraceStatus;
  final String reportLink;
}

class SaviourRequestInfo extends IncomingRequestInfo {
  const SaviourRequestInfo({
    required super.name,
    required this.qualificationFileLink,
    required this.universityName,
    required this.experienceFileLink,
    required this.experience,
    required this.adhaarNumber,
    required this.gender,
    required super.email,
    required super.photoURL,
    required super.uid,
    required this.qualification,
    required this.specialization,
    required this.approvalStatus,
  });

  factory SaviourRequestInfo.fromMap(Map<String, dynamic> map) =>
      SaviourRequestInfo(
        name: map['name'] as String,
        qualification: map['qualification'] as String,
        specialization: map['specialization'] as String,
        qualificationFileLink: map['qualificationFileLink'] as String,
        universityName: map['universityName'] as String,
        experienceFileLink: map['experienceFileLink'] as String,
        experience: map['experience'] as String,
        adhaarNumber: map['maskedNumber'] as String,
        photoURL: map['photoURL'] as String,
        email: map['email'] as String,
        gender: map['gender'] as String,
        uid: map['uid'] as String,
        approvalStatus: map['approvalStatus'] as String,
      );

  final String universityName;
  final String qualificationFileLink;
  final String experienceFileLink;

  final String experience;
  final String adhaarNumber;
  final String gender;
  final String qualification;
  final String specialization;
  final String approvalStatus;
}
