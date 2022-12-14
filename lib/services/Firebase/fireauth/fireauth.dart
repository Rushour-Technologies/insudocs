import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:insudox/globals.dart';

import 'package:insudox/services/Firebase/fireAuth/google_auth.dart'
    as google_auth;
import 'package:insudox/services/Firebase/firestore/firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

// Anonymous sign in
Future<UserCredential> signInAnon() async {
  UserCredential result = await _auth.signInAnonymously();
  return result;
}

// google sign in
Future<bool> signInWithGoogle() async {
  UserCredential? result = await google_auth.signInWithGoogle();

  CollectionReference users = usersCollectionReference();

  if (!(await users.doc(result!.user!.uid).get()).exists) {
    initialData();
  }

  return (result.user!.uid == _auth.currentUser!.uid);
}

// Email pass sign in
Future<List<dynamic>> signInUser(
    {required String email, required String password}) async {
  try {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
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

// New register
Future<List<dynamic>> registerUser(
    {required String name,
    required String email,
    required String password}) async {
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
  await _auth.currentUser!.updateDisplayName(
    name,
  );

  initialData();

  return [0, ''];
}

// Check if user is admin
Future<bool> checkAdmin() async {
  DocumentReference user = saviourDocumentReference();
  Map<String, dynamic>? data =
      (await user.get()).data() as Map<String, dynamic>;
  if (data.keys.contains('isAdmin')) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAdmin', data['isAdmin']);
    return data['isAdmin'];
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isAdmin', false);
  return false;
}

// Check if form is filled
Future<bool> checkFormFilled() async {
  CollectionReference users = usersCollectionReference();
  User user = getCurrentUser()!;
  if (checkLoggedIn()) {
    Map<String, dynamic> data =
        (await users.doc(user.email).get()).data() as Map<String, dynamic>;
    // print(data);
    return data['formFilled'];
  }
  return false;
}

// Check if form is filled
Future<bool> checkAadhar() async {
  CollectionReference users = usersCollectionReference();
  print('checking aadhar');
  User user = getCurrentUser()!;
  if (checkLoggedIn()) {
    Map<String, dynamic> data =
        (await users.doc(user.uid).get()).data() as Map<String, dynamic>;
    // print(data);
    return data['aadharFilled'] ?? false;
  }
  return false;
}

// Check if details are filled
Future<bool> checkDetails() async {
  CollectionReference users = usersCollectionReference();
  User user = getCurrentUser()!;
  if (checkLoggedIn()) {
    Map<String, dynamic> data =
        (await users.doc(user.uid).get()).data() as Map<String, dynamic>;
    // print(data);
    return data['detailsFilled'] ?? false;
  }

  return false;
}

// Get current user id
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
  return !checkLoggedIn();
}

// google sign out
Future<bool> signOutGoogle() async {
  // await deviceFCMKeyOperations();
  await google_auth.signOutGoogle();
  return !checkLoggedIn();
}

// Setup initial data
void initialData() async {
  CollectionReference users = usersCollectionReference();
  // print(kIsWeb);
  User user = getCurrentUser()!;

  await FirebaseChatCore.instance.createUserInFirestore(
    types.User(
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      firstName: user.displayName!.split(' ')[0],
      id: user.uid,
      imageUrl: user.photoURL ?? DEFAULT_PROFILE_PICTURE,
      lastName: user.displayName!.split(' ')[1],
      role: types.Role.saviour,
    ),
  );
}

Future<String> checkRole() async {
  CollectionReference users = usersCollectionReference();
  User user = getCurrentUser()!;
  if (checkLoggedIn()) {
    Map<String, dynamic> data =
        (await users.doc(user.uid).get()).data() as Map<String, dynamic>;

    return data['role'];
  }

  return "none";
}
