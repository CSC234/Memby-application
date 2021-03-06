import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memby/screens/landingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:collection';

class FlutterFireAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FlutterFireAuthService(this._firebaseAuth);
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  // Genneral Function

  String _getUserId() {
    final user = _firebaseAuth.currentUser;
    final userId = user.uid;
    return userId;
  }

  DocumentReference _getCompanyDoc() {
    return _firestore.collection("company").doc(_getUserId());
  }

  // USER AUTHENTICATION  API

  void _redirectToHomePage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Landing(),
      ),
    );
  }

  Future<String> signIn(
      {String email, String password, BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _redirectToHomePage(context);
      return "Welcome Back to Memby Application!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } on PlatformException catch (e) {
      return ("Invaild Username or Password!");
    }
  }

  Future<String> signInWithGoogle({BuildContext context}) async {
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
    try {
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
      _redirectToHomePage(context);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }

    return "Welcome to Memby Application!";
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    bool isSignedWithGoogle = await _googleSignIn.isSignedIn();
    if (isSignedWithGoogle) {
      await _googleSignIn.signOut();
    }
  }

  Future<String> changePassword({
    String oldPassword,
    String newPassword,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      final email = user.email;
      final bool isNotEmpty =
          email != '' && oldPassword != '' && newPassword != "";
      if (!isNotEmpty) {
        return "Failed to change your password";
      }

      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: oldPassword);
      if (result.user == null) {
        return "Failed to change your password";
      }
      await user.updatePassword(newPassword);
      return "Your password has been updated!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> updateProfile(companyName, logoImg) async {
    final userId = _getUserId();
    final profile = logoImg != null
        ? {'name': companyName, 'logo': logoImg}
        : {'name': companyName};
    await _firestore.collection("company").doc(userId).update(profile);
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
      return "Welcome to Memby Application!";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }

