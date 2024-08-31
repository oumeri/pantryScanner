import 'package:flutter/material.dart';
import 'package:pantry_scanner/components/historyCard.dart';
import 'package:pantry_scanner/components/itemCard.dart';
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


  static const List<Widget> items = [
      Text('Item 1', style: TextStyle(fontSize: 20, color: Colors.black)),
      Text('Item 2', style: TextStyle(fontSize: 20, color: Colors.black)),
      Text('Item 3', style: TextStyle(fontSize: 20, color: Colors.black)),
      Text('Item 4', style: TextStyle(fontSize: 20, color: Colors.black)),
      Text('Item 5', style: TextStyle(fontSize: 20, color: Colors.black)),
      
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
                        : GridView.count(
                            crossAxisCount: 2, // Number of items per row
                            crossAxisSpacing: 10.0, // Horizontal space between items
                            mainAxisSpacing: 10.0, // Vertical space between items
                            padding: const EdgeInsets.all(20.0),
                            children: items.map((item) => Itemcard(item: item)).toList(),
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
