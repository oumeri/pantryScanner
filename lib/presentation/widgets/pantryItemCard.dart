import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting
import 'package:pantry_scanner/presentation/pages/dynamicPages/itemDetailPage.dart';

class PantryItemCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const PantryItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    // Format expiryDate and purchaseDate if they are Timestamp
    String formattedPurchaseDate = _formatDate(item["purchaseDate"]);

    // Determine the color based on the state
    Color statusColor = (item["state"] == "Fresh")
        ? Colors.green
        : (item["state"] == "Semi-fresh")
            ? Colors.orange
            : const Color.fromARGB(255, 201, 3, 3);

    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.only(right: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow color with opacity
            spreadRadius: 2, // How much the shadow spreads
            blurRadius: 5, // Softness of the shadow
            offset: const Offset(3, 3), // Position of the shadow (x, y)
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/BackgroundPatternFood.png'),
                fit: BoxFit.contain, // Adjust how the image fits within the container
                repeat: ImageRepeat.repeat, // This will repeat the image in both directions
              ),
            ),
          ),

          // Foreground content
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetailPage(item: item),
                  ),
                );
              },
              child: Column(
                children: [
                  // Image
                  Container(
                    width: double.infinity,
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8), // Top left corner
                        topRight: Radius.circular(8), // Top right corner
                      ),
                      image: DecorationImage(
                        image: item["imageUrl"] != null && item["imageUrl"].isNotEmpty
                            ? NetworkImage(item["imageUrl"]) as ImageProvider
                            : const AssetImage('assets/images/itemImageTest.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Name
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Name of the item
                        Row(
                          children: [
                            Text(
                              '${item["name"]} (x${item["quantity"]})', // Concatenating name and quantity
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        // Purchased time
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16, color: Colors.black54),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'Purchased $formattedPurchaseDate', // Using formatted date
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                                softWrap: true, // Allows text to wrap
                                overflow: TextOverflow.visible, // Ensures text is displayed fully
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        // Storage place
                        Row(
                          children: [
                            const Icon(Icons.kitchen, size: 16, color: Colors.black54),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'In the ${item["storagePlace"]}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                                softWrap: true, // Allows text to wrap
                                overflow: TextOverflow.visible, // Ensures text is displayed fully
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

            // Status label at the top
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[ Positioned(
                top: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    border: const Border(
                        bottom: BorderSide(color: Colors.white, width: 2), // Bottom border
                        left: BorderSide(color: Colors.white, width: 2),   // Left border
                        right: BorderSide(color: Colors.white, width: 2),  // Right border
                      ),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                  ),
                  child: Text(
                    item["state"] ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ]), 
        ],
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
