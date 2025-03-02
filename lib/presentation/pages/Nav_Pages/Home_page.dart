import 'package:flutter/material.dart';
import 'package:pantry_scanner/core/services/user_service.dart';
import 'package:pantry_scanner/presentation/widgets/lostItemCard.dart';
import 'package:pantry_scanner/presentation/widgets/pantryItemCard.dart';
import 'package:pantry_scanner/presentation/pages/Nav_Pages/Scanner_page.dart';
import 'package:pantry_scanner/presentation/pages/SecondaryPages/Lost_Items_page.dart';
import 'package:pantry_scanner/contexts/AppContext.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> lostItems = [];
  List<Map<String, dynamic>> pantryItems = [];
  bool isLoading = true;

  // Navigation methods
  void navigateToLostItemsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LostItemsPage(),
      ),
    );
  }

  void navigateToScannerPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ScannerPage(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    final appContext = Provider.of<AppContext>(context, listen: false);
     await Future.delayed(const Duration(seconds: 1));
    final String userId = appContext.userProfile?['id'] ?? '';
    final userService = UserService();

    try {
      setState(() {
        isLoading = true;
      });

      // Fetch Lost Items
      final lostItemsResponse = await userService.getLostItems(userId);
      // Fetch Pantry Items
      final pantryItemsResponse = await userService.getUserPantry(userId);

      setState(() {
        lostItems = lostItemsResponse;
        pantryItems = pantryItemsResponse;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching items: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final appContext = Provider.of<AppContext>(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Text: "Hello, UserName"
              Text(
                'Hello, ${appContext.userProfile?['name']}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Lost items Section
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Lost Items',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              lostItems.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () => navigateToLostItemsPage(context),
                                      child: const Row(
                                        children: [
                                          Text(
                                            'View all',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          const SizedBox(height: 16),
                          lostItems.isNotEmpty
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: List.generate(lostItems.length, (index) {
                                      var item = lostItems[index];
                                      return Lostitemcard(lostItem: item);
                                    }),
                                  ),
                                )
                              : Column(
                                  children: [
                                    const SizedBox(
                                      height: 100,
                                      child: Center(
                                        child: Text(
                                          'Nothing went to waste so far',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => navigateToLostItemsPage(context),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[800],
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'See details',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),

              const SizedBox(height: 12),

              // Pantry Section
              const Text(
                'My Pantry',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              // Fetch pantry items
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/BackgroundPatternFood.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: pantryItems.isEmpty
                            ? const Center(
                                child: Text(
                                  'Your pantry is empty',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 1,
                                  crossAxisSpacing: 1,
                                  childAspectRatio: 2 / 3,
                                ),
                                itemBuilder: (context, index) {
                                  final item = pantryItems[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: PantryItemCard(item: item),
                                  );
                                },
                                itemCount: pantryItems.length,
                              ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
