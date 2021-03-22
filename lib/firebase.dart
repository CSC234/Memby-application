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


//   Future<User> _handleSignIn() async {
//     User user;
//     bool userSignedIn = await _googleSignIn.isSignedIn();

//     setState(() {
//       isUserSignedIn = userSignedIn;
//     });

//     if (isUserSignedIn) {
//       user = _auth.currentUser;
//     } else {
//       final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       user = (await _auth.signInWithCredential(credential)).user;
//       userSignedIn = await _googleSignIn.isSignedIn();
//       setState(() {
//         isUserSignedIn = userSignedIn;
//       });
//     }

//     return user;
//   }













// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:google_sign_in/google_sign_in.dart';


// class Authentication {
//   static Future<User> signInWithGoogle({ context}) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User user;

//     final GoogleSignIn googleSignIn = GoogleSignIn();

//     final GoogleSignInAccount googleSignInAccount =
//         await googleSignIn.signIn();

//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );

//       try {
//         final UserCredential userCredential =
//             await auth.signInWithCredential(credential);

//         user = userCredential.user;
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'account-exists-with-different-credential') {
//           // handle the error here
//         }
//         else if (e.code == 'invalid-credential') {
//           // handle the error here
//         }
//       } catch (e) {
//         // handle the error here
//       }
//     }

//     return user;
//   }
// }

