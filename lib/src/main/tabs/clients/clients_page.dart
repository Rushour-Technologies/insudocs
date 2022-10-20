import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insudox/services/Firebase/fireauth/fireauth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:insudox/src/main/tabs/clients/saviour_side.dart';
import 'package:insudox/src/main/tabs/clients/super_admin_side.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key, required this.role}) : super(key: key);
  final types.Role role;
  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
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

    return widget.role == types.Role.saviour
        ? saviourClient(
            role: widget.role,
          )
        : superAdminClient(
            user: user!,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          );
  }
}
