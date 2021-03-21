import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:memby/components/rounded_button.dart';
import 'package:memby/screens/viewDashboard.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          Container(
            height: 400,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              color: kPrimaryMain,
            ),
            child: Stack(
              children: [
                Positioned(
                  height: 200,
                  width: 300,
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Welcome to Your Business',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Alef-Regular'),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 15,
                  bottom: 5,
                  height: 300,
                  width: 350,
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          'Godchapong',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontFamily: 'Alef-Regular'),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 180,
                  width: 300,
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          'Company',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontFamily: 'Alef-Regular'),
                        ),
                      ],
                    ),
                  ),
                ),
                // Positioned(
                //     // left: 10,
                //     // width: 10,
                //     child: Container(
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //     image: AssetImage('assets/images/Invest.png'),
                //   )),
                // )),
              ],
            ),
          ),
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
            text: "Create Order",
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
            text: "Add Product List",
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
                    return Dashboard();
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
