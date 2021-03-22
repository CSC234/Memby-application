import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:memby/components/TextBox.dart';

const grey = const Color(0xFF5A5A5A);
const lightGrey = const Color(0xFFEAEAEA);
const fontColor = const Color(0xFFB7B7B7);
bool isCheck = false;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Register();
  }
}

class CheckBoxState extends StatefulWidget {
  @override
  _CheckBoxStateState createState() => _CheckBoxStateState();
}

class _CheckBoxStateState extends State<CheckBoxState> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: isCheck,
        checkColor: Colors.yellowAccent,
        onChanged: (bool value) {
          setState(
            () {
              isCheck = value;
            },
          );
        },
      ),
    );
  }
}

class Register extends StatelessWidget {
  const Register({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: height * (5 / 100)),
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 48,
                            fontFamily: 'Alef-Regular',
                            color: grey),
                      ),
                      Text(
                        "Create Customer's Account",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Alef-Regular',
                            color: grey),
                      ),
                      Image(
                        image: AssetImage('assets/images/register.png'),
                      ),
                      TextBox(
                        text: "Firstname",
                        width: width * (80 / 100),
                        height: height * (5 / 100),
                        keyboardType: TextInputType.name,
                        formColor: lightGrey,
                        textColor: fontColor,
                      ),
                      TextBox(
                        text: "Lastname",
                        width: width * (80 / 100),
                        height: height * (5 / 100),
                        keyboardType: TextInputType.name,
                        formColor: lightGrey,
                        textColor: fontColor,
                      ),
                      TextBox(
                        text: "Email",
                        width: width * (80 / 100),
                        height: height * (5 / 100),
                        keyboardType: TextInputType.name,
                        formColor: lightGrey,
                        textColor: fontColor,
                      ),
                      TextBox(
                        text: "Phone Number",
                        width: width * (80 / 100),
                        height: height * (5 / 100),
                        keyboardType: TextInputType.name,
                        formColor: lightGrey,
                        textColor: fontColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextBox(
                            text: "Birthdate",
                            width: width * (37.5 / 100),
                            height: height * (5 / 100),
                            keyboardType: TextInputType.name,
                            formColor: lightGrey,
                            textColor: fontColor,
                            icon: Icon(Icons.calendar_today_rounded),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              child: DropdownButtonHideUnderline(
                                child: new DropdownButton<String>(
                                  items: <String>[
                                    'Male',
                                    'Female',
                                    'Other',
                                    'Prefer not to Say'
                                  ].map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (_) {},
                                  hint: Text("Gender"),
                                ),
                              ),
                              height: height * (5 / 100),
                              width: width * (37.5 / 100),
                              decoration: ShapeDecoration(
                                color: lightGrey,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: lightGrey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextBox(
                        text: "Address",
                        width: width * (80 / 100),
                        keyboardType: TextInputType.multiline,
                        formColor: lightGrey,
                        textColor: fontColor,
                        minLine: 4,
                        maxLine: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CheckBoxState(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              child: Text(
                                  'I ACKNOWLEDGE AND CONFIRM THAT I HAVE READ,'
                                  'UNDERSTAND AND ACCEPT THE ABOVE TERMS AND CONDITIONS.',
                                  style: TextStyle(fontSize: 11)),
                              width: width * (75 / 100),
                            ),
                          )
                        ],
                      ),
                      ElevatedButton(onPressed: () {}, child: Text("Register"))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
