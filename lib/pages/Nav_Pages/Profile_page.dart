import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantry_scanner/components/editable_text_field.dart';
import 'package:pantry_scanner/components/my_button.dart';
import 'package:pantry_scanner/pages/contexts/AppContext.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Log out user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final appContext = Provider.of<AppContext>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
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
                      child: SvgPicture.asset(
                        appContext.userProfile?['photoURL'] == '' ? 'assets/Icons/profile.svg' :  appContext.userProfile?['photoURL'],
                        color: Colors.white,
                        height: 100,
                        width: 100,
                      ),
        
                    ),
                  ),
            
                  // Name and Email fields
                  const SizedBox(height: 30),
                  EditableTextField(
                    initialValue: appContext.userProfile?['username'] ?? '',
                    labelText: 'Username',
                    onChanged: (value) {
                      print("Updated username: $value");
                    },
                    textColor: Colors.grey[800] ?? Colors.grey,
                  ),
        
                  const SizedBox(height: 20),
                  EditableTextField(
                    initialValue: appContext.userProfile?['email'] ?? '',
                    labelText: 'E-mail',
                    onChanged: (value) {
                      print("Updated email: $value");
                    },
                    textColor: Colors.grey[800] ?? Colors.grey,
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
      ),
    );
  }
 
}
