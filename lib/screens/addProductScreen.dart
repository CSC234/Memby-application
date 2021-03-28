import 'package:flutter/material.dart';
import 'package:memby/components/imagePicker.dart';
import 'package:memby/constants.dart';
import 'package:memby/components/rounded_button.dart';
import 'package:memby/components/ProductList.dart';
import 'package:memby/components/Textfield.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memby/firebase.dart';
import 'package:memby/screens/homeScreen.dart';
import 'package:memby/components/emptyItem.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

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
  File picture;

  Product({this.product, this.description, this.price, this.picture});
}

class _AddProductList extends State<AddProductList> {
  File _image;
  String _uploadedFileURL;

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

  void addProduct(productName, description, price, picture) {
    setState(() {
      product.add(new Product(
          product: productName,
          description: description,
          price: int.parse(price),
          picture: _pickedImage));
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
            product[i].description,
            product[i].product,
            product[i].price,
            "picture.test");
        print("picturename" + product[i].picture.toString());
      }
    });
    // uploadPic(_pickedImage);
  }

  void _pickImage() async {
    final pickedImageFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (PickedFile != null) {
        _pickedImage = File(pickedImageFile.path);
        print("filename" + _pickedImage.toString());
      } else {
        print('No image selected');
        return HomeScreen();
      }
    });
  }

  File _pickedImage;
  final picker = ImagePicker();

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadPic(File _image1) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String url;
    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image1);
    uploadTask.whenComplete(() {
      url = ref.getDownloadURL().toString();
      print("url" + url);
    }).catchError((onError) {
      print(onError);
    });
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final _productnameController = TextEditingController();
    final _descriptionController = TextEditingController();
    final _priceController = TextEditingController();
    final _pictureController = TextEditingController();

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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        UserImagePicker(
                            press: _pickImage, pickedImage: _pickedImage)
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
