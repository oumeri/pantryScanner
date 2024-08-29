import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Favorite Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.blue)),
      ), 
    );
  }
}