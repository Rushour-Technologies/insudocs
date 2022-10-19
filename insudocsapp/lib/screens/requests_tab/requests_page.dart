import 'package:flutter/material.dart';
import 'package:insudox_app/screens/chat_page/messages.dart';
import 'package:insudox_app/screens/requests_tab/components/requests_info_card.dart';
import 'package:insudox_app/services/Firebase/firestore/firestore.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDocumentCollection(collection: "policies").get().then((value) {
      value.docs.forEach((element) {
        print(element.data());
      });
    });
  }

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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
            top: screenHeight * 0.03, right: screenWidth * 0.03),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MessagesPage(),
              ),
            );
          },
          label: Text(
            "New",
            style: TextStyle(
              fontFamily: 'FigTree',
              fontWeight: FontWeight.bold,
              fontSize: screenWidth / 20,
            ),
          ),
          icon: Icon(
            Icons.add,
            size: screenWidth / 20,
          ),
        ),
      ),
      body: Align(alignment: Alignment.topCenter, child: RequestsInfoCard()),
    );
  }
}
