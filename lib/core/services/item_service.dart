import 'package:cloud_firestore/cloud_firestore.dart';

class ItemService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = 'items';

  // Fetch all items as List<DocumentSnapshot>
  Future<List<DocumentSnapshot>> fetchAllItems() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(collectionPath).get();
      return snapshot.docs; // Returns raw Firestore documents
    } catch (e) {
      print('Error fetching items: $e');
      return [];
    }
  }
}
