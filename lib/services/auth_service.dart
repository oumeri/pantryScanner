import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";


class AuthService{

  // Google sign in
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Begin sign in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // Check if the user canceled the sign-in process
      if (gUser == null) {
        print("Sign-in process was canceled by the user.");
        return null;
      }

      // Obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential for user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in to app
      return await FirebaseAuth.instance.signInWithCredential(credential);
      
    } catch (e) {
      print("Error during Google sign-in: $e");
      return null;
    }
    
  }
}