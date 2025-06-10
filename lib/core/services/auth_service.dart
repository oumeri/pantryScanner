// ignore_for_file: use_build_context_synchronously

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:pantry_scanner/contexts/AppContext.dart";
import "package:pantry_scanner/core/helper/helper_functions.dart";
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
            .collection('users')
            .doc(firebaseUser!.uid)
            .get();

        // If the profile doesn't exist, create it
        if (!profileSnapshot.exists) {
          // Check if the user is not null
          // Create the user profile document
          await createUserProfile(firebaseUser, firebaseUser.displayName ?? 'Anonymous',appContext);
        }

       
      // To navigate to the next page
      Navigator.pop(context);

      
    } on FirebaseAuthException catch(error) {
      displayMessageToUser(error.code, context);
      Navigator.pop(context);
    } 

    
  }


  Future<void> login (BuildContext context, TextEditingController emailController, TextEditingController passwordController) async {
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
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        // If the profile doesn't exist, create it
        if (!profileSnapshot.exists) {
          throw Error();
        }

        //appContext.setUserProfile(await getUserProfile());

        // To navigate to the next page
        Navigator.pop(context);

      }on FirebaseAuthException catch(error)
      {
            // display error message
            displayMessageToUser(error.code, context);
            Navigator.pop(context);
      }finally{
        if(Navigator.canPop(context)){
          Navigator.pop(context);
        }
      }

    }


  Future<void> signup (BuildContext context, TextEditingController emailController, TextEditingController passwordController, TextEditingController confirmPasswordController, TextEditingController nameController) async {
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
        await createUserProfile(userCredential.user!, nameController.text, appContext);

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


    Future<void> createUserProfile(User user, String name, AppContext appContext, {bool isAdmin = false}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String uid = user.uid;

    // Define the profile data based on your schema
    Map<String, dynamic> userProfile = {
      "email": user.email,
      "name": name,
      "profilePic": user.photoURL ?? "",
      "createdAt": FieldValue.serverTimestamp(),
      "isAdmin": isAdmin,  // Adding admin field as per schema
    };

    // Save the profile data in Firestore under 'users' collection
    await firestore.collection('users').doc(uid).set(userProfile);

    // Initialize subcollections with placeholder data
    await _initializeUserSubcollections(uid);

    // Optionally update the AppContext with the new profile
    // appContext.setUserProfile(await getUserProfile());
  }

  // Function to initialize subcollections
  Future<void> _initializeUserSubcollections(String uid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Add an empty pantry placeholder
    await firestore.collection('users').doc(uid).collection('pantry').doc('placeholder').set({
      "message": "No items yet",
    });

    // Add an empty AI updates placeholder
    await firestore.collection('users').doc(uid).collection('ai_updates').doc('placeholder').set({
      "message": "No updates yet",
    });

    // Add an empty dashboard stats document
    await firestore.collection('users').doc(uid).collection('dashboard_stats').doc('stats').set({
      "mostPurchased": {},
      "mostWasted": {},
      "categoryBreakdown": {},
      "averageShelfLife": "0 days",
      "lastUpdated": FieldValue.serverTimestamp(),
    });

    // Add empty lost items tracking
    await firestore.collection('users').doc(uid).collection('lost_items').doc('placeholder').set({
      "message": "No lost items yet",
    });

    // Add empty lost stats tracking (weekly, monthly, most lost)
    await firestore.collection('users').doc(uid).collection('lost_stats').doc('weekly').set({
      "weekStartDate": FieldValue.serverTimestamp(),
      "weekEndDate": FieldValue.serverTimestamp(),
      "totalLost": 0,
      "lostItems": {},
    });

    await firestore.collection('users').doc(uid).collection('lost_stats').doc('monthly').set({
      "monthStartDate": FieldValue.serverTimestamp(),
      "monthEndDate": FieldValue.serverTimestamp(),
      "totalLost": 0,
      "lostItems": {},
    });

    await firestore.collection('users').doc(uid).collection('lost_stats').doc('most_lost').set({
      "lostItemsCount": {},
    });

    print("Subcollections initialized for user: $uid");
  }




}