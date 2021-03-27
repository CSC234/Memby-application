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
        backgroundColor: kPrimaryMain,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Body(),
    );
  }
}
