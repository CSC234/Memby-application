import 'package:flutter/material.dart';
import 'package:memby/components/Profile/main.dart';
import 'package:memby/constants.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  String change = 'main';
  handleChange(state) {
    setState(() {
      change = state;
    });
  }

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
        height: 10,
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
