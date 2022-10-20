import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insudox/src/common_widgets/base_components.dart';
import 'package:insudox/src/main/components/default.dart';
import 'package:insudox/src/main/tabs/incoming_requests/incoming_requests_page.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

Widget saviourClient({
  required types.Role role,
}) {
  return IncomingRequestPage(
    role: role,
  );
}
