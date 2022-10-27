import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import 'package:insudox_app/globals.dart';
import 'package:insudox_app/services/Firebase/fireAuth/google_auth.dart'
    as google_auth;
import 'package:insudox_app/services/Firebase/firestore/firestore.dart';
import 'package:insudox_app/services/Firebase/push_notification/push_notification_service.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

/// Anonymous sign in
Future<UserCredential> signInAnon() async {
  UserCredential result = await _auth.signInAnonymously();
  return result;
}

/// google sign in
Future<bool> signInWithGoogle() async {
  UserCredential? result = await google_auth.signInWithGoogle();

  CollectionReference users = usersCollectionReference();

  if (!(await users.doc(result!.user!.uid).get()).exists) {
    await initialData(getCurrentUser()!.displayName!);
  }
  if (result.user!.uid == _auth.currentUser!.uid) {
    deviceFCMKeyOperations(add: true);
  }
  String id = await userDocumentReference().get().then(
      (value) => value.data()!['role'] + value.data()!['question'].toString());
  PushNotificationService.registerCustomNotificationListeners(
      id: id, title: id, description: id);
  userDocumentReference().update({
    'email': result.user!.email,
  });
  return (result.user!.uid == _auth.currentUser!.uid);
}

Future<bool> logInWithGoogle() async {
  UserCredential? result = await google_auth.signInWithGoogle();

  CollectionReference users = usersCollectionReference();

  if (!(await users.doc(result!.user!.uid).get()).exists) {
    await initialDatalogin();
  }
  if (result.user!.uid == _auth.currentUser!.uid) {
    deviceFCMKeyOperations(add: true);
  }
  userDocumentReference().update({
    'email': result.user!.email,
  });
  return (result.user!.uid == _auth.currentUser!.uid);
}

/// Email pass sign in
Future<List<dynamic>> signInUser(
    {required String email, required String password}) async {
  if (email == '' && password == '') {
    return [-1, 'Some error'];
  }
  try {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await deviceFCMKeyOperations(add: true);
    String id = await userDocumentReference().get().then((value) =>
        value.data()!['role'] + value.data()!['question'].toString());
    PushNotificationService.registerCustomNotificationListeners(
        id: id, title: id, description: id);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return [1, 'No user found for that email'];
    } else if (e.code == 'wrong-password') {
      return [2, 'Wrong password provided for that user'];
    } else {
      return [3, e.code];
    }
  }

  // Successful sign in
  return [0, ''];
}

Future<List<dynamic>> passwordResetEmailUser({required String email}) async {
  if (email == '') {
    return [-1, 'Some error'];
  }
  try {
    await _auth.sendPasswordResetEmail(
      email: email,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return [1, 'No user found for that email'];
    } else {
      return [2, 'e'];
    }
  } catch (e) {
    return [2, 'e'];
  }
  // Successful sign in
  return [0, ''];
}

/// New register
Future<List<dynamic>> registerUser(
    {required String email,
    required String password,
    required String name}) async {
  try {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return [2, 'The password provided is too weak'];
    } else if (e.code == 'email-already-in-use') {
      return [1, 'The account already exists for that email'];
    } else {
      return [3, e.code];
    }
  }

  // Successful registration

  await initialData(name);

  return [0, ''];
}

/// Check if form is filled
Future<bool> checkFormFilled() async {
  CollectionReference users = usersCollectionReference();

  User user = getCurrentUser()!;
  if (checkLoggedIn()) {
    Map<String, dynamic> data =
        (await users.doc(user.uid).get()).data() as Map<String, dynamic>;
    return data['formFilled'] ?? false;
  }
  return false;
}

/// Get current user id
String getCurrentUserId() {
  if (checkLoggedIn()) {
    return _auth.currentUser!.uid;
  }
  return "none";
}

// Get the current user
User? getCurrentUser() {
  return _auth.currentUser;
}

