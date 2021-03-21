import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:memby/components/rounded_button.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          RoundedButton(
            color: kPrimaryLightColor,
            buttonHight: 60,
            fontsize: 15,
            buttonSize: 0.4,
            textColor: Colors.white,
            text: "Register member",
            press: () {
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
          RoundedButton(
            color: kPrimaryLightColor,
            buttonHight: 60,
            fontsize: 15,
            buttonSize: 0.4,
            textColor: Colors.white,
            text: "Login",
            press: () {
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
          RoundedButton(
            color: kPrimaryLightColor,
            buttonHight: 60,
            fontsize: 15,
            buttonSize: 0.4,
            textColor: Colors.white,
            text: "Login",
            press: () {
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
          RoundedButton(
            color: kPrimaryLightColor,
            buttonHight: 60,
            fontsize: 15,
            buttonSize: 0.4,
            textColor: Colors.white,
            text: "View Dashboard",
            press: () {
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
        ],
      ),
    ));
  }
}
