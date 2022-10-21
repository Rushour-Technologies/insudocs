import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insudox/src/classes/aadhar.dart';

import 'package:insudox/src/common_widgets/base_components.dart';
import 'package:insudox/globals.dart';
import 'package:insudox/services/AadharOTP/otp_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:insudox/services/Firebase/fireauth/fireauth.dart';
import 'package:insudox/services/Firebase/firestore/firestore.dart';

import 'package:url_launcher/url_launcher_string.dart';

class AadharWebViewPage extends StatefulWidget {
  const AadharWebViewPage({Key? key}) : super(key: key);

  /// The route name for this page.
  static const routeName = '/aadhar_otp';

  @override
  State<AadharWebViewPage> createState() => _AadharWebViewPageState();
}

class _AadharWebViewPageState extends State<AadharWebViewPage> {
  int countdown = 120;
  final Aadhar aadhar = Aadhar();
  final AadharAuthenticationNotifier authenticationNotifier =
      AadharAuthenticationNotifier();

  bool done = false;

  String requestID = "", link = "", number = "", otp = "";
  SnackBar aadharLoginStatus(bool isSuccess) => SnackBar(
        content: Text(
          "Aadhar Login ${isSuccess ? 'Success' : 'Failed'}",
          style: TextStyle(
            fontFamily: 'Cabin',
            fontSize: MediaQuery.of(context).size.width * 0.02,
            color: GlobalColor.buttonText,
          ),
        ),
        backgroundColor: GlobalColor.buttonBg,
      );

  aadharListener() async {
    if (authenticationNotifier.isAuthenticated && !done) {
      done = true;
      print("Aadhar is authenticated");
      if (await checkAadhar()) {
        return Navigator.of(context).restorablePushNamed('/main');
      }
      await saviourDocumentReference().update({'aadharFilled': true});

      countdown = authenticationNotifier.secondsRemaining;
      setState(() {});

      // Show authenticated snackbar
      ScaffoldMessenger.of(context).showSnackBar(
          aadharLoginStatus(authenticationNotifier.isAuthenticated));
      Map<String, dynamic> temp =
          (await saviourDocumentReference().get()).data()!;
      User user = getCurrentUser()!;
      Map<String, dynamic> data = {
        getCurrentUserId(): {
          'name': user.displayName ??
              "${(temp['firstName'] as String).capitalized} ${(temp['lastName'] as String).capitalized}",
          'qualificationFileLink': temp['qualificationFileLink'],
          'experienceFileLink': temp['experienceFileLink'],
          'experience': temp['experience'],
          'photoURL': temp['photoURL'] ?? user.photoURL,
          'qualification': temp['qualification'],
          'specialization': temp['specialization'],
          'universityName': temp['universityName'],
        }
      };
      // print(data);

      await setPublicData(
        data: data,
        role: types.Role.saviour,
      );
      Navigator.of(context).restorablePushNamedAndRemoveUntil(
          '/setup_complete', (route) => false);
    } else if (!authenticationNotifier.isAuthenticated &&
        authenticationNotifier.secondsRemaining == 0 &&
        !done) {
      print("Aadhar was not authenticated");
      done = true;
      ScaffoldMessenger.of(context).showSnackBar(
          aadharLoginStatus(authenticationNotifier.isAuthenticated));

      Navigator.of(context)
          .restorablePushNamedAndRemoveUntil('/aadhar', (route) => false);
    }
  }

  void notifyOnAuthenticated() {
    authenticationNotifier.addListener(aadharListener);
  }

  Future<void> _launchUrl() async {
    if (!await launchUrlString(link)) {
      throw 'Could not launch $link';
    }
  }

  @override
  void initState() {
    requestID = aadhar.id;
    number = aadhar.number;
    link = aadhar.link;
    notifyOnAuthenticated();
    _launchUrl();

    super.initState();
  }

  @override
  void dispose() {
    authenticationNotifier.removeListener(aadharListener);
    authenticationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return detailsBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Authenticating your Aadhar Number',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cabin',
                fontSize: screenWidth * 0.03,
                color: GlobalColor.white,
              ),
            ),
            Text(
              'Valid for $countdown seconds',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cabin',
                fontSize: screenWidth * 0.02,
                color: GlobalColor.white,
              ),
            ),
          ],
        ),
      ),
      width: screenWidth,
      height: screenHeight,
    );
  }
}
