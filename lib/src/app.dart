import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../services/Firebase/fireauth/fireauth.dart';
import 'login_signup/aadhar/aadhar_otp_page.dart';
import 'login_signup/aadhar/aadhar_page.dart';
import 'login_signup/details_page.dart';
import 'login_signup/intro_page.dart';
import 'login_signup/login_page.dart';
import 'login_signup/setup_complete_page.dart';
import 'login_signup/signup_page.dart';
import 'main/main_page.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MaterialApp(
      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'app',

      // Provide the generated AppLocalizations to the MaterialApp. This
      // allows descendant Widgets to display the correct translations
      // depending on the user's locale.
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],

      // Define a light and dark color theme. Then, read the user's
      // preferred ThemeMode (light, dark, or system default) from the
      // SettingsController to display the correct theme.
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,

      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            if (checkLoggedIn()) {}
            switch (routeSettings.name) {
              case MainPage.routeName:
                return const MainPage();
              case IntroPage.routeName:
                return const IntroPage();
              case LoginPage.routeName:
                return const LoginPage();
              case SignUpPage.routeName:
                return const SignUpPage();
              case DetailsPage.routeName:
                return const DetailsPage();
              case AadharPage.routeName:
                return const AadharPage();
              case AadharWebViewPage.routeName:
                return const AadharWebViewPage();
              case SetupCompletePage.routeName:
                return const SetupCompletePage();
              case '/licenses':
                return const LicensePage();

              default:
                return const IntroPage();
            }
          },
        );
      },
    );
  }
}
