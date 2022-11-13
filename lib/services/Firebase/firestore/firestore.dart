import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:insudox/services/Firebase/fireauth/fireauth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:insudox/src/classes/insurance_enums.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference saviourDocumentCollection({required String collection}) {
  // print(getCurrentUserId());
  return firestore
      .collection('users')
      .doc(getCurrentUserId())
      .collection(collection);
}

DocumentReference exploreDataRoleSpecificDocument({required Role role}) {
  // print('called');
  return firestore
      .collection('explore_data')
      .doc(role.toString().split('.').last);
}

DocumentReference<Map<String, dynamic>> saviourDocumentReference() {
  return firestore.collection('users').doc(getCurrentUserId());
}

CollectionReference userDocumentCollection(
    {required String userId, required String collection}) {
  return firestore.collection('users').doc(userId).collection(collection);
}

/// Get the ```users``` collection
CollectionReference usersCollectionReference() {
  return firestore.collection('users');
}

/// Get the current user's document
DocumentReference<Map<String, dynamic>> userDocumentReference({
  required String userId,
}) {
  return firestore.collection('users').doc(userId);
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
  required bool accept,
  required String userId,
}) async {
  await firestore.collection('users').doc(userId).update({
    'approvalStatus':
        (accept ? ApprovalStatus.APPROVED : ApprovalStatus.REJECTED).data,
  });
}

/// Saviour Portal
Future<void> acceptDenyClient({
  required bool accept,
  required String clientId,
  required String requestId,
}) async {
  // Set the request status in the client_requests collection
  await firestore.collection('client_requests').doc(requestId).update({
    'requestStatus':
        accept ? ApprovalStatus.APPROVED.data : ApprovalStatus.REJECTED.data,
  });
  // Set the approval status in the client's document
  await userDocumentCollection(
    userId: clientId,
    collection: 'policies',
  ).doc(requestId).update({
    'requestStatus':
        accept ? ApprovalStatus.APPROVED.data : ApprovalStatus.REJECTED.data,
  });

  // If rejected, return
  if (!accept) return;

  await saviourDocumentCollection(collection: 'clients').doc(clientId).set({
    'clientId': clientId,
    'requestId': requestId,
  });

  // saviour User class for chat
  types.User currentUserSaviour = types.User(
    id: getCurrentUserId(),
    role: types.Role.saviour,
    createdAt: DateTime.now().millisecondsSinceEpoch,
    updatedAt: DateTime.now().millisecondsSinceEpoch,
  );

  // client User class for chat
  types.User currentUserClient = types.User(
    id: clientId,
    role: types.Role.user,
    createdAt: DateTime.now().millisecondsSinceEpoch,
    updatedAt: DateTime.now().millisecondsSinceEpoch,
  );

  types.Room room = await FirebaseChatCore.instance.createRoom(
    currentUserClient,
  );
}

/// Get all the client requests
Stream<QuerySnapshot<Map<String, dynamic>>> getAllRequests() async* {
  QuerySnapshot<Object?> servingUsers =
      await saviourDocumentCollection(collection: 'clients').get();

  yield* firestore
      .collection('client_requests')
      .where('requestStatus', isEqualTo: 'PENDING')
      .snapshots();
}

/// Update chat roles neatly
Future<void> updateChatRoles({
  required String roomId,
  required String clientId,
}) async {
  return firestore.collection('rooms').doc(roomId).update({
    'users': FieldValue.arrayUnion([
      {
        'id': clientId,
        'role': 'user',
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      },
      {
        'id': getCurrentUserId(),
        'role': 'saviour',
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      },
    ]),
  });
}
