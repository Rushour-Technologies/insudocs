import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:insudox_app/globals.dart';
import 'package:insudox_app/login_signup/aadhar_login.dart';
import 'package:insudox_app/login_signup/login.dart';
import 'package:insudox_app/login_signup/signup.dart';
import 'package:insudox_app/screens/information_collection/have_insurance.dart';
import 'package:insudox_app/screens/main_page.dart';
import 'package:insudox_app/screens/splash/splash.dart';
import 'package:insudox_app/screens/verification&details/mobileVerification/phone_auth.dart';
import 'package:insudox_app/screens/walkthrough/walkthrough.dart';
import 'package:insudox_app/services/Firebase/firebase_options.dart';
import 'package:insudox_app/services/Firebase/push_notification/push_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  await PushNotificationService().setupInteractedMessage();
  // print('TOKEN : ${await FirebaseMessaging.instance.getToken()}');
  // CollegeExtractionModel collegeExtractionModel = CollegeExtractionModel.getModel();
  // collegeExtractionModel.fetchCollegeInfo();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

  runApp(const MyApp());
}

void testMain(Widget screen) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  await PushNotificationService().setupInteractedMessage();
  // print('TOKEN : ${await FirebaseMessaging.instance.getToken()}');
  // CollegeExtractionModel collegeExtractionModel = CollegeExtractionModel.getModel();
  // collegeExtractionModel.fetchCollegeInfo();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

  runApp(MyApp(
    screen: screen,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.screen = const Splash()}) : super(key: key);
  final Widget screen;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: DEFAULT_TEXT_THEME,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: COLOR_THEME['primary'],
              secondary: COLOR_THEME['secondary'],
            ),
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              buttonColor: const Color(0xff615793),
            ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: DEFAULT_TEXT_THEME,
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => screen,
        '/main': (context) => const MainPage(),
        '/wt': (context) => const WalkThrough(),
        '/mobno': (context) => const PhoneAuth(),
        '/aadharAuth': (context) => const AadharLoginPage(),
        '/login': (context) => const Login(),
        '/aadhar': (context) => const AadharLoginPage(),
        '/signup': (context) => const Signup(),
        '/infoCollection': (context) => const HaveInsurance(),
      },
    );
  }
}
