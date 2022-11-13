import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insudox/services/Firebase/firestore/firestore.dart';
import 'package:insudox/src/classes/client_info_model.dart';
import 'package:insudox/src/classes/insurance_enums.dart';
import 'package:insudox/src/classes/policy_model.dart';
import 'package:insudox/src/common_widgets/base_components.dart';
import 'package:insudox/src/main/tabs/incoming_requests/components.dart';
import 'package:insudox/src/main/tabs/incoming_requests/default.dart';

Widget saviourIncoming({
  required User user,
  required double screenWidth,
  required double screenHeight,
  required TextStyle noRequestStyle,
  required Function(Function()) setState,
}) {
  const bool protoTypeMode = false;

  return mainViewAppBar(
    width: screenWidth,
    height: screenHeight,
    name: user.displayName ?? user.email ?? '',
    page: 'CLIENT REQUESTS',
    child: Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.025),
      child: protoTypeMode
          ? Wrap(
              runSpacing: screenHeight * 0.02,
              spacing: screenWidth * 0.01,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: clientRequestInfoList.map(
                (requestStatus) {
                  return RequestCard(
                      clientRequestInfo: requestStatus, setState: setState);
                },
              ).toList(),
            )
          : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: getAllRequests(),
              builder: (context, snapshot) {
                print(snapshot.connectionState);
                if (snapshot.connectionState != ConnectionState.waiting) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isNotEmpty) {
                      return Wrap(
                          runSpacing: screenHeight * 0.02,
                          spacing: screenWidth * 0.01,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: snapshot.data!.docs.map((document) {
                            final Map<String, dynamic> policyJson =
                                document.data();

                            return RequestCard(
                              clientRequestInfo: ClientRequestInfo.fromMap(
                                map: policyJson,
                                requestId: document.id,
                              ),
                              setState: setState,
                            );
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
