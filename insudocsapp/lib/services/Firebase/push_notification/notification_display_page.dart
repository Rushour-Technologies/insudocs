// Notification display page from notificationModel

import 'package:flutter/material.dart';
import 'package:insudox_app/classes/language.dart';
import 'package:insudox_app/common_appbar/common_appbar.dart';
import 'package:insudox_app/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insudox_app/services/Firebase/firestore/firestore.dart';

class NotificationDisplayPage extends StatelessWidget {
  const NotificationDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
      appBar: commonAppBar(
          title: Text("Notifications"),
          scaffoldKey: scaffoldKey,
          screenWidth: screenWidth,
          screenHeight: screenHeight),
      body: StreamBuilder(
        stream: userDocumentCollection(collection: 'messages').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return ListTile(
                title: Text((document.data() as Map<String, dynamic>)['title']),
                subtitle:
                    Text((document.data() as Map<String, dynamic>)['body']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
