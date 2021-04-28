import 'package:flutter/material.dart';
import 'package:memby/components/publicComponent/OverlayNotification.dart';
import 'package:memby/components/publicComponent/imagePicker.dart';
import 'package:memby/constants.dart';
import 'package:memby/components/publicComponent/rounded_button.dart';
import 'package:memby/components/manageProduct/ProductList.dart';
import 'package:memby/components/manageProduct/Textfield.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memby/firebase.dart';
import 'package:memby/screens/homeScreen.dart';
import 'package:memby/components/publicComponent/emptyItem.dart';
import 'package:memby/screens/manageProduct.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
  double price;
  String picture;

  Product({this.product, this.description, this.price, this.picture});
}

class _AddProductList extends State<AddProductList> {
  File _image;
  String _uploadedFileURL;
  final picker = ImagePicker();

  Future _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print("filename" + _image.toString());

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  List<Product> product = [];
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void addProduct(productName, description, price, picture) async {
    _uploadedFileURL = await context
        .read<FlutterFireAuthService>()
        .uploadImageToFirebase(_image);
    setState(() {
      _image = null;
      product.add(new Product(
          product: productName,
          description: description,
          price: double.parse(price),
          picture: _uploadedFileURL));
    });
  }

  void removeProduct(int index) {
    print("index" + index.toString());
    print("size of product" + product.length.toString());
    String imgUrl = product[index].picture;
    context.read<FlutterFireAuthService>().removeImageFromFirebase(imgUrl);
    setState(() {
      product.removeAt(index);
    });
  }

  void addProductToFireStore() {
    setState(() {
      for (var i = 0; i < product.length; i++) {
        context.read<FlutterFireAuthService>().addProduct(product[i].product,
            product[i].description, product[i].price, product[i].picture);
      }
    });
    // uploadPic(_pickedImage);
  }

  final _productnameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _pictureController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                       
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Container(
                            width: width * 0.8,
                            child: Text(
                              'Add Product',
                              style: TextStyle(
                                  color: kPrimaryFont,
                                  fontSize: 45,
                                  fontFamily: 'Alef-Regular'),
                            ),
                          ),
                        ],
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          UserImagePicker(
                              press: _pickImage, pickedImage: _image)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Textfield(
                            controller: _productnameController,
                            text: 'Product name...',
                            width: width * (90 / 100),
                            min: 1,
                            max: 5,
                          ),
                          Textfield(
                            controller: _descriptionController,
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
                            controller: _priceController,
                            width: width * (90 / 100),
                            text: 'Price',
                            min: 1,
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
                                    _priceController.text,
                                    _pictureController.text);
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
                            visible: true,
                            render: true,
                            picture: product[i].picture,
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
                                showOverlayNotification(
                                  (context) {
                                    return OverlayNotification(
                                      title: "Memby Application",
                                      subtitle: "Product added Successfully",
                                    );
                                  },
                                  duration: Duration(milliseconds: 4000),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ManageProduct();
                                    },
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
