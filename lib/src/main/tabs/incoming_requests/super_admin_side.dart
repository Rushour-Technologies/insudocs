import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insudox/services/Firebase/firestore/firestore.dart';
import 'package:insudox/src/classes/insurance_enums.dart';
import 'package:insudox/src/classes/saviour_info_model.dart';
import 'package:insudox/src/common_widgets/base_components.dart';
import 'package:insudox/src/main/tabs/incoming_requests/components.dart';
import 'package:insudox/src/main/tabs/incoming_requests/default.dart';

Widget superAdminIncoming({
  required User user,
  required double screenWidth,
  required double screenHeight,
  required TextStyle noRequestStyle,
}) {
  const bool protoTypeMode = false;

  return mainViewAppBar(
    width: screenWidth,
    height: screenHeight,
    name: user.displayName ?? user.email ?? '',
    page: 'SAVIOURS REQUESTS',
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
                            final Map<String, dynamic> requestStatus = e.data();

                            return RequestCard(
                                saviourRequestInfo:
                                    SaviourRequestInfo.fromMap(requestStatus));
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
