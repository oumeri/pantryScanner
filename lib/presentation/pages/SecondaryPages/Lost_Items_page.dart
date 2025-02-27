import 'package:flutter/material.dart';
import 'package:pantry_scanner/presentation/widgets/lostItemCard.dart';

class LostItemsPage extends StatelessWidget {
  const LostItemsPage({super.key});

  static const List<Map<String, dynamic>> lostItemsThisWeek = [
    {
      "name": "Apple",
      "quantityLost": 3,
      "lostDate": "2025-02-20", // Replace with actual timestamp
      "storagePlace": "Refrigerator"
    },
    {
      "name": "Banana",
      "quantityLost": 2,
      "lostDate": "2025-02-20",
      "storagePlace": "Kitchen Counter"
    }
  ];

  static const List<Map<String, dynamic>> lostItemsThisMonth = [
    {
      "name": "Apple",
      "quantityLost": 6,
      "lostDate": "2025-02-10",
      "storagePlace": "Fridge Door"
    },
    {
      "name": "Banana",
      "quantityLost": 5,
      "lostDate": "2025-02-12",
      "storagePlace": "Kitchen Counter"
    },
    {
      "name": "Tomato",
      "quantityLost": 4,
      "lostDate": "2025-02-15",
      "storagePlace": "Fridge"
    }
  ];

  static const Map<String, int> topLostItems = {
    "Apple": 12,
    "Banana": 9,
    "Tomato": 6
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Lost Items',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            // Lost items this week section
            _buildLostItemsSection('This Week', lostItemsThisWeek),

            // Lost items this month section
            _buildLostItemsSection('This Month', lostItemsThisMonth),

            // Top lost items section
            _buildTopLostItemsSection(topLostItems),
          ],
        ),
      ),
    );
  }

  // Method to build the lost items section
  Widget _buildLostItemsSection(String title, List<Map<String, dynamic>> items) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(items.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Lostitemcard(
                      lostItem: items[index],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to build the top lost items section
  Widget _buildTopLostItemsSection(Map<String, int> items) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Items',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(items.length, (index) {
                  String itemName = items.keys.elementAt(index);
                  int quantityLost = items[itemName]!;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Lostitemcard(
                      lostItem: {
                        "name": itemName,
                        "quantityLost": quantityLost,
                        "lostDate": "timestamp", // Replace with actual timestamp
                        "storagePlace": "N/A", // Adjust if needed
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
