import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insudox_app/classes/policy_model.dart';
import 'package:insudox_app/enums/insurance_enums.dart';

import 'package:insudox_app/services/Firebase/fireauth/fireauth.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference userDocumentCollection({required String collection}) {
  return firestore
      .collection('users')
      .doc(getCurrentUserId())
      .collection(collection);
}

/// Get the ```users``` collection
CollectionReference usersCollectionReference() {
  return firestore.collection('users');
}

/// Get the current user's document
DocumentReference<Map<String, dynamic>> userDocumentReference() {
  return firestore.collection('users').doc(getCurrentUserId());
}

/// Delete the document by its reference
Future<void> deleteDocumentByReference(DocumentReference reference) async {
  await firestore.runTransaction(
      (Transaction transaction) async => transaction.delete(reference));
}

/// Check the request status for a specific document / request
Future<ApprovalStatus> checkRequestStatus({required String docId}) async {
  Map<String, dynamic> document =
      (await firestore.collection('client_requests').doc(docId).get()).data() ??
          {};
  ApprovalStatus requestStatus = ApprovalStatus.PENDING;
  for (var element in ApprovalStatus.values) {
    if (document['requestStatus'] == element.name) {
      requestStatus = element;
      break;
    }
  }

  return requestStatus;
}

/// Set the document details in client_requests collection
///
/// insuranceType: Insurance Type [InsuranceType.HEALTH] or [InsuranceType.LIFE] in string
///
/// insuranceStatus: Insurance Status [InsuranceStatus.FILE] or [InsuranceStatus.TRACK] or [InsuranceStatus.CLEARED] in string
///
/// insuranceCompanyName: Insurance Company Name in string
///
/// extraQueries: Extra Queries in string
///
/// uploadedFilesUrl: List of uploaded files url in string
Future<String> setDocumentDetails({
  required String insuranceType,
  required String insuranceStatus,
  required String insuranceCompanyName,
  required String extraQueries,
  required List<String> uploadedFilesUrl,
}) async {
  return await firestore.collection("client_requests").add({
    'userId': getCurrentUserId(),
    'photoURL': getCurrentUser()!.photoURL,
    'insuranceType': insuranceType,
    'insuranceStatus': insuranceStatus,
    'insuranceCompanyName': insuranceCompanyName,
    'extraQueries': extraQueries,
    'uploadedFilesUrl': uploadedFilesUrl,
    'requestStatus': ApprovalStatus.PENDING.name,
  }).then((value) async {
    return value.id;
  });
}

/// Method to send request to the saviours
///
/// insuranceType: Insurance Type [InsuranceType.HEALTH] or [InsuranceType.LIFE] in string
///
/// insuranceStatus: Insurance Status [InsuranceStatus.FILE] or [InsuranceStatus.TRACK] or [InsuranceStatus.CLEARED] in string
///
/// insuranceCompanyName: Insurance Company Name in string
///
/// extraQueries: Extra Queries in string
///
/// uploadedFilesUrl: List of uploaded files url in string
Future<void> sendInsuranceHelpRequest({
  required String insuranceType,
  required String insuranceStatus,
  required String insuranceCompanyName,
  required String extraQueries,
  required List<String> uploadedFilesUrl,
}) async {
  String uploadedDocumentId = await setDocumentDetails(
    insuranceType: insuranceType,
    insuranceStatus: insuranceStatus,
    insuranceCompanyName: insuranceCompanyName,
    extraQueries: extraQueries,
    uploadedFilesUrl: uploadedFilesUrl,
  );

  await userDocumentReference()
      .collection("policies")
      .doc(uploadedDocumentId)
      .set({
    'insuranceType': insuranceType,
    'insuranceStatus': insuranceStatus,
    'insuranceCompanyName': insuranceCompanyName,
    'extraQueries': extraQueries,
    'uploadedFilesUrl': uploadedFilesUrl,
  });

  await userDocumentReference().update({
    "formFilled": true,
  });
}

/// Report a saviour
Future<bool> reportSaviour({
  required String saviourId,
  required String roomId,
}) async {
  await firestore.collection("client_requests").doc(roomId).update({
    "requestStatus": ApprovalStatus.REPORTED.name,
  });
  return true;
}

/// Get filed policies with conditions
Future<List<PolicyModel>> getPolicies({
  bool getReported = false,
  bool getPending = true,
  bool getApproved = true,
  bool getRejected = true,
}) async {
  List<PolicyModel> policies = [];
  await userDocumentCollection(collection: "policies")
      .where("requestStatus", whereIn: [
        getApproved ? ApprovalStatus.APPROVED.name : "",
        getRejected ? ApprovalStatus.REJECTED.name : "",
        getReported ? ApprovalStatus.REPORTED.name : "",
        getPending ? ApprovalStatus.PENDING.name : "",
      ])
      .get()
      .then(
        (value) {
          for (var element in value.docs) {
            policies.add(
              PolicyModel.fromJson(
                json: element.data() as Map<String, dynamic>,
                requestId: element.id,
              ),
            );
          }
        },
      );
  return policies;
}