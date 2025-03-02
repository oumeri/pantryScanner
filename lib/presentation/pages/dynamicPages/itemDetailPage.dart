import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class ItemDetailPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const ItemDetailPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(item["state"]);
    String statusText = item["state"] ?? "Unknown";

    // Convert Timestamp to formatted string if necessary
    String formattedPurchaseDate = _formatDate(item["purchaseDate"]);
    String formattedExpiryDate = _formatDate(item["expiryDate"]);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(item["name"],
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero Image with Status Badge
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Hero(
                    tag: item["imageUrl"],
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: item["imageUrl"] != null && item["imageUrl"].isNotEmpty
                              ? const AssetImage('assets/images/itemImageTest.png') //NetworkImage(item["imageUrl"]) as ImageProvider
                              : const AssetImage('assets/images/itemImageTest.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Status Badge on top of the image
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 2, left: 3, right: 3),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(1),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Text(
                          statusText.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Information Cards
              _buildInfoCard(Icons.label, "Name", item["name"] ?? "No Name"),
              _buildInfoCard(Icons.calendar_today, "Purchase Date", formattedPurchaseDate),
              _buildInfoCard(Icons.event, "Expiry Date", formattedExpiryDate),
              _buildInfoCard(Icons.location_on, "Storage Place", item["storagePlace"] ?? "Unknown"),
              _buildInfoCard(Icons.inventory, "Quantity", item["quantity"].toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String detail) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(detail),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'fresh':
        return Colors.green;
      case 'rotten':
        return Colors.red;
      case 'Semi-fresh':
        return Colors.orange;
      default:
        return Colors.grey;
    }
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
