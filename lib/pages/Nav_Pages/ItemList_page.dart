import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantry_scanner/components/empty.dart';
import 'package:pantry_scanner/components/itemCard.dart';

class ItemlistPage extends StatelessWidget {
  const ItemlistPage({super.key});


    static const List<Widget> items = [
      // Text('Item 1', style: TextStyle(fontSize: 20, color: Colors.black)),
      // Text('Item 2', style: TextStyle(fontSize: 20, color: Colors.black)),
      // Text('Item 3', style: TextStyle(fontSize: 20, color: Colors.black)),
      // Text('Item 4', style: TextStyle(fontSize: 20, color: Colors.black)),
      // Text('Item 5', style: TextStyle(fontSize: 20, color: Colors.black)),
      
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 8.0),
          child: Column(
            children: [

              // Title
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Text(
                    'Items List',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      
                    ),
                  ),
              ],
            ),

              const SizedBox(height: 16),

              // Search bar
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [

                    // Search Input
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search,
                            color: Colors.grey, // Icon color
                            size: 24,) // Icon size
                          ),
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                            color: Colors.grey, // Hint text color
                            fontSize: 16, // Hint text size
                          ),
                      
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16), // Adjust size
                        ),
                        style: const TextStyle(
                          fontSize: 16, // Text size inside the TextField
                          color: Colors.black, // Text color
                          
                        ),
                      ),
                    ),

                    // Filter button
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                          'assets/Icons/filter.svg', // Path to your custom icon image
                          color: Colors.black, // If you want to apply a color filter
                          width: 24, // Adjust the size of the icon
                          height: 24,
                        ),
                      ),

                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Grid view of items
              Expanded(
                child:items.isEmpty ?
                    const Center(
                      child: Empty(text:"No items found"),
                  )
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Itemcard(item: item);
                      },
                      itemCount: items.length, // Adjust this to the number of items you have
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
