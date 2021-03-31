import 'package:flutter/material.dart';
import 'package:memby/components/Profile/main.dart';
import 'package:memby/constants.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
// import 'package:memby/components/Textfield.dart';
import 'package:memby/components/rounded_button.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  @override
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
            'Update Profile',
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
        Container(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundColor: Colors.grey[300],
            )),
        SizedBox(
          height: 20,
        ),
        Container(
            width: width * (80 / 100),
            child: Column(children: [
              TextFormField(
                // textAlignVertical: TextAlignVertical.top,
                minLines: 1,
                maxLines: 2,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Your new company name',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    width: 5,
                    color: Color(0xFFD5D8DE),
                  )),
                ),
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
            press: () {}),
      ]),
    )));
  }
}
