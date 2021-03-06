import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:memby/components/publicComponent/Card.dart';
import 'package:memby/screens/dashBoard/viewDashboard.dart';
import 'package:memby/screens/order/createOrderScreen.dart';
import 'package:memby/constants.dart';
import 'package:memby/screens/manageProduct/manageProduct.dart';
import 'package:memby/screens/registerScreen.dart';
import 'package:memby/screens/homeScreen.dart';
import 'package:memby/screens/profileSreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memby/firebase.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  Future _companyInfo;

  @override
  void initState() {
    super.initState();
    _companyInfo = context.read<FlutterFireAuthService>().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (firebaseUser == null) {
      return HomeScreen();
    }

    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned(
              height: height,
              child: SizedBox(
                  width: width,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                  )),
            ),
            Positioned(
              height: height * (40 / 100),
              child: SizedBox(
                  width: width,
                  height: 350,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: kPrimaryMain,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            height: 90,
                            width: 90,
                            top: height * (3 / 100),
                            left: width * (75 / 100),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Profile(
                                        onPagee: 'm',
                                      );
                                    },
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 100,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/images/profile.png'),
                                ),
                              ),
                            )),
                        Positioned(
                            top: height * (7 / 100),
                            left: 20,
                            child: Text(
                              'Welcome to Your Business',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Alef-Regular'),
                            )),
                        Positioned(
                            top: height * (11 / 100),
                            left: 20,
                            child: Text(
                              'test',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * (16 / 100),
                                  fontFamily: 'Alef-Regular'),
                            )),
                        Positioned(
                            top: height * (23 / 100),
                            left: 20,
                            child: Text(
                              'Company',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * (10 / 100),
                                  fontFamily: 'Alef-Regular'),
                            )),
                      ],
                    ),
                  )),
            ),
            FutureBuilder(
                future: _companyInfo,
                builder: (context, snapshot) {
                  return Stack(children: <Widget>[
                    Positioned(
                      height: height,
                      child: SizedBox(
                          width: width,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                          )),
                    ),
                    Positioned(
                      height: height * (40 / 100),
                      child: SizedBox(
                          width: width,
                          height: 350,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              color: kPrimaryMain,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                    height: 90,
                                    width: 90,
                                    top: height * (3 / 100),
                                    left: width * (75 / 100),
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Profile();
                                            },
                                          ),
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 100,
                                        child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: snapshot.hasData
                                                ? NetworkImage(
                                                    snapshot.data['logo'])
                                                : NetworkImage(
                                                    "https://firebasestorage.googleapis.com/v0/b/memby-application.appspot.com/o/Group%2051.png?alt=media&token=be571d82-c69e-4bad-b200-a12d977e813d")),
                                      ),
                                    )),
                                Positioned(
                                    top: height * (7 / 100),
                                    left: 20,
                                    child: Text(
                                      'Welcome to Your Business',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'Alef-Regular'),
                                    )),
                                Positioned(
                                    top: height * (11 / 100),
                                    left: 20,
                                    child: Text(
                                      snapshot.hasData
                                          ? snapshot.data['name']
                                          : 'test',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * (16 / 100),
                                          fontFamily: 'Alef-Regular'),
                                    )),
                                Positioned(
                                    top: height * (23 / 100),
                                    left: 20,
                                    child: Text(
                                      'Company',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * (10 / 100),
                                          fontFamily: 'Alef-Regular'),
                                    )),
                              ],
                            ),
                          )),
                    )
                  ]);
                }),
            Positioned(
                left: 15,
                top: height * (32.5 / 100),
                // height: height * (65 / 100),
                child: SizedBox(
                    width: width - 30,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 10), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 30, top: 15),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Manage Business',
                                    style: TextStyle(
                                      color: kPrimaryFont,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              CardButton(
                                text: 'Register Member',
                                icon: Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                ),
                                description: "Register member for new customer",
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Register();
                                      },
                                    ),
                                  );
                                },
                                colorCircle: Color(0xFF4941BB),
                              ),
                              CardButton(
                                text: 'Create Order',
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                                description: "Record customer's transactions",
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return CreateOrderScreen();
                                      },
                                    ),
                                  );
                                },
                                colorCircle: Color(0xFF6961D6),
                              ),
                              CardButton(
                                text: 'Manage Product',
                                icon: Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.white,
                                ),
                                description: "Add or update products details",
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ManageProduct();
                                      },
                                    ),
                                  );
                                },
                                colorCircle: Color(0xFF7971E7),
                              ),
                              CardButton(
                                text: 'View Dashboard',
                                icon: Icon(
                                  Icons.dashboard_rounded,
                                  color: Colors.white,
                                ),
                                description: "Overview details of the company",
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DashBoard();
                                      },
                                    ),
                                  );
                                },
                                colorCircle: Color(0xFF8983DB),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))),
            Positioned(
                height: height * (40 / 100),
                width: width * (40 / 100),
                left: width * (52 / 100),
                top: height * (10 / 100),
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                  image: AssetImage('assets/images/Invest.png'),
                )))),
          ],
        ),
      ),
    );
  }
}
