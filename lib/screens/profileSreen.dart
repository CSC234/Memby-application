import 'package:flutter/material.dart';
import 'package:memby/constants.dart';

import 'package:provider/provider.dart';

import 'package:memby/firebase.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
        child: Scaffold(
            body: Column(children: [
      SizedBox(
        height: 240,
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
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 100,
                                width: 100,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                )),
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
        height: 10,
      ),
      Container(
        margin: EdgeInsets.only(left: 30),
        child: Row(children: [
          IconButton(
            onPressed: () {
              //////////////
            },
            icon: Icon(
              Icons.create_rounded,
              color: Colors.grey[500],
              size: 30,
            ),
          ),
          Text(
            'Edit Profile',
            style: TextStyle(color: Colors.grey[500], fontSize: 15),
          )
        ]),
      ),
      Divider(
        height: 10,
        thickness: 2,
        indent: 20,
        endIndent: 20,
      ),
      Container(
        margin: EdgeInsets.only(left: 30),
        child: Row(children: [
          IconButton(
            onPressed: () {
              ///////////////////
            },
            icon: Icon(
              Icons.lock_open_rounded,
              color: Colors.grey[500],
              size: 30,
            ),
          ),
          Text(
            'Change Password',
            style: TextStyle(color: Colors.grey[500], fontSize: 15),
          )
        ]),
      ),
      Divider(
        height: 10,
        thickness: 2,
        indent: 20,
        endIndent: 20,
      ),
      Container(
        margin: EdgeInsets.only(left: 30),
        child: Row(children: [
          IconButton(
            onPressed: () {
              print("Sign Out Pressed");
              context.read<FlutterFireAuthService>().signOut();
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.grey[500],
              size: 30,
            ),
          ),
          Text(
            'Log out',
            style: TextStyle(color: Colors.grey[500], fontSize: 15),
          )
        ]),
      )
    ])));
  }
}
