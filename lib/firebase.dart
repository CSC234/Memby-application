import 'package:flutter/material.dart';
import 'package:memby/screens/landingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:memby/models/OrderDetail.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:collection';

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

  Future<LinkedHashMap> _getProductSummary(target) async {
    print("-----------------Getting Product Summary-----------------");
    //Daily
    try {
      final user = _firebaseAuth.currentUser;
      final userId = user.uid;
      DateTime now = new DateTime.now();
      DateTime startDate = target == 'd'
          ? new DateTime(now.year, now.month, now.day)
          : target == 'm'
              ? new DateTime(now.year, now.month)
              : new DateTime(now.year);

      QuerySnapshot orders;
      orders = await _firestore
          .collection("company")
          .doc(userId)
          .collection("order")
          .orderBy("date")
          .startAt([startDate]).get();
      final orderDocs = orders.docs;
      print("Order Amounts " + orderDocs.length.toString());
      Map<String, dynamic> productSummary = {};
      for (QueryDocumentSnapshot o in orderDocs) {
        final Map<String, dynamic> productList = o.get('product_list');
        for (String productId in productList.keys) {
          int amount = productList[productId];
          if (productSummary[productId] == null) {
            DocumentReference targetProduct = _firestore
                .collection("company")
                .doc(userId)
                .collection("product")
                .doc(productId);

            DocumentSnapshot product = await targetProduct.get();
            productSummary[productId] = {
              'name': product.get('name'),
              'price': product.get('price'),
              'unitSale': amount,
              'totalSale':
                  amount * product.get('price') * (1 - o.get('discount_rate'))
            };
          } else {
            productSummary[productId]['unitSale'] += amount;
            productSummary[productId]['totalSale'] += amount *
                productSummary[productId]['price'] *
                (1 - o.get('discount_rate'));
          }
        }
      }
      print("---------Products---------");
      print(productSummary);

      var unsortedSummary = {};
      for (var i in productSummary.keys) {
        unsortedSummary[i] = productSummary[i]['totalSale'];
      }
      var sortedProductSummaryKeys = unsortedSummary.keys.toList(
          growable: false)
        ..sort((k2, k1) => unsortedSummary[k1].compareTo(unsortedSummary[k2]));
      LinkedHashMap sortedProductSummary = new LinkedHashMap.fromIterable(
          sortedProductSummaryKeys,
          key: (k) => k,
          value: (k) => productSummary[k]);

      print("---------Sorted Products---------");
      print(sortedProductSummary);
      print("-------------------------------------------------");

      return sortedProductSummary;
    } catch (err) {
      print('Caught error: $err');
      return null;
    }
  }

  getProductSummary(target) async {
    return await _getProductSummary(target);
  }

  Future<LinkedHashMap> _getCustomerSummary(target) async {
    print("-----------------Getting Customer Summary-----------------");
    //Daily
    try {
      final user = _firebaseAuth.currentUser;
      final userId = user.uid;
      DateTime now = new DateTime.now();
      DateTime startDate = target == 'd'
          ? new DateTime(now.year, now.month, now.day)
          : target == 'm'
              ? new DateTime(now.year, now.month)
              : new DateTime(now.year);

      QuerySnapshot orders;
      print(startDate);
      orders = await _firestore
          .collection("company")
          .doc(userId)
          .collection("order")
          .orderBy("date")
          .startAt([startDate]).get();
      final orderDocs = orders.docs;

      print("Order Amounts " + orderDocs.length.toString());
      Map<String, dynamic> customerSummary = {};
      for (QueryDocumentSnapshot o in orderDocs) {
        final String customerId = o.get('cus_id');
        if (customerId != null) {
          if (customerSummary[customerId] == null) {
            print(customerId);
            DocumentReference targetCustomer = _firestore
                .collection("company")
                .doc(userId)
                .collection("customer")
                .doc(customerId);

            DocumentSnapshot customer = await targetCustomer.get();
            print(customer.data());
            customerSummary[customerId] = {
              'name':
                  customer.get('firstname') + " " + customer.get('lastname'),
              'phone': customer.get('phone_no'),
              'totalPaid': o.get('total_price')
            };
          } else {
            customerSummary[customerId]['totalPaid'] += o.get('total_price');
          }
        }
      }
      print("---------Customer---------");
      print(customerSummary);

      var unsortedSummary = {};
      for (var i in customerSummary.keys) {
        unsortedSummary[i] = customerSummary[i]['totalPaid'];
      }
      var sortedCusotmerSummaryKeys = unsortedSummary.keys.toList(
          growable: false)
        ..sort((k2, k1) => unsortedSummary[k1].compareTo(unsortedSummary[k2]));
      LinkedHashMap sortedCustomerSummary = new LinkedHashMap.fromIterable(
          sortedCusotmerSummaryKeys,
          key: (k) => k,
          value: (k) => customerSummary[k]);

      print("---------Sorted Customer---------");
      print(sortedCustomerSummary);
      print("-------------------------------------------------");

      return sortedCustomerSummary;
    } catch (err) {
      print('Caught error: $err');
      return null;
    }
  }

  getCustomerSummary(target) async {
    return await _getCustomerSummary(target);
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

  Future<void> updateProduct(pid, name, description, price, img) async {
    final user = _firebaseAuth.currentUser;
    final userId = user.uid;
    final product = {
      'name': name,
      'description': description,
      'price': price,
      'product_img': img
    };
    await _firestore
        .collection("company")
        .doc(userId)
        .collection("product")
        .doc(pid)
        .update(product);
  }

  Future<QueryDocumentSnapshot> getCustomerFromPhoneNo(
      String customerPhone) async {
    final user = _firebaseAuth.currentUser;
    final userId = user.uid;
    print(customerPhone);
    DocumentReference targetCompany =
        _firestore.collection('company').doc(userId);
    QuerySnapshot customerRef = await targetCompany
        .collection('customer')
        .limit(1)
        .where('phone_no', isEqualTo: customerPhone)
        .get()
        .catchError((e) {
      print(e.toString());
    });
    if (customerRef.size == 0) {
      print("Not found");
      return null;
    }
    print(customerRef.docs[0]);
    // String customerName = customerRef.docs[0].get('firstname') +
    //     " " +
    //     customerRef.docs[0].get('lastname');

    return customerRef.docs[0];
  }

  Future<void> addOrder(
      customerId, discountRate, actualPrice, totalPrice, productList) async {
    final user = _firebaseAuth.currentUser;
    final userId = user.uid;

    Map<String, dynamic> order = {};
    DocumentReference targetCompany =
        _firestore.collection('company').doc(userId);

    order['cus_id'] = customerId;
    order['discount_rate'] = discountRate;
    order['product_list'] = productList;
    order['total_price'] = totalPrice;
    order['actual_price'] = actualPrice;
    order['date'] = FieldValue.serverTimestamp();
    print(order);
    CollectionReference orderCollection = targetCompany.collection('order');
    await orderCollection.add(order).catchError((e) {
      print(e.toString());
    });
  }

  Future<QuerySnapshot> _getProducts() async {
    try {
      final user = _firebaseAuth.currentUser;
      final userId = user.uid;
      QuerySnapshot products;
      products = await _firestore
          .collection("company")
          .doc(userId)
          .collection("product")
          .get();
      print(products);
      return products;
    } catch (err) {
      print('Caught error: $err');
      return null;
    }
  }

  getProducts() async {
    return await _getProducts();
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
      if (email != '' && password != '') {
        print("email and password" + email.toString() + password.toString());
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
      } else if (email == '' || password == '') {
        print('null');
      }
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
