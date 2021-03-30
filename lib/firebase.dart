import 'package:flutter/material.dart';
import 'package:memby/screens/landingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FlutterFireAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FlutterFireAuthService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    bool isSignedWithGoogle = await _googleSignIn.isSignedIn();
    if (isSignedWithGoogle) {
      await _googleSignIn.signOut();
    }
  }

  Future<void> addProduct(name, description, price, img) async {
    final user = _firebaseAuth.currentUser;
    final userId = user.uid;
    final product = {
      'name': name,
      'description': description,
      'price': price,
      'product_img': img
    };
    DocumentReference targetCompany =
        _firestore.collection('company').doc(userId);
    CollectionReference productCollection = targetCompany.collection('product');
    await productCollection.add(product).catchError((e) {
      print(e.toString());
    });
  }

  Future<dynamic> _getUserInfo() async {
    try {
      final user = _firebaseAuth.currentUser;
      final userId = user.uid;
      dynamic userInfo;
      userInfo = await _firestore.collection("company").doc(userId).get();
      return userInfo;
    } catch (err) {
      print('Caught error: $err');
      return {'name': 'Error', 'logo': 'Error'};
    }
  }

  getUserInfo() async {
    return await _getUserInfo();
  }

  Future<void> addCustomer(
      firstName, lastName, email, phone, birthdate, gender, address) async {
    final user = _firebaseAuth.currentUser;
    final userId = user.uid;
    final customer = {
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      "phone_no": phone,
      'birthdate': birthdate,
      'gender': gender,
      'address': address
    };
    DocumentReference targetCompany =
        _firestore.collection('company').doc(userId);
    CollectionReference productCollection =
        targetCompany.collection('customer');
    await productCollection.add(customer).catchError((e) {
      print(e.toString());
    });
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
    UserCredential authUser =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (authUser.additionalUserInfo.isNewUser) {
      var bussinessProfile = authUser.additionalUserInfo.profile;

      await _firestore.collection('company').doc(authUser.user.uid).set({
        'id': authUser.user.uid,
        'name': bussinessProfile['given_name'],
        'logo': bussinessProfile['picture']
      });
    }
    return "Success";
  }

  Future<String> signUp(
      {String email,
      String password,
      String bussinessName,
      BuildContext context}) async {
    try {
      UserCredential authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User newUser = authResult.user;
      await _firestore.collection('company').doc(newUser.uid).set({
        'id': newUser.uid,
        'name': bussinessName,
        'logo':
            "https://firebasestorage.googleapis.com/v0/b/memby-application.appspot.com/o/Group%2051.png?alt=media&token=be571d82-c69e-4bad-b200-a12d977e813d"
      });
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

  Future<String> uploadImageToFirebase(img) async {
    final String userId = _firebaseAuth.currentUser.uid;
    // String fileName = userId + DateTime.now().toString();

    String fileName = userId + DateTime.now().microsecond.toString();
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('products/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(img);
    String url;
    await uploadTask.whenComplete(() async {
      url = await uploadTask.snapshot.ref.getDownloadURL();
    }).catchError((onError) {
      print(onError);
    });
    return url;
  }

  Future<void> removeImageFromFirebase(imgUrl) async {
    print(imgUrl);
    // FirebaseStorage.instance.ref(imgUrl).delete().
    FirebaseStorage.instance.refFromURL(imgUrl).delete().then((_) {
      print('Remove Img Successfully');
    }).catchError((e) {
      print("Remove Img Error: $e");
    });
  }
}

  // Future uploadImageToFirebase(BuildContext context) async {
  //   String fileName = basename(_image.path);
  //   StorageReference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child('uploads/$fileName');
  //   StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
  //   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  //   taskSnapshot.ref.getDownloadURL().then(
  //         (value) => print("Done: $value"),
  //       );
  // }