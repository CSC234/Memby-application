import 'package:flutter/material.dart';
import 'package:memby/components/publicComponent/imagePickerNet.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'package:memby/components/manageProduct/Textfield.dart';
import 'package:memby/components/publicComponent/rounded_button.dart';
import 'package:memby/constants.dart';
import 'package:memby/screens/manageProduct/manageProduct.dart';
import 'package:memby/components/publicComponent/toggle/toggleVisible.dart';
import 'package:memby/components/publicComponent/toggle/theme_color.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Product1 {
  String id;
  String product;
  String description;
  double price;
  String picture;
  bool visible;
  Product1(
      {this.id,
      this.product,
      this.description,
      this.price,
      this.picture,
      this.visible});
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
  int initialIndex;
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

  String _uploadedFileURL;
  File _image;

  final picker = ImagePicker();

  Future _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

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
  void bestFunction() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    for (int i = 0; i < widget.product.length; i++) {
      product1.add(Product1(
        id: widget.product[i].id,
        product: widget.product[i].product,
        price: widget.product[i].price,
        description: widget.product[i].description,
        picture: widget.product[i].picture,
        visible: widget.product[i].visible,
      ));
    }
    if (product1.isNotEmpty) {
      if (product1[widget.item].visible == true) {
        initialIndex = 1;
      } else {
        initialIndex = 0;
      }

      item1 = widget.item;
    }
  }

  void initState() {
    bestFunction();

    product1 = [];
    for (int i = 0; i < widget.product.length; i++) {
      product1.add(Product1(
        id: widget.product[i].id,
        product: widget.product[i].product,
        price: widget.product[i].price,
        description: widget.product[i].description,
        picture: widget.product[i].picture,
        visible: widget.product[i].visible,
      ));
    }
    if (product1[widget.item].visible == true) {
      initialIndex = 0;
    } else {
      initialIndex = 1;
    }
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

  void updateProductVisibleToFireStore(pid, visibleFirebase) {
    context.read<FlutterFireAuthService>().updateVisible(pid, visibleFirebase);
  }

  String nameUpdate;
  String descriptionUpdate;
  double priceUpdate;
  bool visible;

  void updateProduct(productName, description, price, picture) async {
    if (_image != null) {
      _uploadedFileURL = await context
          .read<FlutterFireAuthService>()
          .uploadImageToFirebase(_image);
    }
    if (_image == null) {
      _uploadedFileURL = await widget.product[widget.item].picture;
    }
    setState(() {
      _image = null;
      nameUpdate = productName;
      descriptionUpdate = description;
      priceUpdate = double.parse(price);
    });

    if (initialIndex == 0) {
      updateProductVisibleToFireStore(widget.product[widget.item].id, true);
    }
    if (initialIndex == 1) {
      updateProductVisibleToFireStore(widget.product[widget.item].id, false);
    }
    updateProductToFireStore(widget.product[widget.item].id, nameUpdate,
        descriptionUpdate, priceUpdate, _uploadedFileURL);
  }

  final _pictureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    @override
    final _productnameController =
        TextEditingController(text: product1[item1].product);

    final _descriptionController =
        TextEditingController(text: product1[item1].description);
    final _priceController =
        TextEditingController(text: product1[item1].price.toString());
    double height = MediaQuery.of(context).size.height;

    double width = MediaQuery.of(context).size.width;
    if (initialIndex == 1) {
      visible = false;
    } else {
      visible = true;
    }
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  UserImagePicker(
                    press: _pickImage,
                    pickedImage: _image,
                    picture: product1[item1].picture,
                  ),
                  AnimatedToggle(
                    position: widget.product[item1].visible,
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
              product1.isEmpty
                  ? Column(
                      children: [],
                    )
                  : Column(
                      children: [
                        Textfield(
                          type: TextInputType.text,
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
                          type: TextInputType.text,
                          onChange: (text) {
                            product1[item1].description = text;
                          },
                          controller: _descriptionController,
                          text: 'Description...',
                          width: width * (90 / 100),
                          min: 3,
                        ),
                        Textfield(
                          type: TextInputType.number,
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
            ],
          ),
        ),
      ),
    );
  }
}
