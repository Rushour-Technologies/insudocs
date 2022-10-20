import 'package:insudox/src/classes/incoming_request_info_model.dart';

class ClientRequestInfo extends IncomingRequestInfo {
  const ClientRequestInfo({
    required super.photoURL,
    required super.name,
    required this.insuranceType,
    required this.insuraceStatus,
    required super.email,
    required this.reportLink,
    required super.uid,
  });

  factory ClientRequestInfo.fromMap(Map<String, dynamic> map) =>
      ClientRequestInfo(
        email: map['email'] as String,
        name: map['name'] as String,
        insuraceStatus: map['insuranceStatus'] as int,
        insuranceType: map['insuranceType'] as int,
        photoURL: map['photoURL'] as String,
        reportLink: map['reportLink'] as String,
        uid: map['uid'] as String,
      );

  final int insuranceType;
  final int insuraceStatus;
  final String reportLink;
}
