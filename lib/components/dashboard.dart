import 'package:flutter/material.dart';
import '../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  height: height * (30 / 100),
                  child: SizedBox(
                      width: width,
                      height: 350,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: kPrimaryMain,
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                                top: height * (10 / 100),
                                left: 30,
                                child: Text(
                                  'View DashBoard',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 48,
                                      fontFamily: 'Alef-Regular'),
                                )),
                            Positioned(
                                top: height * (18 / 100),
                                left: width * (30 / 100),
                                child: Text(
                                  'insight information',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Alef-Regular'),
                                )),
                          ],
                        ),
                      )),
                ),
                Positioned(
                  top: height * (25 / 100),
                  height: height * (100 / 100),
                  width: width * (100 / 100),
                  child: SizedBox(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
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
                                  'Help me to put daily mothly yearly by toggle',
                                  style: TextStyle(
                                    color: kPrimaryFont,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              height: 40,
                              thickness: 2,
                            )
                          ],
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
