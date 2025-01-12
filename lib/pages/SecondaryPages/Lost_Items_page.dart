import 'package:flutter/material.dart';
import 'package:pantry_scanner/components/lostItemCard.dart';

class LostItemsPage extends StatelessWidget {
  const LostItemsPage({super.key});

  static const List<Widget> lostItems = [
       Text('Item 1', style: TextStyle(fontSize: 20)),
       Text('Item 2', style: TextStyle(fontSize: 20)),
       Text('Item 3', style: TextStyle(fontSize: 20)),
       Text('Item 4', style: TextStyle(fontSize: 20)),
       Text('Item 5', style: TextStyle(fontSize: 20)),
      
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Lost Items',
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
            Container(
                height: 200,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'This Week',
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
                          children: List.generate(lostItems.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Lostitemcard(
                                lostItem: lostItems[index],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
            ),
        
            Container(
                height: 200,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'This month',
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
                          children: List.generate(lostItems.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Lostitemcard(
                                lostItem: lostItems[index],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
            ),
            
            Container(
                height: 200,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Top items',
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
                          children: List.generate(lostItems.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Lostitemcard(
                                lostItem: lostItems[index],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      )
    );
  }
}