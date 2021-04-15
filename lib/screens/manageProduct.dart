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
  String product;
  String description;
  int price;
  String picture;

  Product({this.product, this.description, this.price, this.picture});
}

class _ManageProduct extends State<ManageProduct> {
  List<Product> product = [
    Product(
        product: 'Selsun Selenium sulfide',
        description: 'Lorem ipsum, or lipsum as it is sometimes known',
        price: 120,
        picture: 'assets/images/profile.png'),
    Product(
        product: 'Selsun Selenium sulfide',
        description: 'Lorem ipsum, or lipsum as it is sometimes known',
        price: 120,
        picture: 'assets/images/profile.png'),
    Product(
        product: 'Selsun Selenium sulfide',
        description: 'Lorem ipsum, or lipsum as it is sometimes known',
        price: 120,
        picture: 'assets/images/profile.png'),
    Product(
        product: 'Selsun Selenium sulfide',
        description: 'Lorem ipsum, or lipsum as it is sometimes known',
        price: 120,
        picture: 'assets/images/profile.png'),
    Product(
        product: 'Selsun Selenium sulfide',
        description: 'Lorem ipsum, or lipsum as it is sometimes known',
        price: 120,
        picture: 'assets/images/profile.png')
  ];

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
        bottomNavigationBar: NavKT(
          currentIndex: 3,
        ),
        body: Container(
          child: Container(
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
                                  fontSize: 40,
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
                        height: height * 0.65,
                        child: SingleChildScrollView(
                          child: Column(
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
                                      startInputAction(context);
                                    },
                                  ),
                              if (product.length == 0)
                                EmptyList(
                                    text:
                                        'Customer Product is empty please add the product'),
                            ],
                          ),
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

  void startInputAction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Center(
          child: Text("test"),
        ),
      ),
    );
  }
}
