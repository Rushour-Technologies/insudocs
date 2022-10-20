import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:insudox/globals.dart';
import 'package:insudox/services/Firebase/fireauth/fireauth.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:insudox/src/main/tabs/incoming_requests/saviour_side.dart';
import 'package:insudox/src/main/tabs/incoming_requests/super_admin_side.dart';

class IncomingRequestPage extends StatefulWidget {
  const IncomingRequestPage({
    Key? key,
    required this.role,
  }) : super(key: key);

  final types.Role role;

  @override
  State<IncomingRequestPage> createState() => _IncomingRequestPageState();
}

class _IncomingRequestPageState extends State<IncomingRequestPage> {
  late User? user;

  @override
  void initState() {
    user = getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final noRequestStyle = TextStyle(
      color: GlobalColor.black,
      fontFamily: 'DM Sans',
      fontSize: screenHeight * 0.025,
    );

    return widget.role == types.Role.saviour
        ? saviourIncoming(
            user: user!,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            noRequestStyle: noRequestStyle)
        : superAdminIncoming(
            user: user!,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            noRequestStyle: noRequestStyle,
          );
  }
}
