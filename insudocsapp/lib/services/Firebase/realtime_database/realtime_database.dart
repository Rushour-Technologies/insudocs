import 'package:insudox_app/services/Firebase/fireauth/fireauth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

// Admin commands

Future<bool> sendFeedback({required String feedback}) async {
  // Database reference
  final DatabaseReference database = FirebaseDatabase.instance.ref("feedbacks");

  // DatabaseReference newFeedback = database.child(orderId);
  await database.push().set({
    'feedback': feedback,
  });

  return false;
}

Future<bool> reportProblem({
  required String name,
  required String email,
  required String phoneNumber,
  required String problem,
}) async {
  // Database reference
  final DatabaseReference database = FirebaseDatabase.instance.ref("feedbacks");

  await database.push().set({
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'complaint': problem,
  });

  return false;
}
