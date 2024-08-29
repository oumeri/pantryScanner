import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantry_scanner/components/my_button.dart';
import 'package:pantry_scanner/pages/auth/login_or_signup.dart';

class GetStarted extends StatelessWidget {
  

  const GetStarted({
    super.key, 
    });


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [


            SvgPicture.asset(
                'assets/images/Logo2.svg', // Path to your logo
                height: 200.0,
                width: 200.0,
                ),
                    
            const SizedBox(height: 130), // Spacing between widgets


            const Text(
                "Welcome to pantry scanner",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const SizedBox(height: 60), // Spacing between widgets
                      
            // Get Started button
            MyButton(
              text: "Get Started", 
              onTap: ()=>{
                  // Navigate to Login/Signup page             
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginOrSignup()),
                  )

              },
            ),
          ]),
      )
    );
  }
}