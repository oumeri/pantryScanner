import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppContext with ChangeNotifier {

    // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // User profile
  DocumentSnapshot? userProfile;

  // App theme mode
  ThemeMode themeMode = ThemeMode.light;

  // Preferences (if any)
  Map<String, dynamic> preferences = {};

  // Constructor
  AppContext() {
    _initializeUser(); // Fetch user profile when the app starts
  }

  // Initialize user profile
  void _initializeUser() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _fetchUserProfile(user.uid);
      } else {
        userProfile = null;
        notifyListeners();
      }
    });
  }

   // Fetch user profile from Firestore
  Future<void> _fetchUserProfile(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        userProfile = userDoc;
        notifyListeners();
      }
    } catch (e) {
      print("Error fetching user profile: $e");
    }
  }


  // Toggle theme
  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Add/update a preference
  void setPreference(String key, dynamic value) {
    preferences[key] = value;
    notifyListeners();
  }
}
