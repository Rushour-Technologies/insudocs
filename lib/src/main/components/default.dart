import 'package:flutter/material.dart';
import 'package:insudox/globals.dart';

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
