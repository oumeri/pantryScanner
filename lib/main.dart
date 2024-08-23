import 'package:flutter/material.dart';
import 'package:pantry_scanner/pages/get_started_page.dart';
import 'package:pantry_scanner/theme/light_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lighMode,
      home: const GetStarted(),
    );
  }
}