// Dashbaard Function

  DateTime _getDashboardDate(timeInterval) {
    DateTime now = new DateTime.now();
    DateTime startDate = timeInterval == 'd'
        ? new DateTime(now.year, now.month, now.day)
        : timeInterval == 'm'
            ? new DateTime(now.year, now.month)
            : new DateTime(now.year);
    return startDate;
  }

  Future<List<QueryDocumentSnapshot>> _getOrdersDoc(timeInterval) async {
    final DateTime startDate = _getDashboardDate(timeInterval);
    final QuerySnapshot orders = await _getCompanyDoc()
        .collection("order")
        .orderBy("date")
        .startAt([startDate]).get();
    return orders.docs;
  }

  LinkedHashMap _getSortedDashboardSummary(
      Map<String, dynamic> summary, String sortBy) {
    var unsortedSummary = {};
    for (var i in summary.keys) {
      unsortedSummary[i] = summary[i][sortBy];
    }
    var sortedSummaryKeys = unsortedSummary.keys.toList(growable: false)
      ..sort((k2, k1) => unsortedSummary[k1].compareTo(unsortedSummary[k2]));
    LinkedHashMap sortedSummary = new LinkedHashMap.fromIterable(
        sortedSummaryKeys,
        key: (k) => k,
        value: (k) => summary[k]);

    return sortedSummary;
  }

  Future<LinkedHashMap> _sumUpTopCustomer(orderDocs) async {
    Map<String, dynamic> customerSummary = {};
    for (QueryDocumentSnapshot o in orderDocs) {
      final String customerId = o.get('cus_id');
      if (customerId != null) {
        if (customerSummary[customerId] == null) {
          DocumentReference targetCustomer =
              _getCompanyDoc().collection("customer").doc(customerId);

          DocumentSnapshot customer = await targetCustomer.get();
          customerSummary[customerId] = {
            'name': customer.get('firstname') + " " + customer.get('lastname'),
            'phone': customer.get('phone_no'),
            'totalPaid': o.get('total_price')
          };
        } else {
          customerSummary[customerId]['totalPaid'] += o.get('total_price');
        }
      }
    }
    return _getSortedDashboardSummary(customerSummary, 'totalPaid');
  }

  Future<LinkedHashMap> _sumUpTopProduct(orderDocs) async {
    Map<String, dynamic> productSummary = {};
    for (QueryDocumentSnapshot o in orderDocs) {
      final Map<String, dynamic> productList = o.get('product_list');
      for (String productId in productList.keys) {
        int amount = productList[productId];
        if (productSummary[productId] == null) {
          DocumentReference targetProduct =
              _getCompanyDoc().collection("product").doc(productId);
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
    return _getSortedDashboardSummary(productSummary, 'totalSale');
  }

// Getter Function

  Future<dynamic> _getUserInfo() async {
    try {
      dynamic userInfo = await _getCompanyDoc().get();
      return userInfo;
    } catch (err) {
      print('Caught error: $err');
      return {'name': 'Error', 'logo': 'Error'};
    }
  }

  Future<dynamic> _getProductbyID(String id) async {
    dynamic product = {
      'name': 'Not Found',
      'description': '',
      'product_img': '',
      'price': 0
    };
    if (id == 'n') {
      return product;
    }
    try {
      product = await _getCompanyDoc().collection("product").doc(id).get();
    } catch (err) {
      print('Caught error: $err');
    }
    return product;
  }

  Future<QuerySnapshot> _getProducts({bool visible}) async {
    try {
      QuerySnapshot products;
      CollectionReference productsRef = _getCompanyDoc().collection("product");
      if (visible != null) {
        products = await productsRef.where('visible', isEqualTo: visible).get();
      } else {
        products = await productsRef.orderBy('visible', descending: true).get();
      }
      return products;
    } catch (err) {
      print('Caught error: $err');
      return null;
    }
  }

  Future<LinkedHashMap> _getProductSummary(timeInterval) async {
    //Daily
    try {
      final orderDocs = await _getOrdersDoc(timeInterval);
      return await _sumUpTopProduct(orderDocs);
    } catch (err) {
      print('Caught error: $err');
      return null;
    }
  }

  Future<LinkedHashMap> _getCustomerSummary(targetTime) async {
    try {
      final orderDocs = await _getOrdersDoc(targetTime);
      return await _sumUpTopCustomer(orderDocs);
    } catch (err) {
      print('Caught error: $err');
      return null;
    }
  }

// GET API

  getProductSummary(timeInterval) async {
    return await _getProductSummary(timeInterval);
  }

  getCustomerSummary(timeInterval) async {
    return await _getCustomerSummary(timeInterval);
  }

  getProducts({bool visible}) async {
    return await _getProducts(visible: visible);
  }

  getUserInfo() async {
    return await _getUserInfo();
  }

  getProductbyID(id) async {
    return await _getProductbyID(id);
  }

  Future<QueryDocumentSnapshot> getCustomerFromPhoneNo(
      String customerPhone) async {
    QuerySnapshot customerRef = await _getCompanyDoc()
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
    return customerRef.docs[0];
  }

  Future<bool> isCustomerPhoneDuplicate(String customerPhone) async {
    QuerySnapshot customerRef = await _getCompanyDoc()
        .collection('customer')
        .limit(1)
        .where('phone_no', isEqualTo: customerPhone)
        .get()
        .catchError((e) {
      print(e.toString());
    });
    if (customerRef.size == 1) {
      return true;
    }
    return false;
  }

// INSERT API

  Future<void> addProduct(name, description, price, img) async {
    final product = {
      'name': name,
      'description': description,
      'price': price,
      'product_img': img,
      'visible': true
    };
    CollectionReference productCollection =
        _getCompanyDoc().collection('product');
    await productCollection.add(product).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addOrder(
      customerId, discountRate, actualPrice, totalPrice, productList) async {
    Map<String, dynamic> order = {};

    order['cus_id'] = customerId;
    order['discount_rate'] = discountRate;
    order['product_list'] = productList;
    order['total_price'] = totalPrice;
    order['actual_price'] = actualPrice;
    order['date'] = FieldValue.serverTimestamp();
    CollectionReference orderCollection = _getCompanyDoc().collection('order');
    try {
      await orderCollection.add(order);
    } catch (err) {
      print('Caught error: $err');
    }
  }

  Future<void> addCustomer(
      firstName, lastName, email, phone, birthdate, gender, address) async {
    final customer = {
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      "phone_no": phone,
      'birthdate': birthdate,
      'gender': gender,
      'address': address
    };
    final CollectionReference productCollection =
        _getCompanyDoc().collection('customer');
    try {
      await productCollection.add(customer);
    } catch (err) {
      print('Caught error: $err');
    }
  }

// UPDATE API

  Future<void> updateProduct(pid, name, description, price, img) async {
    final product = {
      'name': name,
      'description': description,
      'price': price,
      'product_img': img
    };
    await _getCompanyDoc().collection("product").doc(pid).update(product);
  }

  Future<void> updateVisible(pid, visible) async {
    final product = {
      'visible': visible,
    };
    await _getCompanyDoc().collection("product").doc(pid).update(product);
  }

// FIREBASE STROAGE API

  Future<String> uploadImageToFirebase(img) async {
    final String fileName =
        _getUserId() + DateTime.now().microsecond.toString();
    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('products/$fileName');
    final UploadTask uploadTask = firebaseStorageRef.putFile(img);
    String url;
    await uploadTask.whenComplete(() async {
      url = await uploadTask.snapshot.ref.getDownloadURL();
    }).catchError((onError) {
      print(onError);
    });
    return url;
  }

  Future<void> removeImageFromFirebase(imgUrl) async {
    FirebaseStorage.instance.refFromURL(imgUrl).delete().then((_) {
      print('Remove Img Successfully');
    }).catchError((e) {
      print("Remove Img Error: $e");
    });
  }
}
