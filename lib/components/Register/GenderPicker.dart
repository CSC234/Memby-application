import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GenderPicker extends StatefulWidget {
  GenderPicker({Key key, this.gender, this.onSelectGender}) : super(key: key);
  String gender;
  Function onSelectGender;

  @override
  _GenderPickerState createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButtonHideUnderline(
        child: new DropdownButton<String>(
          elevation: 16,
          hint: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              widget.gender,
            ),
          ),
          items: <String>['Female', 'Male', 'Others'].map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              widget.gender = value;
            });
            widget.onSelectGender(value);
          },
        ),
      ),
    );
  }
}
