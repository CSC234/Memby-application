import 'package:flutter/material.dart';
import '../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.15),
                  height: 650,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                ),
                Positioned(
                  top: -5,
                  left: 30,
                  child: Text(
                    'View Dashboard',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontFamily: 'Alef-Regular'),
                  ),
                ),
                Positioned(
                  top: 58,
                  left: 120,
                  child: Text(
                    'insight information',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Alef-Regular'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
