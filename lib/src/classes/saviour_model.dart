import 'dart:convert';

class SaviourModel {
  String name;
  String email;
  String phone;
  String qualification;
  String universityName;
  String specialization;
  bool priorExperience;
  int yearsOfExperience;
  String adhaarNumber;
  String gender;
  int closedClients;
  int currentClients;
  int pendingRequests;
  SaviourModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.qualification,
    required this.universityName,
    required this.specialization,
    required this.priorExperience,
    required this.yearsOfExperience,
    required this.adhaarNumber,
    required this.gender,
    required this.closedClients,
    required this.currentClients,
    required this.pendingRequests,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'qualification': qualification,
      'universityName': universityName,
      'specialization': specialization,
      'priorExperience': priorExperience,
      'yearsOfExperience': yearsOfExperience,
      'adhaarNumber': adhaarNumber,
      'gender': gender,
      'closedClients': closedClients,
      'currentClients': currentClients,
      'pendingRequests': pendingRequests,
    };
  }

  factory SaviourModel.fromMap(Map<String, dynamic> map) {
    return SaviourModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      qualification: map['qualification'] ?? '',
      universityName: map['universityName'] ?? '',
      specialization: map['specialization'] ?? '',
      priorExperience: map['priorExperience'] ?? false,
      yearsOfExperience: map['yearsOfExperience']?.toInt() ?? 0,
      adhaarNumber: map['adhaarNumber'] ?? '',
      gender: map['gender'] ?? '',
      closedClients: map['closedClients']?.toInt() ?? 0,
      currentClients: map['currentClients']?.toInt() ?? 0,
      pendingRequests: map['pendingRequests']?.toInt() ?? 0,
    );
  }
}
