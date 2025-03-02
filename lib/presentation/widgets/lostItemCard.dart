import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // Import the intl package

class Lostitemcard extends StatelessWidget {
  final Map<String, dynamic> lostItem;

  const Lostitemcard({
    super.key,
    required this.lostItem,
  });

  @override
  Widget build(BuildContext context) {
    // Format lostDate if it's a Timestamp
    String formattedLostDate = _formatDate(lostItem["lostDate"]);

    return Container(
      width: 120,
      height: 150,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item name
            Text(
              lostItem["name"] ?? '',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            
            // Quantity lost
            Text(
              'Quantity Lost: ${lostItem["quantityLost"]}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 4),
            
            // Lost date (timestamp)
            Text(
              'Lost Date: $formattedLostDate',  // Using formatted date
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 4),
            
            // Storage place
            Text(
              'Storage: ${lostItem["storagePlace"]}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to format the date
  String _formatDate(dynamic date) {
    if (date is Timestamp) {
      DateTime dateTime = date.toDate();  // Convert Timestamp to DateTime
      return DateFormat('yyyy-MM-dd').format(dateTime);  // Format the date
    }
    return date ?? "Unknown";  // Return a default value if the date is null or not of type Timestamp
  }
}
