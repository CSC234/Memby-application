import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memby/screens/homeScreen.dart';

class UserImagePicker extends StatefulWidget {
  final String picture;

  final Function press;
  final File pickedImage;
  const UserImagePicker({Key key, this.press, this.pickedImage, this.picture})
      : super(key: key);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  final picker = ImagePicker();

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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          // padding: const EdgeInsets.only(left: 30),
          child: Container(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.withOpacity(.5),
              backgroundImage: widget.pickedImage != null
                  ? FileImage(widget.pickedImage)
                  : NetworkImage(widget.picture),
            ),
          ),
        ),
        FlatButton.icon(
          textColor: Colors.grey.withOpacity(.8),
          onPressed: widget.press,
          icon: Icon(Icons.image),
          label: Text('choose'),
        ),
      ],
    );
  }
}
