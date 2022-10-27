import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  int currentRequests = 0;
  int closedRequests = 0;
  int raisedRequests = 0;
  UserModel({
    required this.currentRequests,
    required this.closedRequests,
    required this.raisedRequests,
  });

  UserModel.clear() {
    userModel.currentRequests = 0;
    userModel.closedRequests = 0;
    userModel.raisedRequests = 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'current requests': currentRequests,
      'closed requests': closedRequests,
      'raised requests': raisedRequests,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      currentRequests: map['current requests']?.toInt() ?? 0,
      closedRequests: map['closed requests']?.toInt() ?? 0,
      raisedRequests: map['raised requests']?.toInt() ?? 0,
    );
  }

  factory UserModel.initializeFromMap(Map<String, dynamic> map) {
    userModel.currentRequests = map['current requests']?.toInt() ?? 0;
    userModel.closedRequests = map['closed requests']?.toInt() ?? 0;
    userModel.raisedRequests = map['raised requests']?.toInt() ?? 0;
    return UserModel(
      currentRequests: map['current requests']?.toInt() ?? 0,
      closedRequests: map['closed requests']?.toInt() ?? 0,
      raisedRequests: map['raised requests']?.toInt() ?? 0,
    );
  }

  static final userModel = UserModel._internal();
  UserModel._internal();

  factory UserModel.getModel() => userModel;
}
