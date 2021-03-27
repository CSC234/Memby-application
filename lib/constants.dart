import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFFFFFF);
const kPrimaryLightColor = Color(0xFF6E7CE4);
const kPrimaryFont = Color(0xFF5A5A5A);
const kPrimaryMain = Color(0xFF2336C0);
const kPrimaryCard = Color(0xFFF3F3F3);
const kPrimaryInput = Color(0xFFEAEAEA);
const kPrimaryFontLight = Color(0xFFB7B7B7);

const kPrimaryHeadingTextStyle = TextStyle(
    color: kPrimaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 48,
    fontFamily: 'Alef-Regular');

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFC0C0C0), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF888685), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
