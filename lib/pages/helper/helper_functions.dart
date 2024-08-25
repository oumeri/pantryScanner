import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// display error to user
void displayMessageToUser(String message, BuildContext context){
  showDialog(context: context,
   builder: (context) => AlertDialog(
    title: Text(message),
   ));
}



Future<void> createUserProfile(User user, String username) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Define the profile data
  Map<String, dynamic> userProfile = {
    'uid': user.uid,
    'email': user.email,
    "username": username,
    'firstName': '',
    'lastName': '',
    'photoURL': user.photoURL ?? '',
    'createdAt': FieldValue.serverTimestamp(),
  };

  // Save the profile data in Firestore under 'profiles' collection
  await firestore.collection('profiles').doc(user.uid).set(userProfile);
}