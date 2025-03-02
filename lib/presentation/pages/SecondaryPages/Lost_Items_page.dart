import 'package:flutter/material.dart';
import 'package:pantry_scanner/contexts/AppContext.dart';
import 'package:pantry_scanner/core/services/user_service.dart';
import 'package:pantry_scanner/presentation/widgets/lostItemCard.dart'; // Ensure the Lostitemcard is imported
import 'package:provider/provider.dart'; // For date formatting

class LostItemsPage extends StatefulWidget {
  const LostItemsPage({super.key});

  @override
  _LostItemsPageState createState() => _LostItemsPageState();
}

class _LostItemsPageState extends State<LostItemsPage> {
  // Declare variables to hold the fetched data
  Map<String, dynamic> lostItemsThisWeek = {};
  Map<String, dynamic> lostItemsThisMonth = {};
  Map<String, dynamic> topLostItems = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchLostStats();
  }

  // Fetch the lost stats from Firestore
  Future<void> _fetchLostStats() async {
    final appContext = Provider.of<AppContext>(context, listen: false);
     await Future.delayed(const Duration(seconds: 1));
    final String userId = appContext.userProfile?['id'] ?? '';
    final UserService userService = UserService();

    try {
      setState(() {
        isLoading = true;
      });

     // Fetch weekly stats
      final weeklyStats = await userService.getLostStatsWeekly(userId);
      final monthlyStats = await userService.getLostStatsMonthly(userId);
      final mostLostItemStats = await userService.getMostLostItem(userId);

      setState(() {
      lostItemsThisWeek = weeklyStats["lostItems"] ?? []; // Update with your actual field names
      lostItemsThisMonth = monthlyStats["lostItems"] ?? []; // Update with your actual field names
      topLostItems = mostLostItemStats["lostItemsCount"] ?? {}; // Update with your actual field names
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching lost items: $e");
    }
  }

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
  Widget _buildLostItemsSection(String title, Map<String, dynamic> items) {
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
               children: List.generate(items.entries.length, (index) {
                  MapEntry<String, dynamic> entry = items.entries.elementAt(index); // Get entry (key, value)
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Lostitemcard(
                      lostItem: {
                        "name": entry.key,  // Key as item name
                        "quantityLost": entry.value,  // Value as quantity lost (or any other data you need)
                        "lostDate": "timestamp", // Replace with actual timestamp if available
                        "storagePlace": "N/A", // Adjust as necessary
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

  // Method to build the top lost items section
  Widget _buildTopLostItemsSection(Map<String, dynamic> items) {
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
              children: List.generate(items.entries.length, (index) {
                // Retrieve the MapEntry (key-value pair) from the items map
                MapEntry<String, dynamic> entry = items.entries.elementAt(index);

                // Extract the key and value
                String itemName = entry.key;
                int quantityLost = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Lostitemcard(
                    lostItem: {
                      "name": itemName, // Item name
                      "quantityLost": quantityLost, // Quantity lost
                      "lostDate": "timestamp", // Replace with actual timestamp
                      "storagePlace": "N/A", // Adjust as needed
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