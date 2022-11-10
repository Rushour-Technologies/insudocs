import 'package:flutter/material.dart';
import 'package:insudox_app/classes/policy_model.dart';
import 'package:insudox_app/screens/chat_page/messages.dart';
import 'package:insudox_app/screens/information_collection/have_insurance.dart';
import 'package:insudox_app/screens/information_collection/info_collection.dart';
import 'package:insudox_app/screens/requests_tab/components/requests_info_card.dart';
import 'package:insudox_app/services/Firebase/firestore/firestore.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  List<PolicyModel> policies = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
            right: screenWidth * 0.03, bottom: screenHeight * 0.015),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              // TODO: Add a new page to generate a new request
              // DETAILS: The page should have a form to fill in the details of the request
              // DETAILS: The page should have a button to submit the request

              MaterialPageRoute(
                builder: (context) =>
                    const InformationCollection(popBack: true),
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
      body: Center(
        child: FutureBuilder(
          future: getPolicies(),
          builder: (context, AsyncSnapshot<List<PolicyModel>> policies) {
            if (policies.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth / 40,
                      right: screenWidth / 40,
                      top: screenHeight / 50,
                      bottom: screenHeight / 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: policies.data!
                        .map((policy) => RequestsInfoCard(
                              policy: policy,
                            ))
                        .toList(),
                  ),
                ),
              );
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
