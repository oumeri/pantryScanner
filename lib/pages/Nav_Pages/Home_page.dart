import 'package:flutter/material.dart';
import 'package:pantry_scanner/components/historyCard.dart';
import 'package:pantry_scanner/components/pantryItemCard.dart';
import 'package:pantry_scanner/components/my_button.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});


  static const List<Widget> history = [
      Text('History 1', style: TextStyle(fontSize: 20)),
      Text('History 2', style: TextStyle(fontSize: 20)),
      Text('History 3', style: TextStyle(fontSize: 20)),
      Text('History 4', style: TextStyle(fontSize: 20)),
      Text('History 5', style: TextStyle(fontSize: 20)),
      
    ];


 static const List<Map<String, dynamic>> items = [
       {"name": "Item 1", "image": "assets/images/itemImageTest.png", "status": "Good", "location": "Fridge", "boughtTime": "2022-01-01"},
       {"name": "Item 2", "image": "assets/images/itemImageTest.png", "status": "Consume Soon", "location": "Fridge", "boughtTime": "2022-01-01"},
       {"name": "Item 3", "image": "assets/images/itemImageTest.png", "status": "Expired", "location": "Fridge", "boughtTime": "2022-01-01"},
       {"name": "Item 4", "image": "assets/images/itemImageTest.png", "status": "Good", "location": "Fridge", "boughtTime": "2022-01-01"},
       {"name": "Item 5", "image": "assets/images/itemImageTest.png", "status": "Good", "location": "Fridge", "boughtTime": "2022-01-01"},
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Text: "Hello, Simo"
              const Text(
                'Hello, Simo',
                style: TextStyle(
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
                          'History',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        // view all button
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
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
                        ),

                      ],
                    ),
                    const SizedBox(height: 16),
        
                    // History items
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(history.length, (index) {
                          return Historycard(
                            history: history[index],
                          );
                        }),
                      ),
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
              
              const SizedBox(height: 8),

              // Add item button
              Center(
                child: MyButton(
                  onTap: () {},
                  text: "+ Add item", 
                  fontSize: 12,
                  color: Colors.black,
                  width: 105,
                  height: 25,
                  borderRadius: 20,
                  horizontalPadding: 20,
                  verticalPadding: 5,
                  ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
