import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String claimTrack = "";
  String insuranceCompanyName = "";
  String insuranceType = "";
  UserModel({
    required this.claimTrack,
    required this.insuranceCompanyName,
    required this.insuranceType,
  });

  UserModel.clear() {
    userModel.claimTrack = "";
    userModel.insuranceCompanyName = "";
    userModel.insuranceType = "";
  }

  Map<String, dynamic> toMap() {
    return {
      'claimTrack': claimTrack,
      'insuranceCompanyName': insuranceCompanyName,
      'insuranceType': insuranceType,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      claimTrack: map['claimTrack'] ?? '',
      insuranceCompanyName: map['insuranceCompanyName'] ?? '',
      insuranceType: map['insuranceType'] ?? '',
    );
  }

  factory UserModel.initializeFromMap(Map<String, dynamic> map) {
    userModel.claimTrack = map['claimTrack'] ?? '';
    userModel.insuranceCompanyName = map['insuranceCompanyName'] ?? '';
    userModel.insuranceType = map['insuranceType'] ?? '';
    return UserModel(
      claimTrack: map['claimTrack'] ?? '',
      insuranceCompanyName: map['insuranceCompanyName'] ?? '',
      insuranceType: map['insuranceType'] ?? '',
    );
  }

  static final userModel = UserModel._internal();
  UserModel._internal();

  factory UserModel.getModel() => userModel;
}
