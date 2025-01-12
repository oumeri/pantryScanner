import 'package:flutter/material.dart';

class ItemDetailPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const ItemDetailPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(item["status"]);
    String statusText = item["status"] ?? "Unknown";

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(item["name"], style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                    tag: item["image"],
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: item["image"] != null && item["image"].isNotEmpty
                              ? AssetImage(item["image"]) as ImageProvider
                              : const AssetImage('assets/images/placeholder.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Status Badge on top of the image
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 2, left: 3,right: 3),
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
              // Uniform Info Cards with white background
              _buildInfoCard(Icons.label, "Name", item["name"] ?? "No Name"),
              _buildInfoCard(Icons.calendar_today, "Bought on", item["boughtTime"] ?? "Unknown"),
              _buildInfoCard(Icons.location_on, "Location", item["location"] ?? "Unknown"),
              if (item["description"] != null && item["description"].isNotEmpty)
                _buildInfoCard(Icons.description, "Description", item["description"]),
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
      case 'good':
        return Colors.green;
      case 'expired':
        return Colors.red;
      case 'consume soon':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
