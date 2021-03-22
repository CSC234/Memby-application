import 'package:memby/components/dashboard.dart';
import 'package:memby/screens/landingScreen.dart';
// import 'package:memby/components/dashboard.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryMain,
      appBar: AppBar(
        title: Text(
          'Back',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Alef-Regular'),
        ),
        backgroundColor: kPrimaryMain,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Landing();
                },
              ),
            );
          },
        ),
      ),
      body: Body(),
    );
  }
}
