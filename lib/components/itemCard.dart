import 'package:flutter/material.dart';
import 'package:pantry_scanner/pages/dynamicPages/itemDetailPage.dart';

class Itemcard extends StatelessWidget {

  final Map<String, dynamic> item;


  const Itemcard({
      super.key,
      required this.item,
      });



  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.only(right: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), // Shadow color with opacity
                spreadRadius: 2, // How much the shadow spreads
                blurRadius: 5, // Softness of the shadow
                offset: const Offset(3, 3), // Position of the shadow (x, y)
              ),
            ],
        ),
        child: Stack(
          children:[ 

            // Background
            Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/BackgroundPatternFood.png'),
                  fit: BoxFit.contain, // Adjust how the image fits within the container
                  repeat: ImageRepeat.repeat, // This will repeat the image in both directions
                ),
              ),
            ),

            // Foreground content
            Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetailPage(item: item),
                  ),
                );
              },
              child: Column(
                children: [
                  
                  // Image
                  Container(
                    width: double.infinity,
                    height:100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8), // Top left corner
                          topRight: Radius.circular(8), // Top right corner
                        ),
                      image: DecorationImage(
                        image: AssetImage(item["image"] ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          
                  const SizedBox(height: 8),
          
                  // Name
                  Text(item["name"] ?? '', style: const TextStyle(fontSize: 20, color: Colors.black)),
                ],
              ),
              )
            ),
        ]),
     );
  }
}