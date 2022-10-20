import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insudox/globals.dart';

import 'package:insudox/services/Firebase/fireauth/fireauth.dart';
import 'package:insudox/src/main/components/default.dart';
import 'package:insudox/src/main/tabs/home/saviour_side.dart';
import 'package:insudox/src/main/tabs/home/super_admin_side.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.role}) : super(key: key);
  final types.Role role;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User? user;

  @override
  void initState() {
    user = getCurrentUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = getCurrentUser();

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return widget.role == types.Role.saviour
        ? saviourHome(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            user: user!,
          )
        : superAdminHome(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            user: user!,
          );
  }
}
