import 'package:flutter/material.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Scanner Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.blue)),
      ), 
    );
  }
}