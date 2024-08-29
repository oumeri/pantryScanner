import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // log out user
  void logout (){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             const Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.blue)),

            GestureDetector(
              onTap: logout,
              child:const Icon(Icons.logout),
            )
          ],
        ),
      ), 
    );
  }
}