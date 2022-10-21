import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:insudox/services/Firebase/fireauth/fireauth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:insudox/src/classes/insurance_enums.dart';
import 'package:insudox/src/classes/policy_model.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference saviourDocumentCollection({required String collection}) {
  // print(getCurrentUserId());
  return firestore
      .collection('saviours')
      .doc(getCurrentUserId())
      .collection(collection);
}

DocumentReference exploreDataRoleSpecificDocument({required Role role}) {
  // print('called');
  return firestore
      .collection('explore_data')
      .doc(role.toString().split('.').last);
}

CollectionReference savioursCollectionReference() {
  return firestore.collection('saviours');
}

DocumentReference<Map<String, dynamic>> saviourDocumentReference() {
  return firestore.collection('saviours').doc(getCurrentUserId());
}

Future<void> deleteDocumentByReference(DocumentReference reference) async {
  await firestore.runTransaction(
      (Transaction transaction) async => transaction.delete(reference));
}

/// Set the role of the saviour
setPublicData({
  required Map<String, dynamic> data,
  required Role role,
}) {
  exploreDataRoleSpecificDocument(role: role)
      .set(data, SetOptions(merge: true));
}

/// Super Admin Portal
Future<void> acceptDenySaviour({
  bool accept = true,
  required String userId,
}) async {
  await firestore.collection('saviours').doc(userId).update({
    'approvalStatus':
        (accept ? ApprovalStatus.APPROVED : ApprovalStatus.REJECTED).data,
  });
}

/// Saviour Portal
Future<void> setRequestStatus({
  bool accept = true,
  required String userId,
}) async {
  await firestore
      .collection('all_requests')
      .doc(getCurrentUserId())
      .collection('requests')
      .doc(userId)
      .update({
    'requestStatus': accept ? 'accepted' : 'rejected',
  });

  await savioursCollectionReference()
      .doc(userId)
      .collection('requests')
      .doc(getCurrentUserId())
      .update({
    'requestStatus': accept ? 'accepted' : 'rejected',
  });

  if (!accept) return;
  // Current User
  final doc = await saviourDocumentReference().get();

  final data = doc.data()!;
  // print(data);

  data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
  data['id'] = doc.id;
  data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
  data['role'] = data['role'];
  data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

  types.User currentUser = types.User.fromJson(data);

  // Other User
  final otherDoc = await savioursCollectionReference().doc(userId).get();

  final Map<String, dynamic> otherData =
      otherDoc.data()! as Map<String, dynamic>;
  // print(data);

  otherData['createdAt'] = otherData['createdAt']?.millisecondsSinceEpoch;
  otherData['id'] = userId;
  otherData['lastSeen'] = otherData['lastSeen']?.millisecondsSinceEpoch;
  otherData['role'] = otherData['role'];
  otherData['updatedAt'] = otherData['updatedAt']?.millisecondsSinceEpoch;

  types.User otherUser = types.User.fromJson(otherData);

  // print(jsify(otherUser));

  await FirebaseChatCore.instance.createRoom(currentUser, otherUser);
}

/// Get all the client requests
Future<List<PolicyModel>> getAllRequests() async {
  final requestDocuments = await firestore
      .collection('client_requests')
      .where('requestStatus', isEqualTo: 'PENDING')
      .get();

  final List<PolicyModel> requests = [];

  for (QueryDocumentSnapshot<Map<String, dynamic>> element
      in requestDocuments.docs) {
    requests.add(
      PolicyModel.fromJson(
        json: element.data(),
        requestId: element.id,
      ),
    );
  }

  return requests;
}
