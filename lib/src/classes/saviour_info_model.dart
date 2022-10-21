import 'package:insudox/src/classes/incoming_request_info_model.dart';

class SaviourRequestInfo extends IncomingRequestInfo {
  const SaviourRequestInfo({
    required super.name,
    required this.qualificationFileLink,
    required this.universityName,
    required this.experienceFileLink,
    required this.experience,
    required this.adhaarNumber,
    required this.gender,
    required this.email,
    required super.photoURL,
    required super.userId,
    required this.qualification,
    required this.specialization,
    required this.approvalStatus,
  });

  factory SaviourRequestInfo.fromMap(Map<String, dynamic> map) =>
      SaviourRequestInfo(
        name: map['name'] as String,
        qualification: map['qualification'] as String,
        specialization: map['specialization'] as String,
        qualificationFileLink: map['qualificationFileLink'] as String,
        universityName: map['universityName'] as String,
        experienceFileLink: map['experienceFileLink'] as String,
        experience: map['experience'] as String,
        adhaarNumber: map['maskedNumber'] as String,
        photoURL: map['photoURL'] as String,
        email: map['email'] as String,
        gender: map['gender'] as String,
        userId: map['uid'] as String,
        approvalStatus: map['approvalStatus'] as String,
      );

  final String universityName;
  final String qualificationFileLink;
  final String experienceFileLink;
  final String email;
  final String experience;
  final String adhaarNumber;
  final String gender;
  final String qualification;
  final String specialization;
  final String approvalStatus;
}
