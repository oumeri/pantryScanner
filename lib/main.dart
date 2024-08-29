import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pantry_scanner/firebase_options.dart';
import 'package:pantry_scanner/pages/auth/auth.dart';

import 'package:pantry_scanner/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pantry Scanner',
      theme: lighMode,
      debugShowCheckedModeBanner: false,
      home: const Auth(),
    );
  }
}
