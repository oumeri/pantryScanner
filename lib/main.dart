import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pantry_scanner/firebase_options.dart';
import 'package:pantry_scanner/presentation/pages/auth/auth.dart';
import 'package:pantry_scanner/contexts/AppContext.dart';
import 'package:pantry_scanner/presentation/theme/light_mode.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (_)=> AppContext(),
      child: const MyApp(),
    )
  );
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
