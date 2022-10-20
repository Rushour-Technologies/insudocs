import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:insudox/src/common_widgets/base_components.dart';
import 'package:insudox/src/main/components/default.dart';
import 'package:insudox/src/main/tabs/clients/components/client_table.dart';
import 'package:insudox/src/main/tabs/clients/components/notification_send_card.dart';

Widget superAdminClient({
  required User user,
  required double screenWidth,
  required double screenHeight,
}) {
  return mainViewAppBar(
    width: screenWidth,
    height: screenHeight,
    name: user.displayName ?? user.email ?? '',
    page: 'CLIENTS',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        defaultPadding(child: NotificationSendCard(), height: screenHeight),
        defaultPadding(child: ClientsTable(), height: screenHeight),
      ],
    ),
  );
}
