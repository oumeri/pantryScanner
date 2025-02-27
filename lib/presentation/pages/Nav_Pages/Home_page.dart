import 'package:flutter/material.dart';
import 'package:pantry_scanner/presentation/widgets/lostItemCard.dart';
import 'package:pantry_scanner/presentation/widgets/pantryItemCard.dart';
import 'package:pantry_scanner/presentation/pages/Nav_Pages/Scanner_page.dart';
import 'package:pantry_scanner/presentation/pages/SecondaryPages/Lost_Items_page.dart';
import 'package:pantry_scanner/contexts/AppContext.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

static const List<Map<String, dynamic>> lostItems = [
  {
    "itemId": "apple",
    "name": "Apple",
    "quantityLost": 3,
    "lostDate": "timestamp", // Replace with actual DateTime or timestamp
    "storagePlace": "Refrigerator"
  },
  {
    "itemId": "banana",
    "name": "Banana",
    "quantityLost": 2,
    "lostDate": "timestamp",
    "storagePlace": "Kitchen Counter"
  },
  {
    "itemId": "milk",
    "name": "Milk",
    "quantityLost": 1,
    "lostDate": "timestamp",
    "storagePlace": "Fridge Door"
  },
  {
    "itemId": "cheese",
    "name": "Cheese",
    "quantityLost": 1,
    "lostDate": "timestamp",
    "storagePlace": "Fridge Drawer"
  },
  {
    "itemId": "bread",
    "name": "Bread",
    "quantityLost": 1,
    "lostDate": "timestamp",
    "storagePlace": "Pantry"
  }
];


 static const List<Map<String, dynamic>> items = [
  {
    "itemId": "apple",
    "name": "Apple",
    "purchaseDate": "2024-06-10",
    "storagePlace": "Refrigerator",
    "state": "fresh",
    "quantity": 3,
    "imageUrl": "assets/images/itemImageTest.png",
    "expiryDate": "2024-06-20"
  },
  {
    "itemId": "banana",
    "name": "Banana",
    "purchaseDate": "2024-06-12",
    "storagePlace": "Kitchen Counter",
    "state": "fresh",
    "quantity": 6,
    "imageUrl": "assets/images/itemImageTest.png",
    "expiryDate": "2024-06-18"
  },
  {
    "itemId": "milk",
    "name": "Milk",
    "purchaseDate": "2024-06-08",
    "storagePlace": "Refrigerator",
    "state": "rotten",
    "quantity": 1,
    "imageUrl": "assets/images/itemImageTest.png",
    "expiryDate": "2024-06-14"
  },
  {
    "itemId": "bread",
    "name": "Bread",
    "purchaseDate": "2024-06-09",
    "storagePlace": "Pantry",
    "state": "Semi-fresh",
    "quantity": 1,
    "imageUrl": "assets/images/itemImageTest.png",
    "expiryDate": "2024-06-15"
  },
  {
    "itemId": "cheese",
    "name": "Cheese",
    "purchaseDate": "2024-06-05",
    "storagePlace": "Refrigerator",
    "state": "rotten",
    "quantity": 1,
    "imageUrl": "assets/images/itemImageTest.png",
    "expiryDate": "2024-06-10"
  }
];


  void navigateToLostItemsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LostItemsPage(),
      ),
    );
  }

  void navigateToScanePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ScannerPage(),
      ),
    );
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
              // Top Text: "Hello, Simo"
              Text(
                'Hello, ${appContext.userProfile?['name']}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color:Colors.black
                ),
              ),
             
              const SizedBox(height: 16),
        

              // Lost items Section
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Lost items title
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

                        // View all button
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

                    // Lost items display
                    lostItems.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(lostItems.length, (index) {
                                var item = lostItems[index];
                                return Lostitemcard(
                                  lostItem: item,
                                );
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


              // title
              const Text(
                'My Pantry',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
        
              // Pantry Section
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/BackgroundPatternFood.png'), 
                      fit: BoxFit.cover
                      
                    ),
                  ),
                   child: items.isEmpty
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
                              childAspectRatio: 2/3,
                            ),
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: PantryItemCard(item: item),
                              );
                            },
                            itemCount: items.length, // Adjust this to the number of items you have
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
