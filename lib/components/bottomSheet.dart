import 'package:flutter/material.dart';
import 'package:memby/components/imagePicker.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memby/components/Textfield.dart';
import 'package:memby/components/rounded_button.dart';
import 'package:memby/constants.dart';
import 'package:memby/screens/manageProduct.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:memby/components/Textfield.dart';
import 'package:image_picker/image_picker.dart';

class BottomSheettest extends StatefulWidget {
  final String text;
  final List product;
  final int item;
  final Function testBoy;
  BottomSheettest({this.text, this.product, this.item, this.testBoy});

  @override
  _BottomSheet createState() => _BottomSheet();
}

class _BottomSheet extends State<BottomSheettest> {
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

  void updateProductToFireStore(pid, name, description, price, picture) {
    SizedBox(child: CircularProgressIndicator(), height: 100.0, width: 100.0);
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
    _uploadedFileURL = await context
        .read<FlutterFireAuthService>()
        .uploadImageToFirebase(_image);
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
    final _productnameController =
        TextEditingController(text: widget.product[widget.item].product);
    final _descriptionController =
        TextEditingController(text: widget.product[widget.item].description);
    final _priceController = TextEditingController(
        text: widget.product[widget.item].price.toString());
    double width = MediaQuery.of(context).size.width;
    return Center(
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
                controller: _productnameController,
                // value: product[item].product,
                text: 'Product name...',
                width: width * (90 / 100),
                min: 1,
                max: 5,
              ),
              Textfield(
                controller: _descriptionController,
                // value: product[item].description,
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
                // value: product[item].price.toString(),
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
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
