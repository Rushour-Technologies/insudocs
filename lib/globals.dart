import 'package:flutter/material.dart';

/// from 'foo' to 'Foo'
extension StringExtension on String {
  String get capitalized => this[0].toUpperCase() + substring(1);
}

/// Path to the app icon
const String APP_ICON = "assets/images/app_icon.png";

/// URL of the default profile picture
const String DEFAULT_PROFILE_PICTURE =
    "https://i.ibb.co/FgnFSQc/default-profile-picture.jpg";

/// Path to the Bottom Navigation Image Directory
const String BOTTOM_NAVIGATION_IMAGE_DIRECTORY =
    "assets/images/bottom_navigation_icons";

/// Path to the Image Directory
const String IMAGE_DIRECTORY = "assets/images";

/// Path to Login Type Image Directory
const String LOGIN_TYPES_IMAGE_DIRECTORY = '$IMAGE_DIRECTORY/login_types';

/// Server key
const String SERVER_KEY =
    "AAAAo6916H4:APA91bFyVDLcZVPtU7vw9xOXna6IgO0TZtlvE_a5xn9ztMDxUVVLrjVyEnT5NPNYa_erbknscGQFtMbsrBuRz4FzsEny0zJyuxHwuuCOcJiFucRH6hcElVLnIk7Ajxvt7D6COti2MpzW";

/// Class used to store all the color constants used in the app
class GlobalColor {
  static const Color primary = Color(0xFF3E3763);

  static const Color secondary = Color(0xFF615793);

  static const Color tertiary = Color(0xFFDBD3FF);

  static const List<Color> backgroundComponents = [
    Color(0xFFFFDBA4),
    Color(0xFFFFB3B3),
    Color(0xFFC1EFFF)
  ];

  static const List<Color> overview = [
    Color(0xFFFFB3B3),
    Color(0xFF9CFB8D),
    Color(0xFFFFC04C)
  ];

  static const Color white = Color(0xFFFFFFFF);

  static const Color black = Color(0xFF000000);

  static const Color background = Color(0xFFFFFFFF);

  static const Color buttonBg = Color(0xFF615793);

  static const Color buttonText = Color(0xFFFFFFFF);

  static const Color dashboard = Color(0xFFF8E3BB);

  static const Color graphBg = Color(0xFFC1EFFF);

  static const Color searchFieldText = Color(0xFF000000);

  static const Color searchFieldBg = Color(0xFF615793);

  static const Color formFieldText = Color(0xFF000000);

  static const Color formFieldHintText = Color(0xFF999999);

  static const Color formFieldShadowColor = Color(0xFFF4CB81);

  static const Color formFieldIconColor = Color(0xFFFFFFFF);

  static const Color drawerBg = Color(0xFF59BFFF);

  static const Color notificationBg = Color(0xFFFEF6E6);

  static const Color navigation = Color(0xFF615793);

  static const Color navigationSelected = Color(0xFFFFB01D);

  static const Color navigationUnselected = Color(0xFFFFFFFF);

  static const Color link = Color(0xFF0000FF);

  static const Color notificationTitle = Color(0xFF000000);

  static const Color transparent = Colors.transparent;

  static const Color green = Colors.lightGreen;

  static const Color red = Colors.redAccent;

  static const Color snackbarBg = GlobalColor.primary;

  static const Color snackbarText = GlobalColor.white;
}
