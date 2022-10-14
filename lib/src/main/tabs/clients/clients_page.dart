import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:insudox/services/Firebase/fireauth/fireauth.dart';
import 'package:insudox/src/common_widgets/base_components.dart';
import 'package:insudox/src/main/components/default.dart';
import 'package:insudox/src/main/tabs/clients/components/client_table.dart';
import 'package:insudox/src/main/tabs/clients/components/notification_send_card.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key}) : super(key: key);

  final String tab = 'Clients';

  final String tabName = 'CLIENTS';

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

    return mainViewAppBar(
      width: screenWidth,
      height: screenHeight,
      name: user != null ? user!.displayName ?? user!.email : '',
      page: widget.tabName,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          defaultPadding(child: NotificationSendCard(), height: screenHeight),
          defaultPadding(child: ClientsTable(), height: screenHeight),
        ],
      ),
    );
  }
}
