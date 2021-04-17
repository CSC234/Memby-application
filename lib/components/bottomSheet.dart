import 'package:flutter/material.dart';
import 'package:memby/components/imagePickerNet.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';

import 'package:memby/components/Textfield.dart';
import 'package:memby/components/rounded_button.dart';
import 'package:memby/constants.dart';
import 'package:memby/screens/manageProduct.dart';
import 'package:memby/components/toggle/toggleVisible.dart';
import 'package:memby/components/toggle/theme_color.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Product1 {
  String id;
  String product;
  String description;
  double price;
  String picture;

  Product1({this.id, this.product, this.description, this.price, this.picture});
}

class BottomSheettest extends StatefulWidget {
  final String text;
  final List product;
  final int item;
  final Function testBoy;
  BottomSheettest({this.text, this.product, this.item, this.testBoy});

  @override
  _BottomSheet createState() => _BottomSheet();
}

List<Product1> product1 = [];
int item1;

class _BottomSheet extends State<BottomSheettest> {
  AnimationController _animationController;
  bool isDarkMode = false;
  int initialIndex = 0;

  changeThemeMode() {
    if (isDarkMode) {
      _animationController.forward(from: 0.0);
    } else {
      _animationController.reverse(from: 1.0);
    }
  }

  ThemeColor darkMode = ThemeColor(
    gradient: [
      const Color(0xFF6E7CE4),
      const Color(0xFF6E7CE4),
    ],
    backgroundColor: const Color(0xFF6E7CE4),
    textColor: const Color(0xFFFFFFFF),
    toggleButtonColor: const Color(0xFF6E7CE4),
    toggleBackgroundColor: const Color(0xFFe7e7e8),
    shadow: const <BoxShadow>[
      BoxShadow(
        color: const Color(0xFFd8d7da),
        spreadRadius: 5,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  );
  ThemeColor lightMode = ThemeColor(
    gradient: [
      const Color(0xFF6E7CE4),
      const Color(0xFF6E7CE4),
    ],
    backgroundColor: const Color(0xFF6E7CE4),
    textColor: const Color(0xFFFFFFFF),
    toggleButtonColor: const Color(0xFF6961D6),
    toggleBackgroundColor: const Color(0xFFe7e7e8),
    shadow: const [
      BoxShadow(
        color: const Color(0xFFd8d7da),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 5),
      ),
    ],
  );
  ScrollController _scrollController = ScrollController();

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

  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  String name = 'test';

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    for (int i = 0; i < widget.product.length; i++) {
      product1.add(Product1(
          id: widget.product[i].id,
          product: widget.product[i].product,
          price: widget.product[i].price,
          description: widget.product[i].description,
          picture: widget.product[i].picture));
    }
    print(product1[widget.item].product);
    item1 = widget.item;
    print('-----2--------');

    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void updateProductToFireStore(pid, name, description, price, picture) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ManageProduct();
        },
      ),
    );

    widget.testBoy(pid, name, description, price, picture);
  }

  String nameUpdate;
  String descriptionUpdate;
  double priceUpdate;

  void updateProduct(productName, description, price, picture) async {
    print(_image);
    if (_image != null) {
      _uploadedFileURL = await context
          .read<FlutterFireAuthService>()
          .uploadImageToFirebase(_image);
    }
    if (_image == null) {
      _uploadedFileURL = widget.product[widget.item].picture;
      print(_uploadedFileURL);
    }
    setState(() {
      _image = null;
      nameUpdate = productName;
      descriptionUpdate = description;
      priceUpdate = double.parse(price);
    });
    print(nameUpdate);
    updateProductToFireStore(widget.product[widget.item].id, nameUpdate,
        descriptionUpdate, priceUpdate, _uploadedFileURL);
  }

  final _pictureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    @override
        // String nameText = product1[item1].product;
        // product1 = widget.product;

        final _productnameController =
        TextEditingController(text: product1[item1].product);

    final _descriptionController =
        TextEditingController(text: product1[item1].description);
    final _priceController =
        TextEditingController(text: product1[item1].price.toString());

    double width = MediaQuery.of(context).size.width;
    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: 80,
                child: Divider(
                  height: 5,
                  thickness: 5,
                  indent: 10,
                  endIndent: 10,
                ),
              ),
              Row(
                children: <Widget>[
                  UserImagePicker(
                    press: _pickImage,
                    pickedImage: _image,
                    picture: product1[item1].picture,
                  ),
                  AnimatedToggle(
                    values: ['show', 'hide'],
                    textColor:
                        isDarkMode ? darkMode.textColor : lightMode.textColor,
                    backgroundColor: isDarkMode
                        ? darkMode.toggleBackgroundColor
                        : lightMode.toggleBackgroundColor,
                    buttonColor: isDarkMode
                        ? darkMode.toggleButtonColor
                        : lightMode.toggleButtonColor,
                    shadows: isDarkMode ? darkMode.shadow : lightMode.shadow,
                    onToggleCallback: (index) {
                      print('switched to: $index');
                      setState(() {
                        initialIndex = index;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Textfield(
                    onChange: (text) {
                      product1[item1].product = text;
                    },
                    controller: _productnameController,
                    text: 'Product name...',
                    width: width * (90 / 100),
                    min: 1,
                    max: 5,
                  ),
                  Textfield(
                    onChange: (text) {
                      product1[item1].description = text;
                    },
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
                    onChange: (text) {
                      product1[item1].price = text;
                    },
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
                        updateProduct(
                            _productnameController.text,
                            _descriptionController.text,
                            _priceController.text,
                            _pictureController.text);

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Container(
                                alignment: Alignment.center,
                                height: 85,
                                width: 10,
                                child: new Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text("Loading"),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
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
