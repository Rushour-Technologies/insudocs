import 'package:insudox/globals.dart';
import 'package:insudox/src/classes/incoming_request_info_model.dart';
import 'package:insudox/src/classes/insurance_enums.dart';
import 'package:insudox/src/classes/policy_model.dart';

class ClientRequestInfo extends IncomingRequestInfo {
  const ClientRequestInfo({
    required super.photoURL,
    required super.name,
    required super.userId,
    required this.policy,
  });

  factory ClientRequestInfo.fromMap({
    required Map<String, dynamic> map,
    required String requestId,
  }) =>
      ClientRequestInfo(
        name: map['name'] as String,
        photoURL: map['photoURL'] ?? DEFAULT_PROFILE_PICTURE,
        userId: map['userId'] as String,
        policy: PolicyModel.fromJson(
          json: map,
          requestId: requestId,
        ),
      );

  final PolicyModel policy;
}
