import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user pantry
  Future<List<Map<String, dynamic>>> getUserPantry(String userId) async {
    try {
      QuerySnapshot pantrySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('pantry')
          .get();

      return pantrySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching pantry: $e");
      return [];
    }
  }

  // Get user lost items
  Future<List<Map<String, dynamic>>> getLostItems(String userId) async {
    try {
      QuerySnapshot lostItemsSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('lost_items')
          .get();

      return lostItemsSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching lost items: $e");
      return [];
    }
  }

  // Get user lost stats weekly
  Future<Map<String, dynamic>> getLostStatsWeekly(String userId) async {
    try {
      DocumentSnapshot lostStatsSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('lost_stats')
          .doc('weekly')
          .get();

      return lostStatsSnapshot.data() as Map<String, dynamic>;
    } catch (e) {
      print("Error fetching lost stats weekly: $e");
      return {};
    }
  }

  // Get user lost stats monthly
  Future<Map<String, dynamic>> getLostStatsMonthly(String userId) async {
    try {
      DocumentSnapshot lostStatsSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('lost_stats')
          .doc('monthly')
          .get();

      return lostStatsSnapshot.data() as Map<String, dynamic>;
    } catch (e) {
      print("Error fetching lost stats monthly: $e");
      return {};
    }
  }

  // Get user most lost item
  Future<Map<String, dynamic>> getMostLostItem(String userId) async {
    try {
      DocumentSnapshot mostLostItemSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('lost_stats')
          .doc('most_lost')
          .get();

      return mostLostItemSnapshot.data() as Map<String, dynamic>;
    } catch (e) {
      print("Error fetching most lost item: $e");
      return {};
    }
  }

}
