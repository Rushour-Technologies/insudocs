import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insudox_app/classes/enums.dart';
import 'package:insudox_app/services/Firebase/fireauth/fireauth.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference userDocumentCollection({required String collection}) {
  return firestore
      .collection('users')
      .doc(getCurrentUserId())
      .collection(collection);
}

CollectionReference usersCollectionReference() {
  return firestore.collection('users');
}

DocumentReference<Map<String, dynamic>> userDocumentReference() {
  return firestore.collection('users').doc(getCurrentUserId());
}

Future<void> deleteDocumentByReference(DocumentReference reference) async {
  await firestore.runTransaction(
      (Transaction transaction) async => transaction.delete(reference));
}

Future<void> sendRequest({
  required String professionalId,
  required String userId,
}) async {
  Map<String, dynamic> temp = (await userDocumentReference().get()).data()!;
  User user = getCurrentUser()!;

  Map<String, dynamic> data = {
    'name': user.displayName ??
        "${(temp['firstName'] as String)} ${(temp['lastName'] as String)}",
    'uid': user.uid,
    'clientType': temp['question'] > 0 ? 'student' : 'parent',
    'type': temp['question'],
    'photoURL': user.photoURL,
    'testStatus': (temp['testGiven'] as List).map((e) {
      return e;
    }).toList(),
  };
  data.putIfAbsent('standard', () => '');
  print(temp);
  await userDocumentReference()
      .collection('data')
      .doc('userInfo')
      .get()
      .then((value) {
    data['standard'] = value.data()!['class/grade'];
  });

  await userDocumentCollection(collection: 'requests').doc(professionalId).set({
    'userId': userId,
    'requestStatus': 'pending',
    'photoURL': user.photoURL,
  });
  await firestore
      .collection('all_requests')
      .doc(professionalId)
      .collection('requests')
      .doc(userId)
      .set({
    'requestStatus': 'pending',
  });
  await firestore
      .collection('all_requests')
      .doc(professionalId)
      .collection('requests')
      .doc(userId)
      .set(data, SetOptions(merge: true));
  return;
}

/// Requesting a status update for a specific document
Future<ApprovalStatus> checkRequestStatus({required String docId}) async {
  Map<String, dynamic> document =
      (await firestore.collection('client_requests').doc(docId).get()).data() ??
          {};
  ApprovalStatus requestStatus = ApprovalStatus.PENDING;
  for (var element in ApprovalStatus.values) {
    if (document['requestStatus'] == element.data) {
      requestStatus = element;
      break;
    }
  }

  return requestStatus;
}

/// Set the initial document details
Future<String> setInitialDocumentDetails({
  required String insuranceType,
  required String insuranceStatus,
  required String insuranceCompanyName,
  required String extraQueries,
  required List<String> uploadedFilesUrl,
}) async {
  return await firestore.collection("client_requests").add({
    "userId": getCurrentUserId(),
    "insuranceType": insuranceType,
    "insuranceStatus": insuranceStatus,
    "insuranceCompanyName": insuranceCompanyName,
    "extraQueries": extraQueries,
    "uploadedFilesUrl": uploadedFilesUrl,
    'requestStatus': ApprovalStatus.PENDING.data,
  }).then((value) async {
    return value.id;
  });
}
