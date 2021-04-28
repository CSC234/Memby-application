import 'package:memby/components/OverlayNotification.dart';
import 'package:memby/firebase.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:memby/components/Register/TextBox.dart';
import 'package:memby/components/Register/CalendarPicker.dart';
import 'package:memby/components/Register/GenderPicker.dart';
// import 'package:memby/components/Register/AcknowlwdgementBox.dart';
// import 'package:memby/components/Register/showDialogBox.dart';
import 'package:memby/screens/landingScreen.dart';
// import 'package:memby/components/bottomNav/nav.dart';

const grey = const Color(0xFF5A5A5A);
const lightGrey = const Color(0xFFEAEAEA);
const fontColor = const Color(0xFFB7B7B7);
const themeBlue = const Color(0xFF6E7CE4);

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

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    void moveToLastScreen() {
      // ShowDialogBox(
      //   title: "Are you sure?",
      //   content: "You will lose all of the changes",
      //   confirmButtonYes: "Discard",
      //   confirmButtonNo: "Cancel",
      // );
    }

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
  final addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String dateToday = DateTime.now().toString().split(" ")[0];
  DateTime selectedDate = DateTime.now();
  String defaultGender = "Gender";
  bool defaultCheckState = false;

  String changeDate(date) {
    setState(() {
      selectedDate = date;
    });
    return selectedDate.toString().split(" ")[0];
  }

  void changeGender(newGender) {
    setState(() {
      defaultGender = newGender;
    });
  }

  void handleCheckState(checkState) {
    setState(() {
      defaultCheckState = checkState;
    });
  }

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
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.035,
                  ),
                  Row(
                    children: [
                      Container(
                          width: width * 0.15,
                          child: IconButton(
                              icon: Icon(Icons.arrow_back,
                                  color: Colors.grey[700]),
                              onPressed: () =>
                                  Navigator.of(context).pop(false))),
                      SizedBox(
                        width: width * 0.13,
                      ),
                      Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 48,
                            fontFamily: 'Alef-Regular',
                            color: grey),
                      ),
                    ],
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
                    width: width * (85 / 100),
                    keyboardType: TextInputType.name,
                    formColor: lightGrey,
                    textColor: fontColor,
                    require: true,
                  ),
                  TextBox(
                    text: "Lastname",
                    input: lastnameController,
                    width: width * (85 / 100),
                    keyboardType: TextInputType.name,
                    formColor: lightGrey,
                    textColor: fontColor,
                    require: true,
                  ),
                  TextBox(
                    text: "Email",
                    input: emailController,
                    width: width * (85 / 100),
                    keyboardType: TextInputType.emailAddress,
                    formColor: lightGrey,
                    textColor: fontColor,
                    emailValidator: true,
                    require: false,
                  ),
                  TextBox(
                    text: "Phone Number",
                    input: phoneNumberController,
                    width: width * (85 / 100),
                    keyboardType: TextInputType.number,
                    formColor: lightGrey,
                    textColor: fontColor,
                    require: true,
                    length: 10,
                    checkPhone: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Theme(
                          data: ThemeData(
                            primaryColor: Colors.indigoAccent,
                            primarySwatch: Colors.indigo,
                          ),
                          child: Container(
                            width: width * (37.5 / 100),
                            child: CalendarPicker(
                              title: selectedDate.toString().split(" ")[0] ==
                                      DateTime.now().toString().split(" ")[0]
                                  ? "Birthdate"
                                  : selectedDate.toString().split(" ")[0]
                              // changeDate(selectedDate)
                              ,
                              color: themeBlue,
                              onPickDate: changeDate,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Container(
                            height: height * (5 / 100),
                            width: width * (41 / 100),
                            child: GenderPicker(
                              gender: defaultGender,
                              onSelectGender: changeGender,
                            ),
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
                        )
                      ],
                    ),
                  ),
                  TextBox(
                    text: "Address",
                    input: addressController,
                    width: width * (85 / 100),
                    keyboardType: TextInputType.multiline,
                    formColor: lightGrey,
                    textColor: fontColor,
                    require: true,
                    minLine: 4,
                    maxLine: 5,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   child: Container(
                  //     height: height * (5 / 100),
                  //     width: width * (80 / 100),
                  //     child: AcknowledgementBox(
                  //         isCheck: defaultCheckState,
                  //         currentCheckState: handleCheckState),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: width * (40 / 100),
                      child: ElevatedButton(
                        child: Text("Register"),
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(fontSize: 16),
                            primary: themeBlue,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.all(12.5)),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            context.read<FlutterFireAuthService>().addCustomer(
                                firstnameController.text,
                                lastnameController.text,
                                emailController.text,
                                phoneNumberController.text,
                                selectedDate,
                                defaultGender,
                                addressController.text);
                            showOverlayNotification(
                              (context) {
                                return OverlayNotification(
                                  title: "Memby Application",
                                  subtitle: "Registered Successfully",
                                );
                              },
                              duration: Duration(milliseconds: 4000),
                            );
                            return Navigator.of(context).pop();
                          } else {
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * (1 / 100),
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
