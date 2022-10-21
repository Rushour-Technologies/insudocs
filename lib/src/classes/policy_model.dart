import 'package:insudox/src/classes/insurance_enums.dart';

class PolicyModel {
  const PolicyModel({
    required this.userId,
    required this.photoURL,
    required this.insuranceStatus,
    required this.insuranceType,
    required this.insuranceCompanyName,
    required this.extraQueries,
    required this.uploadedFilesUrl,
    required this.requestStatus,
    required this.requestId,
  });
  final String userId;
  final String photoURL;
  final InsuranceStatus insuranceStatus;
  final String insuranceCompanyName;
  final InsuranceType insuranceType;
  final String extraQueries;
  final List<String> uploadedFilesUrl;
  final ApprovalStatus requestStatus;
  final String requestId;

  factory PolicyModel.fromJson(
      {required Map<String, dynamic> json, required String requestId}) {
    return PolicyModel(
      userId: json['userId'],
      photoURL: json['photoURL'],
      insuranceStatus: InsuranceStatus.values.firstWhere(
        (element) => element.name == json['insuranceStatus'],
      ),
      insuranceCompanyName: json['insuranceCompanyName'],
      insuranceType: InsuranceType.values.firstWhere(
        (element) => element.name == json['insuranceType'],
      ),
      extraQueries: json['extraQueries'],
      uploadedFilesUrl: List<String>.from(json['uploadedFilesUrl']),
      requestStatus: ApprovalStatus.values
          .firstWhere((element) => element.name == json['requestStatus']),
      requestId: requestId,
    );
  }
}
