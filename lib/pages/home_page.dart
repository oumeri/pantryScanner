import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // log out user
  void logout (){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: logout, 
            icon:  const Icon(Icons.logout))
        ],),
      backgroundColor: Colors.white,
      body: const Center(
        child: Text(
          "Welcom to pantry Scanner",
          style: TextStyle(color: Colors.black))
        ,
      ),
    );
  }
}