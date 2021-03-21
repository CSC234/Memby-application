import 'package:flutter/material.dart';
import 'package:memby/components/Card.dart';
import 'package:memby/screens/viewDashboard.dart';
import 'package:memby/constants.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned(
              height: height,
              child: SizedBox(
                  width: width,
                  height: 350,
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
              height: 300,
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
                  )),
            ),
            Positioned(
                left: 15,
                top: 240,
                height: 500,
                child: SizedBox(
                    width: width - 30,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
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
                        padding: EdgeInsets.only(
                            // borderRadius: BorderRadius.only(
                            //   topLeft: Radius.circular(40),
                            //   topRight: Radius.circular(40),
                            //   bottomLeft: Radius.circular(40),
                            //   bottomRight: Radius.circular(40),
                            // ),
                            ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              CardButton(
                                text: 'Register Member',
                                icon: Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                ),
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
                                colorCircle: Color(0xFF4941BB),
                              ),
                              CardButton(
                                text: 'Create Order',
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
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
                                colorCircle: Color(0xFF6961D6),
                              ),
                              CardButton(
                                text: 'Add Product List',
                                icon: Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.white,
                                ),
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
                                colorCircle: Color(0xFF7971E7),
                              ),
                              CardButton(
                                text: 'View Dashboard',
                                icon: Icon(
                                  Icons.dashboard_rounded,
                                  color: Colors.white,
                                ),
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
                                colorCircle: Color(0xFF8983DB),
                              ),
                              SizedBox(
                                height: 25,
                              )
                            ],
                          ),
                        ),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
