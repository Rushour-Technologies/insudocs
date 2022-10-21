import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insudox/globals.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:insudox/services/Firebase/fireauth/fireauth.dart';

Padding defaultPadding({required Widget child, required double height}) {
  return Padding(padding: EdgeInsets.only(top: height * 0.025), child: child);
}

List<BoxShadow> defaultBoxShadow() {
  return [
    BoxShadow(
      color: GlobalColor.black.withOpacity(0.5),
      spreadRadius: 1,
      blurRadius: 1,
      offset: const Offset(0, 2),
    ),
  ];
}

Future<types.Role> getRole() async {
  types.Role role;
  String tempRole = await checkRole();
  if (tempRole == "saviour") {
    role = types.Role.saviour;
  } else if (tempRole == "superadmin") {
    role = types.Role.superadmin;
  } else {
    role = types.Role.none;
  }
  return role;
}

void setPageTitle(String title, BuildContext context) {
  SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
    label: title,
    primaryColor: Theme.of(context).primaryColor.value,
  ));
}
