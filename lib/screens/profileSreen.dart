import 'package:flutter/material.dart';
import 'package:memby/components/Profile/changePassword.dart';
import 'package:memby/components/Profile/editProfile.dart';

import 'package:memby/constants.dart';
import 'package:memby/screens/landingScreen.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memby/components/rounded_button.dart';

class Profile extends StatefulWidget {
  @override
  final String onPagee;
  const Profile({Key key, this.onPagee}) : super(key: key);

  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future _companyInfo;
  @override
  void initState() {
    super.initState();
    _companyInfo = context.read<FlutterFireAuthService>().getUserInfo();
  }

  String onPage = 'm';

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    print(onPage);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  print(onPage);
                  if (onPage == 'm') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Landing();
                        },
                      ),
                    );
                    // Navigator.pop(context, false);
                  }
                  if (onPage == 'e') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Profile(
                            onPagee: 'profile',
                          );
                        },
                      ),
                    );
                  }
                  if (onPage == 'p') {
                    onPage = 'profile';

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Profile(onPagee: 'profile');
                        },
                      ),
                    );
                  }
                },
              ),
              backgroundColor: kPrimaryMain,
              bottomOpacity: 0.0,
              elevation: 0.0,
              title: Text('Your Profile'),
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
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
                                                  margin:
                                                      EdgeInsets.only(left: 15),
                                                  height: 110,
                                                  width: 90,
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            profileInfo[
                                                                'logo']),
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 30),
                                                  // padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 10),
                                                        width:
                                                            width * (50 / 100),
                                                        child: Container(
                                                          child: Text(
                                                              "Compnay: ${profileInfo['name']}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      18)),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 10),
                                                        width:
                                                            width * (50 / 100),
                                                        child: Container(
                                                          child: Text(
                                                              "Since: $creationDate",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      18)),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 10),
                                                        width:
                                                            width * (50 / 100),
                                                        child: Container(
                                                          child: Text(
                                                              "Last Login: $lastSigninDate",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      18)),
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
                  Container(
                      child: onPage == 'm'
                          ? Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      onPage = 'e';
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            onPage = 'e';
                                          });
                                        },
                                        icon: Icon(
                                          Icons.create_rounded,
                                          color: Colors.grey[500],
                                          size: 30,
                                        ),
                                      ),
                                      Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 15),
                                      )
                                    ]),
                                  ),
                                ),
                                Divider(
                                  height: 10,
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      onPage = 'p';
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            onPage = 'p';
                                          });
                                        },
                                        icon: Icon(
                                          Icons.lock_open_rounded,
                                          color: Colors.grey[500],
                                          size: 30,
                                        ),
                                      ),
                                      Text(
                                        'Change Password',
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 15),
                                      )
                                    ]),
                                  ),
                                ),
                                Divider(
                                  height: 10,
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                TextButton(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: Row(children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.exit_to_app,
                                            color: Colors.grey[500],
                                            size: 30,
                                          ),
                                        ),
                                        Text(
                                          'Log out',
                                          style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 15),
                                        )
                                      ]),
                                    ),
                                    onPressed: () {
                                      print("Sign Out Pressed");

                                      if (Navigator.of(context).canPop()) {
                                        Navigator.of(context).pop();
                                      }
                                      context
                                          .read<FlutterFireAuthService>()
                                          .signOut();
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
                                            image: AssetImage(
                                                'assets/images/Employee.png'),
                                          )),
                                        )),
                                      ],
                                    )),
                              ],
                            )
                          : onPage == 'e'
                              ? Column(
                                  children: [
                                    EditProfile(),
                                  ],
                                )
                              : Column(
                                  children: [
                                    ChangePassword(),
                                  ],
                                )),
                ]),
              ),
            )));
  }
}
