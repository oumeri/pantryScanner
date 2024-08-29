import 'package:flutter/material.dart';

class ItemlistPage extends StatelessWidget {
  const ItemlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('ItemList Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.blue)),
      ), 
    );
  }
}