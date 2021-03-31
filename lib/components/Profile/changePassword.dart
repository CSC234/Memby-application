import 'package:flutter/material.dart';
import 'package:memby/components/Profile/main.dart';
import 'package:memby/constants.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'package:memby/components/TextFieldPassword.dart';
import 'package:memby/components/rounded_button.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePassword createState() => _ChangePassword();
}

bool _ownPasswordVisible = false;
bool _newPasswordVisible = false;
bool _confirmNewPasswordVisible = false;

class _ChangePassword extends State<ChangePassword> {
  @override
  @override
  void initState() {
    _ownPasswordVisible = false;
    _newPasswordVisible = false;
    _confirmNewPasswordVisible = false;
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: height * (33 / 100),
          child: Positioned(
            height: height,
            child: SizedBox(
                width: width,
                child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: kPrimaryMain,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 35,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Your Profile',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                height: 110,
                                width: 90,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/profile.png'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 30),
                                // padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      width: width * (50 / 100),
                                      child: Container(
                                        child: Text("Compnay: Godchapong",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      width: width * (50 / 100),
                                      child: Container(
                                        child: Text("Since: 25-Mar-21",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      width: width * (50 / 100),
                                      child: Container(
                                        child: Text("Last Login: 25-Mar-21",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ))),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: width * (80 / 100),
          child: Text(
            'Change your password',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 20,
                fontFamily: 'Alef-Regular'),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Textfield(
          // controller: _productnameController,
          isShow: _ownPasswordVisible,
          press: () {
            setState(() {
              _ownPasswordVisible = !_ownPasswordVisible;
            });
          },
          text: 'Password...',
          width: 320,
          min: 1,
          max: 5,
        ),
        Textfield(
          // controller: _productnameController,
          isShow: _newPasswordVisible,
          press: () {
            setState(() {
              _newPasswordVisible = !_newPasswordVisible;
            });
          },
          text: 'New Password...',
          width: 320,
          min: 1,
          max: 5,
        ),
        Textfield(
          // controller: _productnameController,
          isShow: _confirmNewPasswordVisible,
          press: () {
            setState(() {
              _confirmNewPasswordVisible = !_confirmNewPasswordVisible;
            });
          },
          text: 'Confirm New Password...',
          width: 320,
          min: 1,
          max: 5,
        ),
        RoundedButton(
            color: kPrimaryLightColor,
            buttonHight: 45,
            fontsize: 15,
            buttonSize: 0.4,
            textColor: Colors.white,
            text: "confirm",
            press: () {}),
      ]),
    )));
  }
}
