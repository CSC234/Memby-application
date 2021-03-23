import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:memby/components/rounded_button.dart';
import 'package:memby/components/ProductList.dart';
import 'package:memby/components/Textfield.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memby/firebase.dart';
import 'package:memby/screens/homeScreen.dart';
import 'package:memby/components/emptyItem.dart';

class AddProductList extends StatefulWidget {
  @override
  final ValueChanged<String> onChanged;

  const AddProductList({
    Key key,
    this.onChanged,
  }) : super(key: key);

  _AddProductList createState() => _AddProductList();
}

class Product {
  String product;
  String description;
  int price;

  Product({this.product, this.description, this.price});
}

class _AddProductList extends State<AddProductList> {
  List<Product> product = [];

  void addProduct(productName, description, price) {
    setState(() {
      product.add(new Product(
          product: productName,
          description: description,
          price: int.parse(price)));
    });
  }

  void removeProduct(int index) {
    print("index" + index.toString());
    print("size of product" + product.length.toString());
    setState(() {
      product.removeAt(index);
    });
  }

  void addProductToFireStore() {
    setState(() {
      for (var i = 0; i < product.length; i++) {
        context.read<FlutterFireAuthService>().addProduct(
            product[i].description, product[i].product, product[i].price, '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _productnameController = TextEditingController();
    final _descriptionController = TextEditingController();
    final _priceController = TextEditingController();
    final firebaseUser = context.watch<User>();

    if (firebaseUser == null) {
      print("Not Authenticated");
      print("Return To Home Page");
      return HomeScreen();
    }
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Container(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Add Product',
                      style: TextStyle(
                          color: kPrimaryFont,
                          fontSize: 45,
                          fontFamily: 'Alef-Regular'),
                    ),
                    Text(
                      'insert your product list',
                      style: TextStyle(
                          color: kPrimaryFont,
                          fontSize: 20,
                          fontFamily: 'Alef-Regular'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Textfield(
                          controller: _productnameController,
                          text: 'Product name...',
                          width: 350,
                          min: 1,
                          max: 5,
                        ),
                        Textfield(
                          controller: _descriptionController,
                          text: 'Description...',
                          width: 350,
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
                          controller: _priceController,
                          width: 350,
                          text: 'Price',
                          min: 1,
                          max: 5,
                        ),
                        Textfield(
                          text: 'Picture',
                          width: 350,
                          min: 3,
                          max: 5,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: RoundedButton(
                            color: kPrimaryLightColor,
                            buttonHight: 50,
                            fontsize: 15,
                            buttonSize: 0.4,
                            textColor: Colors.white,
                            text: "add to prodct",
                            press: () {
                              addProduct(
                                  _productnameController.text,
                                  _descriptionController.text,
                                  _priceController.text);
                            }),
                      ),
                    ),
                    Divider(
                      height: 10,
                      thickness: 2,
                      indent: 25,
                      endIndent: 25,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        'Product List',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    if (product.length != 0)
                      for (int i = 0; i < product.length; i++)
                        ProductList(
                          product: product[i].product,
                          description: product[i].description,
                          price: product[i].price,
                          press: () {
                            removeProduct(i);
                          },
                        ),
                    if (product.length == 0)
                      EmptyList(
                          text:
                              'Customer Product is empty please choose the product'),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: RoundedButton(
                            color: kPrimaryLightColor,
                            buttonHight: 50,
                            fontsize: 15,
                            buttonSize: 0.4,
                            textColor: Colors.white,
                            text: "confirm",
                            press: () {
                              addProductToFireStore();
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
