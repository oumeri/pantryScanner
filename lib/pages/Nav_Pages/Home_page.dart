import 'package:flutter/material.dart';
import 'package:pantry_scanner/components/lostItemCard.dart';
import 'package:pantry_scanner/components/pantryItemCard.dart';
import 'package:pantry_scanner/pages/Nav_Pages/Scanner_page.dart';
import 'package:pantry_scanner/pages/SecondaryPages/Lost_Items_page.dart';
import 'package:pantry_scanner/pages/contexts/AppContext.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  static const List<Widget> lostItems = [
       Text('Item 1', style: TextStyle(fontSize: 20)),
       Text('Item 2', style: TextStyle(fontSize: 20)),
       Text('Item 3', style: TextStyle(fontSize: 20)),
       Text('Item 4', style: TextStyle(fontSize: 20)),
       Text('Item 5', style: TextStyle(fontSize: 20)),
      
    ];


 static const List<Map<String, dynamic>> items = [
       {"name": "Item 1", "image": "assets/images/itemImageTest.png", "status": "Good", "location": "Fridge", "boughtTime": "2022-01-01"},
       {"name": "Item 2", "image": "assets/images/itemImageTest.png", "status": "Consume Soon", "location": "Fridge", "boughtTime": "2022-01-01"},
       {"name": "Item 3", "image": "assets/images/itemImageTest.png", "status": "Expired", "location": "Fridge", "boughtTime": "2022-01-01"},
       {"name": "Item 4", "image": "assets/images/itemImageTest.png", "status": "Good", "location": "Fridge", "boughtTime": "2022-01-01"},
       {"name": "Item 5", "image": "assets/images/itemImageTest.png", "status": "Good", "location": "Fridge", "boughtTime": "2022-01-01"},
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
                'Hello, ${appContext.userProfile?['username']}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color:Colors.black
                ),
              ),
             
              const SizedBox(height: 16),
        
              // History Section
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // History title
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

                        // view all button
                        const Spacer(),
                        lostItems.isNotEmpty
                            ?  GestureDetector(
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
        
                    // History items
                    lostItems.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(lostItems.length, (index) {
                                return Lostitemcard(
                                  lostItem: lostItems[index],
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
                          )

                    
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
