import 'package:insudox_app/enums/insurance_enums.dart';
import 'package:insudox_app/globals.dart';

class PolicyModel {
  const PolicyModel({
    required this.insuranceStatus,
    required this.insuranceType,
    required this.insuranceCompanyName,
    required this.extraQueries,
    required this.uploadedFilesUrl,
    required this.requestStatus,
    required this.requestId,
  });

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
