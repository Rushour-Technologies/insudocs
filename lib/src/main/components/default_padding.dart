import 'package:flutter/material.dart';

Padding defaultPadding({required Widget child, required double height}) {
  return Padding(padding: EdgeInsets.only(top: height * 0.025), child: child);
}
