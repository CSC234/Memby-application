import 'package:flutter/material.dart';
import 'package:memby/components/Profile/main.dart';
import 'package:memby/constants.dart';

import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future _companyInfo;
  @override
  void initState() {
    super.initState();
    _companyInfo = context.read<FlutterFireAuthService>().getUserInfo();
  }

  @override
  String change = 'main';
  handleChange(state) {
    setState(() {
      change = state;
    });
  }

  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
        child: Scaffold(
            body: Column(children: [
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
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FutureBuilder(
                            future: _companyInfo,
                            builder: (context, snapshot) {
                              print(snapshot);
                              if (snapshot.hasData) {
                                final profileInfo = snapshot.data;
                                final creationDate = firebaseUser
                                    .metadata.creationTime
                                    .toIso8601String()
                                    .split('T')
                                    .first;
                                final lastSigninDate = firebaseUser
                                    .metadata.lastSignInTime
                                    .toIso8601String()
                                    .split('T')
                                    .first;

                                return Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      height: 110,
                                      width: 90,
                                      child: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(profileInfo['logo']),
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
                                              child: Text(
                                                  "Compnay: ${profileInfo['name']}",
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
                                              child: Text(
                                                  "Since: $creationDate",
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
                                              child: Text(
                                                  "Last Login: $lastSigninDate",
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
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            })
                      ],
                    ),
                  ))),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      IconButton(
        onPressed: () {
          context.read<FlutterFireAuthService>().getProducts();
        },
        icon: Icon(
          Icons.check,
          color: Colors.grey[500],
          size: 30,
        ),
      ),
      Main(onPress: () {
        print("Sign Out Pressed");
        context.read<FlutterFireAuthService>().signOut();
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      }),
      Container(
          padding: EdgeInsets.all(50),
          height: height * (35 / 100),
          child: Stack(
            children: <Widget>[
              Positioned(
                  child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/Employee.png'),
                )),
              )),
            ],
          )),
    ])));
  }
}