// Check if there is any login
bool checkLoggedIn() {
  User? user = _auth.currentUser;
  return (user != null);
}

// Sign out user
Future<bool> signOut() async {
  await _auth.signOut();
  await deviceFCMKeyOperations(add: false);
  return !checkLoggedIn();
}

// google sign out
Future<bool> signOutGoogle() async {
  // await deviceFCMKeyOperations();
  await google_auth.signOutGoogle();
  return !checkLoggedIn();
}

// Setup initial data
Future<void> initialData(String name) async {
  CollectionReference users = usersCollectionReference();
  User user = getCurrentUser()!;

  await user.updateDisplayName(name);
  await user.reload();

  await FirebaseChatCore.instance.createUserInFirestore(types.User(
    firstName: (user.displayName != null)
        ? (user.displayName?.split(' ')[0])
        : name.split(' ')[0],
    id: user.uid,
    imageUrl: user.photoURL ?? DEFAULT_PROFILE_PICTURE,
    lastName: (user.displayName != null)
        ? (user.displayName?.split(' ')[1])
        : name.split(' ')[1],
  ));

  print("adding data");
  await users.doc(_auth.currentUser!.uid).set({
    "email": _auth.currentUser!.email,
    "formFilled": false,
    "role": types.Role.user.toShortString(),
    "name": name,
    "current requests": 0,
    "closed requests": 0,
    "raised requests": 0,
    'deviceIDs': {await FirebaseMessaging.instance.getToken(): 0},
  }, SetOptions(merge: true));

  print("added data");
  await users.doc(_auth.currentUser!.uid).update({
    "email": _auth.currentUser!.email,
    "formFilled": false,
    "role": types.Role.user.toShortString(),
    "name": name,
    'deviceIDs': {await FirebaseMessaging.instance.getToken(): 0},
  });
}

Future<void> initialDatalogin() async {
  CollectionReference users = usersCollectionReference();
  User user = getCurrentUser()!;
  await FirebaseChatCore.instance.createUserInFirestore(types.User(
    firstName: user.displayName!.split(' ')[0],
    id: user.uid,
    imageUrl: user.photoURL ?? DEFAULT_PROFILE_PICTURE,
    lastName: user.displayName!.split(' ')[1],
    role: types.Role.user,
  ));

  await users.doc(_auth.currentUser!.uid).set({
    "email": _auth.currentUser!.email,
    'deviceIDs': {await FirebaseMessaging.instance.getToken(): 0},
  }, SetOptions(merge: true));

  await users.doc(_auth.currentUser!.uid).update({
    "email": _auth.currentUser!.email,
    'deviceIDs': {await FirebaseMessaging.instance.getToken(): 0},
  });
}

Future<bool> deviceFCMKeyOperations({bool add = false}) async {
  DocumentReference userDocument = userDocumentReference();
  Map<String, dynamic>? deviceIDs, data;
  await userDocument.get().then((value) async {
    data = value.data() as Map<String, dynamic>;
    // data!.putIfAbsent('deviceIDs', () => []);
    if (data!['deviceIDs'].runtimeType == int) {
      await userDocument.set(
        {'deviceIDs': {}},
        SetOptions(merge: true),
      );
    } else {
      deviceIDs = data!['deviceIDs'] as Map<String, dynamic>;
    }
  });

  if (deviceIDs == null) {
    await userDocument.set(
      {'deviceIDs': {}},
      SetOptions(merge: true),
    );
  }
  if (add) {
    deviceIDs![(await FirebaseMessaging.instance.getToken())!] = 0;
    await userDocument.set(
      {
        'deviceIDs': deviceIDs,
      },
      SetOptions(merge: true),
    );
  } else if (deviceIDs!.keys
      .contains(await FirebaseMessaging.instance.getToken())) {
    await userDocument.set(
      {
        'deviceIDs':
            deviceIDs!.remove(await FirebaseMessaging.instance.getToken()),
      },
      SetOptions(merge: true),
    );
  }
  return false;
}
