// ignore_for_file: use_build_context_synchronously

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:pantry_scanner/pages/contexts/AppContext.dart";
import "package:pantry_scanner/pages/helper/helper_functions.dart";
import "package:provider/provider.dart";


class AuthService{

  // Google sign in
  Future<void> signInWithGoogle(BuildContext context) async {
    final appContext = Provider.of<AppContext>(context, listen: false);

    // show loading circle
     showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
      builder: (context) => const Center(
      child: CircularProgressIndicator(),
     ),
     );

    try {
      // Begin sign in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
     
      // Check if the user canceled the sign-in process
      if (gUser == null) {
        displayMessageToUser("Sign-in process was canceled by the user.", context);
      }


      // Obtain auth details from request
      final GoogleSignInAuthentication? gAuth = await gUser?.authentication;
     
      // Create a new credential for user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth?.accessToken,
        idToken: gAuth?.idToken,
      );

     
       // Sign in to Firebase
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      User? firebaseUser = userCredential.user;


       // Check if the user profile already exists
        DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance
            .collection('profiles')
            .doc(firebaseUser!.uid)
            .get();

        // If the profile doesn't exist, create it
        if (!profileSnapshot.exists) {
          // Check if the user is not null
          // Create the user profile document
          await createUserProfile(firebaseUser, firebaseUser.displayName ?? 'Anonymous',appContext);
        }

       

      // To pop the loading circle
      Navigator.pop(context);
      // To navigate to the next page
      Navigator.pop(context);

      
    } on FirebaseAuthException catch(error) {
      displayMessageToUser(error.code, context);
      Navigator.pop(context);
    } 

    
  }


  Future<void> login (BuildContext context, TextEditingController emailController, TextEditingController passwordController) async {
    final appContext = Provider.of<AppContext>(context, listen: false);

      // show loading circle
     showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
      builder: (context) => const Center(
      child: CircularProgressIndicator(),
     ),
     );


      // try creating user
      try{ 

        // log in
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text, 
              password: passwordController.text);

        // Check if the user profile already exists
        DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance
            .collection('profiles')
            .doc(userCredential.user!.uid)
            .get();

        // If the profile doesn't exist, create it
        if (!profileSnapshot.exists) {
          throw Error();
        }

        appContext.setUserProfile(await getUserProfile());

        // To pop the loading circle
        Navigator.pop(context);
        // To navigate to the next page
        Navigator.pop(context);

      }on FirebaseAuthException catch(error)
      {
            // display error message
            displayMessageToUser(error.code, context);
            Navigator.pop(context);
      }

    }


  Future<void> signup (BuildContext context, TextEditingController emailController, TextEditingController passwordController, TextEditingController confirmPasswordController, TextEditingController usernameController) async {
    final appContext = Provider.of<AppContext>(context, listen: false);

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
        await createUserProfile(userCredential.user!, usernameController.text, appContext);

         // To pop the loading circle
        Navigator.pop(context);
        // To navigate to the next page
        Navigator.pop(context);
       
     

      }on FirebaseAuthException catch(error)
      {
          // pop loading circle
          Navigator.pop(context);

          // display error message
          displayMessageToUser(error.code, context);
      }

    }


   

  }


  Future<void> createUserProfile(User user, String username,AppContext appContext) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Define the profile data
    Map<String, dynamic> userProfile = {
      'uid': user.uid,
      'email': user.email,
      "username": username,
      'firstName': '',
      'lastName': '',
      'photoURL': user.photoURL ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    };

    // Save the profile data in Firestore under 'profiles' collection
    await firestore.collection('profiles').doc(user.uid).set(userProfile);
    appContext.setUserProfile(await getUserProfile());
    
  }

  Future<DocumentSnapshot> getUserProfile() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception("No user is currently signed in.");
    }

    return await FirebaseFirestore.instance
        .collection('profiles')
        .doc(currentUser.uid)
        .get();
  }



}