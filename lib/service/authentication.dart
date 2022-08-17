import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'cloud_firestore.dart';

class Authentication {
  final CloudFirestore _cloudFirestore = CloudFirestore();

  Future<bool> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (await googleSignIn.isSignedIn()) {
        return true;
      } else {
        // Trigger the authentication flow
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        await FirebaseAuth.instance.signInWithCredential(credential);
        await _cloudFirestore.registerNewUser();
        return true;
      }
    } catch (e) {
      print("Error in Google sign in: $e");
      return false;
    }
  }

  Future<bool> logOut() async {
    try {
      if (kDebugMode) {
        print('Google Log out');
      }

      await GoogleSignIn().disconnect();
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error in Google Log Out: ${e.toString()}');
      }
      return false;
    }
  }
}
