// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pantry_scanner/components/my_button.dart';
import 'package:pantry_scanner/components/my_textField.dart';
import 'package:pantry_scanner/pages/helper/helper_functions.dart';
import 'package:pantry_scanner/services/auth_service.dart';
import 'package:sign_in_button/sign_in_button.dart';
//import 'package:pantry_scanner/services/auth_service.dart';

class LoginPage extends StatefulWidget {

  final void Function()? onTap;

  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Stack(
        children: [
          // Background
         Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/BackgroundPatternFood.png'),
                fit: BoxFit.contain, // Adjust how the image fits within the container
                repeat: ImageRepeat.repeat, // This will repeat the image in both directions
              ),
            ),
          ),
          // Foreground content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo or any other image
                    SvgPicture.asset(
                      'assets/images/Logo.svg', // Path to your logo
                      height: 80.0,
                      width: 80.0,
                    ),
                    
                    const SizedBox(height: 20), // Spacing between widgets


                    Container(
                      padding: const EdgeInsets.all(23),
                      margin: const EdgeInsets.only(top: 40),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                            // log in form 
                            const Text(
                              "Log In",
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,

                              ),
                            ),

                            const SizedBox(height: 25), // Spacing between widgets
                      
                            // Email input
                           MyTextField(hintText: "Email",
                              obscureText: false, 
                              controller: emailController
                            ),
                            
                            const SizedBox(height: 20), // Spacing between widgets
                      
                            // Password input
                            MyTextField(hintText: "Password",
                              obscureText: true, 
                              controller: passwordController
                            ),
                            
                            const SizedBox(height: 15), // Spacing between widgets
                      
                           // Forgot password
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () => {},
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 15), // Spacing between widgets
                      
                            // Login button
                            MyButton(
                              text: "Login", 
                              onTap: () async {
                                await AuthService().login(context, emailController, passwordController);
                              },
                            ),
                          
                            const SizedBox(height: 15), // Spacing between widgets

                            //Divider line
                            const Text("Or",
                              style: TextStyle(
                                color:Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),

                            const SizedBox(height: 15), // Spacing between widgets

                            //Other login options
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Google sign in button
                                SignInButton(
                                  Buttons.google,
                                  onPressed: () async {
                                    await AuthService().signInWithGoogle(context);
                                  } ,
                                 
                                ),
                              ]
                            ),
                            
                            const SizedBox(height: 15), // Spacing between widgets
                      
                            // Don't have an account - Register
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have and account?",

                                  style:  TextStyle(
                                    color: Colors.white,

                                  ),
                                ),
                                GestureDetector(
                                  onTap: widget.onTap,
                                  child: const Text(
                                    "Register Here",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            
                        ]),
                    )

                   
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
