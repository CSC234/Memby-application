import 'package:flutter/material.dart';
import 'package:memby/components/TextBox.dart';
import 'package:memby/components/DatePicker.dart';

const grey = const Color(0xFF5A5A5A);
const lightGrey = const Color(0xFFEAEAEA);
const fontColor = const Color(0xFFB7B7B7);
const themeBlue = const Color(0xFF6E7CE4);
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

class Register extends StatelessWidget {
  const Register({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: SingleChildScrollView(child: FormBoxes()),
      ),
    );
  }
}

class FormBoxes extends StatefulWidget {
  @override
  _FormBoxesState createState() => _FormBoxesState();
}

class _FormBoxesState extends State<FormBoxes> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final birthdateController = TextEditingController();
  final genderController = TextEditingController();
  final addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    birthdateController.dispose();
    genderController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
        child: Form(
      key: _formKey,
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
                        fontSize: 48, fontFamily: 'Alef-Regular', color: grey),
                  ),
                  Text(
                    "Create Customer's Account",
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'Alef-Regular', color: grey),
                  ),
                  Image(
                    image: AssetImage('assets/images/register.png'),
                  ),
                  TextBox(
                    text: "Firstname",
                    input: firstnameController,
                    width: width * (80 / 100),
                    keyboardType: TextInputType.name,
                    formColor: lightGrey,
                    textColor: fontColor,
                  ),
                  TextBox(
                    text: "Lastname",
                    input: lastnameController,
                    width: width * (80 / 100),
                    keyboardType: TextInputType.name,
                    formColor: lightGrey,
                    textColor: fontColor,
                  ),
                  TextBox(
                    text: "Email",
                    input: emailController,
                    width: width * (80 / 100),
                    keyboardType: TextInputType.emailAddress,
                    formColor: lightGrey,
                    textColor: fontColor,
                    emailValidator: true,
                  ),
                  TextBox(
                    text: "Phone Number",
                    input: phoneNumberController,
                    width: width * (80 / 100),
                    keyboardType: TextInputType.number,
                    formColor: lightGrey,
                    textColor: fontColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: height * (5 / 100),
                        width: width * (37.5 / 100),
                        child: CalendarPicker(
                            title: "Birthdate", color: themeBlue),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
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
                          ),
                          height: height * (5 / 100),
                          width: width * (40 / 100),
                          decoration: ShapeDecoration(
                            color: lightGrey,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: lightGrey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextBox(
                    text: "Address",
                    input: addressController,
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: width * (40 / 100),
                      child: ElevatedButton(
                        child: Text("Register"),
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(fontSize: 24),
                            primary: themeBlue,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.all(12.5)),
                        onPressed: () {
                          if (_formKey.currentState.validate() && isCheck) {
                            return Navigator.of(context).pop();
                          } else if (isCheck == false) {
                            return;
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * (5 / 100),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
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
