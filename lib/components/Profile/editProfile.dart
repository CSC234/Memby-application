import 'package:flutter/material.dart';
import 'package:memby/components/manageProduct/Textfield.dart';
import 'package:memby/constants.dart';
import 'package:memby/screens/landingScreen.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'package:memby/components/publicComponent/rounded_button.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:memby/components/publicComponent/OverlayNotification.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:memby/components/publicComponent/imagePicker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  File _image;
  String _uploadedFileURL;
  final picker = ImagePicker();
  Future _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          child: Positioned(height: height, child: Container()),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: width * (80 / 100),
          child: Text(
            'Edit Your Profile Business',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            width: 250,
            child: UserImagePicker(press: _pickImage, pickedImage: _image)),
        SizedBox(
          height: 20,
        ),
        Container(
            width: width * (80 / 100),
            child: Column(children: [
              Textfield(
                maxLength: 10,
                controller: nameController,
                width: width * (50 / 100),
                text: 'Your new company name',
              ),
            ])),
        SizedBox(
          height: 20,
        ),
        RoundedButton(
            color: kPrimaryLightColor,
            buttonHight: 45,
            fontsize: 15,
            buttonSize: 0.4,
            textColor: Colors.white,
            text: "confirm",
            press: () async {
              if (_image != null) {
                _uploadedFileURL = await context
                    .read<FlutterFireAuthService>()
                    .uploadImageToFirebase(_image);
              }
              context
                  .read<FlutterFireAuthService>()
                  .updateProfile(nameController.text, _uploadedFileURL);

              showOverlayNotification(
                (context) {
                  return OverlayNotification(
                    title: "Editing Profile Status",
                    subtitle: "Your profile has been updated!",
                  );
                },
                duration: Duration(milliseconds: 4000),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Landing();
                  },
                ),
              );
            }),
      ]),
    );
  }
}
