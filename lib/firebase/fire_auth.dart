import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../tools/logger_utils.dart';
import 'auth_enums.dart';

class FireAuth {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static String verificationID = '';

// =============== Google Auth Methods ===============
  static Future<GoogleSignInResults> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (await googleSignIn.isSignedIn()) {
        return GoogleSignInResults.alreadySignedIn;
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

        return GoogleSignInResults.signInCompleted;
      }
    } catch (e) {
      Logger.print("Error in Google sign in: $e");
      return GoogleSignInResults.signInNotCompleted;
    }
  }

  static Future<bool> googleLogOut() async {
    try {
      if (kDebugMode) {
        print('Google Log out');
      }

      await GoogleSignIn().signOut();
      _firebaseAuth.signOut();
      return true;
    } catch (e) {
      Logger.print("Error in log out: $e");
      return false;
    }
  }
}
