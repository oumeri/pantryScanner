import 'package:flutter/material.dart';

class ItemDetailPage extends StatelessWidget {

  final Map<String, dynamic> item;


  const ItemDetailPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(item["name"]),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            // Image
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(item["image"] ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
             // Name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Name: ${item["name"]}", style: const TextStyle(fontSize: 18, color: Colors.black)),
            ),
            // Bought date
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Bought date: ${item["boughtTime"]}", style: const TextStyle(fontSize: 18, color: Colors.black)),
            ),
            // Status
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Status: ${item["status"]}", style: const TextStyle(fontSize: 18, color: Colors.black)),
            ),
            // location
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Location: ${item["location"]}", style: const TextStyle(fontSize: 18, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}