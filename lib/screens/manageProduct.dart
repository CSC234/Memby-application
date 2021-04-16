import 'package:flutter/material.dart';
import 'package:memby/components/Register/AcknowlwdgementBox.dart';
import 'package:memby/components/imagePicker.dart';
import 'package:memby/constants.dart';
import 'package:memby/components/rounded_button.dart';
import 'package:memby/components/ProductList.dart';
import 'package:memby/screens/addProductScreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memby/firebase.dart';
import 'package:memby/screens/homeScreen.dart';
import 'package:memby/components/emptyItem.dart';
import 'package:memby/components/bottomNav/nav.dart';
import 'package:memby/screens/landingScreen.dart';
import 'package:memby/components/Textfield.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ManageProduct extends StatefulWidget {
  @override
  final ValueChanged<String> onChanged;

  const ManageProduct({
    Key key,
    this.onChanged,
  }) : super(key: key);

  _ManageProduct createState() => _ManageProduct();
}

class Product {
  String id;
  String product;
  String description;
  double price;
  String picture;

  Product({this.id, this.product, this.description, this.price, this.picture});
}

class _ManageProduct extends State<ManageProduct> {
  Future _productsData;
  bool _alreadyLoadProductsFromFirestore = false;
  void initState() {
    super.initState();
    _productsData = context.read<FlutterFireAuthService>().getProducts();
  }

  List<Product> product = [];

  @override
  Widget build(BuildContext context) {
    final _productnameController = TextEditingController();
    final _descriptionController = TextEditingController();
    final _priceController = TextEditingController();
    final _pictureController = TextEditingController();

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
                                onPressed: () =>
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return Landing();
                                      },
                                    ))),
                          ),
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
                            // controller:
                            //     _filterText,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: 'What are you looking for?',
                              hintStyle: TextStyle(fontSize: 14),
                            ),
                            onSubmitted: (value) {
                              setState(() {});

                              // print(
                              //     _filterText
                              //         .text);
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
                                          picture: p['product_img']));
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

                          ///////////////
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
    String _uploadedFileURL;
    File _image;

    final picker = ImagePicker();
    Future _pickImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      print("filename" + _image.toString());

      setState(() {
        _image = File(pickedFile.path);
      });
    }

    final _productnameController = TextEditingController();

    final _descriptionController = TextEditingController();
    final _priceController = TextEditingController();
    final _pictureController = TextEditingController();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  UserImagePicker(press: _pickImage, pickedImage: _image)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Textfield(
                    // controller: _productnameController,
                    value: product[item].product,
                    text: 'Product name...',
                    width: width * (90 / 100),
                    min: 1,
                    max: 5,
                  ),
                  Textfield(
                    // controller: _descriptionController,
                    value: product[item].description,
                    text: 'Description...',
                    width: width * (90 / 100),
                    min: 3,
                    max: 5,
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Textfield(
                    // controller: _priceController,
                    value: product[item].price.toString(),
                    width: width * (90 / 100),
                    text: 'Price',
                    min: 1,
                    max: 5,
                  ),
                ],
              ),
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: RoundedButton(
                      color: kPrimaryLightColor,
                      buttonHight: 50,
                      fontsize: 15,
                      buttonSize: 0.7,
                      textColor: Colors.white,
                      text: "Update Product",
                      press: () {
                        // addProduct(
                        //     _productnameController.text,
                        //     _descriptionController.text,
                        //     _priceController.text,
                        //     _pictureController.text);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
