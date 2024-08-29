
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pantry_scanner/pages/auth/get_started_page.dart';
import 'package:pantry_scanner/pages/Nav_Pages/Buttom_NavBar_Layout.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {


  bool hasSeenGetStarted  = false;


  void markGetStartedAsSeen() {
    //print("seen");
    setState(() {
      hasSeenGetStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          // user is logged in
          if(snapshot.hasData){
            return const ButtomNavbarLayout();
          }
          // here we should check if player has seen get started page
        
          // use is not logged in
          else{
            return const GetStarted();
          }
         
        }),
    );
  }
}

