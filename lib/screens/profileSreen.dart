import 'package:flutter/material.dart';
import 'package:memby/components/Card.dart';
import 'package:memby/screens/viewDashboard.dart';
import 'package:memby/screens/createOrderScreen.dart';
import 'package:memby/constants.dart';
import 'package:memby/screens/addProductScreen.dart';
import 'package:memby/screens/registerScreen.dart';
import 'package:memby/screens/homeScreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memby/firebase.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned(
              height: height * (40 / 100),
              left: 170,
              child: IconButton(
                onPressed: () {
                  print("Sign Out Pressed");
                  context.read<FlutterFireAuthService>().signOut();
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
            Positioned(
              height: height * (40 / 100),
              left: 220,
              child: IconButton(
                onPressed: () {
                  print("Sign Out Pressed");
                  context.read<FlutterFireAuthService>().addCustomer(
                      'Toei',
                      'Kung',
                      'toei@mail.com',
                      '086666666',
                      '',
                      'Male',
                      'kmutt');
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                },
                icon: Icon(
                  Icons.people,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
