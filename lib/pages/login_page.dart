import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pantry_scanner/components/my_button.dart';
import 'package:pantry_scanner/components/my_textField.dart';
import 'package:pantry_scanner/pages/signup_page.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});
  
  void login () {

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                            
                            const SizedBox(height: 5), // Spacing between widgets
                      
                            // Forgot password
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Handle forgot password
                                  },
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding
                                      textStyle: const TextStyle(
                                        fontSize: 16, // Font size
                                        fontWeight: FontWeight.bold, // Font weight
                                    ),
                                  ),
                                  child: const Text('Forgot Password?'),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 5), // Spacing between widgets
                      
                            // Login button
                            MyButton(
                              text: "Login", 
                              onTap: login,
                            ),
                          
                            const SizedBox(height: 5), // Spacing between widgets
                      
                            // Don't have an account - Register
                            TextButton(
                              onPressed: () {
                                 Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SignupPage()),
                                  );
                              },
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding
                                  textStyle: const TextStyle(
                                    fontSize: 16, // Font size
                                    fontWeight: FontWeight.bold, // Font weight
                                ),
                              ),
                              child: const Text("Don't have an account? Register"),
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
