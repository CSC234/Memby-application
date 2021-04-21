import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:memby/components/rounded_button.dart';
import 'package:memby/components/ProductList.dart';
import 'package:memby/screens/addProductScreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memby/firebase.dart';
import 'package:memby/screens/homeScreen.dart';
import 'package:memby/components/emptyItem.dart';
import 'package:memby/screens/landingScreen.dart';
import 'package:memby/components/bottomSheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageProduct extends StatefulWidget {
  @override
  const ManageProduct({
    Key key,
  }) : super(key: key);

  _ManageProduct createState() => _ManageProduct();
}

class Product {
  String id;
  String product;
  String description;
  double price;
  String picture;
  bool visible;
  Product(
      {this.id,
      this.product,
      this.description,
      this.price,
      this.picture,
      this.visible});
}

class _ManageProduct extends State<ManageProduct> {
  Future _productsData;
  bool _alreadyLoadProductsFromFirestore = false;
  void initState() {
    super.initState();
    for (int i = 0; i < product.length; i++) {
      productHolder.add(Product(
        id: product[i].id,
        product: product[i].product,
        price: product[i].price,
        description: product[i].description,
        picture: product[i].picture,
        visible: product[i].visible,
      ));
    }
    _productsData = context.read<FlutterFireAuthService>().getProducts();
  }

  var _filterText = TextEditingController();

  List<Product> product = [];
  List<Product> productHolder = [];

  @override
  Widget build(BuildContext context) {
    product = productHolder;
    List<Product> renderFilter = product
        .where((el) =>
            el.product.toLowerCase().indexOf(_filterText.text.toLowerCase()) !=
                -1 ||
            _filterText.text.isEmpty)
        .toList();
    product = renderFilter;
    print(_filterText.text);
    if (_filterText.text.isEmpty) {
      product = productHolder;
    }
    print(productHolder);

    final firebaseUser = context.watch<User>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (firebaseUser == null) {
      print("Not Authenticated");
      print("Return To Home Page");
      return HomeScreen();
    }
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Row(
                        children: [
                          Container(
                            width: width * 0.15,
                            child: IconButton(
                                icon: Icon(Icons.arrow_back,
                                    color: Colors.grey[700]),
                                onPressed: () => Navigator.of(context).pop(false))),
                         
                          Container(
                            width: width * 0.8,
                            child: Text(
                              'Manage Product',
                              style: TextStyle(
                                  color: kPrimaryFont,
                                  fontSize: width * 0.1,
                                  fontFamily: 'Alef-Regular'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                          child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                'Customer Product List',
                                style: TextStyle(fontSize: 16),
                              )),
                          SizedBox(
                            width: 25,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: RoundedButton(
                                  color: kPrimaryLightColor,
                                  buttonHight: 45,
                                  fontsize: 15,
                                  buttonSize: 0.4,
                                  textColor: Colors.white,
                                  text: "Add prodct",
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return AddProductList();
                                        },
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      )),
                      Container(
                        child: SizedBox(
                          width: width * 0.9,
                          height: 30,
                          child: TextField(
                            controller: _filterText,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: 'What are you looking for?',
                              hintStyle: TextStyle(fontSize: 14),
                            ),
                            onSubmitted: (value) {
                              setState(() {});

                              print(_filterText.text);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: height * 0.73,
                        child: SingleChildScrollView(
                          child: FutureBuilder(
                              future: _productsData,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (!_alreadyLoadProductsFromFirestore) {
                                    final List<DocumentSnapshot> productDocs =
                                        snapshot.data.docs;

                                    for (int i = 0;
                                        i < productDocs.length;
                                        i++) {
                                      final pid = productDocs[i].id;
                                      final p = productDocs[i].data();
                                      product.add(Product(
                                          id: pid,
                                          product: p['name'],
                                          price: (p['price'].toDouble()),
                                          description: p['description'],
                                          picture: p['product_img'],
                                          visible: p['visible']));
                                    }

                                    _alreadyLoadProductsFromFirestore = true;
                                  }

                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 0,
                                      ),
                                      if (product.length != 0)
                                        for (int i = 0; i < product.length; i++)
                                          ProductList(
                                            visible: product[i].visible,
                                            render: false,
                                            picture: product[i].picture,
                                            product: product[i].product,
                                            description: product[i].description,
                                            price: product[i].price,
                                            press: () {
                                              startInputAction(i);
                                            },
                                          ),
                                      if (product.length == 0)
                                        EmptyList(
                                            text:
                                                'Customer Product is empty please add the product'),
                                    ],
                                  );
                                } else {
                                  return SizedBox(
                                      child: CircularProgressIndicator(),
                                      height: 100.0,
                                      width: 100.0);
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void startInputAction(int item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          child: BottomSheettest(
            testBoy: (pid, name, description, price, picture) => {
              context
                  .read<FlutterFireAuthService>()
                  .updateProduct(pid, name, description, price, picture),
              setState(() {})
            },
            product: product,
            item: item,
          )),
    );
  }
}
