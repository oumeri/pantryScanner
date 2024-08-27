// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pantry_scanner/components/my_button.dart';
import 'package:pantry_scanner/components/my_textField.dart';
import 'package:pantry_scanner/pages/helper/helper_functions.dart';

class SignupPage extends StatefulWidget {

  final void Function()? onTap;


  const SignupPage({super.key,this.onTap});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> signup () async {
   // show loading circle
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
      builder: (context) => const Center(
      child: CircularProgressIndicator(),
     ),
     );


   // password match
    if(passwordController.text != confirmPasswordController.text){
      // pop loading circle
      Navigator.pop(context);

      // display a error message
      displayMessageToUser("Password don't match", context);
    }else{
      // try creating user
      try{ 

        // create user
        UserCredential userCredential = 
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text, 
              password: passwordController.text);


        // create the user profile doc
        await createUserProfile(userCredential.user!, usernameController.text);

        // pop loading circle
        Navigator.pop(context);

       
     

      }on FirebaseAuthException catch(error)
      {
          // pop loading circle
          Navigator.pop(context);

          // display error message
          displayMessageToUser(error.code, context);
      } finally {
         // pop loading circle
          Navigator.pop(context);

      }

    }


   

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,

                              ),
                            ),


                             const SizedBox(height: 25), // Spacing between widgets
                      
                            // Email input
                            MyTextField(hintText: "Username",
                              obscureText: false, 
                              controller: usernameController
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

                            const SizedBox(height: 20), // Spacing between widgets
                      
                            // confirm Password input
                            MyTextField(hintText: "Confirm Password",
                              obscureText: true, 
                              controller: confirmPasswordController
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
                              text: "Sign Up", 
                              onTap:  signup,
                            ),
                          
                            const SizedBox(height: 15), // Spacing between widgets
                      
                            // already have an account log in
                             Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have and account?",

                                  style:  TextStyle(
                                    color: Colors.white,

                                  ),
                                ),
                                GestureDetector(
                                  onTap: widget.onTap,
                                  child: const Text(
                                    "Log In",
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
