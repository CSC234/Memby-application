import 'package:flutter/material.dart';
import 'package:memby/screens/landingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FlutterFireAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FlutterFireAuthService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    bool isSignedWithGoogle = await _googleSignIn.isSignedIn();
    if (isSignedWithGoogle) {
      await _googleSignIn.signOut();
    }
  }

  Future<String> signIn(
      {String email, String password, BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print("Signed In");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Landing(),
        ),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }

  Future<String> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    return "Success";
  }

  Future<String> signUp(
      {String email, String password, BuildContext context}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Landing(),
        ),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }
}
