import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantry_scanner/components/my_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Log out user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile title
                const Row(
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
          
                // Profile image placeholder
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.green[200],
                    child:  SvgPicture.asset(
                      'assets/Icons/profile.svg',
                      color: Colors.white,
                      height: 100,
                      width: 100,
                    )
                  ),
                ),
          
                // Name and Email fields
                const SizedBox(height: 30),
                const SizedBox(
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const SizedBox(
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                
                // Buttons
                const SizedBox(height: 30),
                MyButton(text: 
                "Change password", 
                onTap: () {},
                height: 40,
                fontSize: 16,
                color: const Color(0xFF8FDB9A),
                ),
                const SizedBox(height: 10),
                MyButton(text: 
                "Settings", 
                onTap: () {},
                height: 40,
                fontSize: 16,
                color: const Color(0xFF8FDB9A),
                ),
                const SizedBox(height: 10),
                MyButton(text: 
                "Support", 
                onTap: () {},
                height: 40,
                fontSize: 16,
                color: const Color(0xFF8FDB9A),
                ),
                const SizedBox(height: 10),
                MyButton(text: 
                "Log out", 
                onTap: logout,
                height: 40,
                fontSize: 16,
                color: const Color(0xFF8FDB9A),
                ),

                const SizedBox(height: 10),
                MyButton(text: 
                "Delete account", 
                onTap: () {},
                height: 40,
                fontSize: 16,
                color: const Color(0xFFDB8F8F),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
 
}
