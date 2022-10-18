import 'dart:convert';

class SaviourModel {
  final String name;
  final String qualification;
  final String qualificationFileLink;
  final String universityName;
  final String specialization;
  final String specializationFileLink;
  final bool priorExperience;
  final int yearsOfExperience;
  final String adhaarNumber;
  final String gender;
  final int closedClients;
  final int currentClients;
  final int pendingRequests;
  const SaviourModel({
    required this.name,
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
    required this.qualificationFileLink,
    required this.specializationFileLink,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
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
      qualificationFileLink: map['qualificationFileLink'] ?? '',
      specializationFileLink: map['specializationFileLink'] ?? '',
    );
  }
}
