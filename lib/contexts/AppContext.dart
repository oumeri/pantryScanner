import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppContext with ChangeNotifier {
  // User profile
  DocumentSnapshot? userProfile;

  // App theme mode
  ThemeMode themeMode = ThemeMode.light;

  // Preferences (if any)
  Map<String, dynamic> preferences = {};

  // Set user profile
  void setUserProfile(DocumentSnapshot profile) {
    userProfile = profile;
    notifyListeners(); // Notify widgets of changes
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
