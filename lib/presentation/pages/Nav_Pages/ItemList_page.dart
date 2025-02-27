import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantry_scanner/presentation/widgets/empty.dart';

class ItemlistPage extends StatefulWidget {
  const ItemlistPage({super.key});

  @override
  State<ItemlistPage> createState() => _ItemlistPageState();
}

class _ItemlistPageState extends State<ItemlistPage> {
  static final List<Map<String, dynamic>> items = [
    {
      "itemId": "apple",
      "name": "Apple",
      "category": "Fruit",
      "imageUrl" : "assets/images/itemImageTest.png",
      "averageShelfLife": "10 days",
      "nutrition": {
        "Calories": 52,
        "Carbohydrates": 14,
        "Fat": 0.2,
        "Protein": 0.3,
        "Sugar": 10
      },
      "tips": "Keep apples in a cool, dry place."
    },
  ];

  List<Map<String, dynamic>> filteredItems = List.from(items);
  TextEditingController searchController = TextEditingController();

  void _filterItems(String query) {
    setState(() {
      filteredItems = items
          .where((item) => item["name"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Items List',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 20),
               Expanded(
                  child: filteredItems.isEmpty
                      ? const Center(child: Empty(text: "No items found"))
                      : GridView.builder(
                          padding: const EdgeInsets.only(top: 8.0),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = filteredItems[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemDetailPage(item: item),
                                  ),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    // Image takes up half the card
                                    Expanded(
                                      flex: 1, // 2/3 of the space
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                        child: Image.asset(
                                          item['imageUrl'] ?? "assets/images/itemImageTest.png",
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    // Text content
                                    Expanded(
                                      flex: 1, // 1/3 of the space
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              item['name'],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black, // Ensure text is black
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              item['category'],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                )

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: _filterItems,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 24),
              ),
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/Icons/filter.svg',
              color: Colors.black,
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemDetailPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const ItemDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          item["name"],
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
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
              _buildInfoCard(Icons.category, "Category", item["category"] ?? "Unknown"),
              _buildInfoCard(Icons.calendar_today, "Shelf Life", item["averageShelfLife"] ?? "Unknown"),
              _buildInfoCard(Icons.info, "Tips", item["tips"] ?? "No tips available"),
              const SizedBox(height: 16),
              const Text("Nutrition", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              ...item["nutrition"].entries.map((entry) => _buildInfoCard(Icons.local_dining, entry.key, "${entry.value} g")),
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
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(detail),
      ),
    );
  }
}



