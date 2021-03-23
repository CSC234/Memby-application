import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

const grey = const Color(0xFF5A5A5A);
const lightGrey = const Color(0xFFEAEAEA);
const fontColor = const Color(0xFFB7B7B7);
bool isCheck = false;

class RegisterMock extends StatelessWidget {
  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: height * (5 / 100)),
                  Text(
                    "Register",
                    style: TextStyle(
                        fontSize: 48, fontFamily: 'Alef-Regular', color: grey),
                  ),
                  Text(
                    "Create Customer's Account",
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'Alef-Regular', color: grey),
                  ),
                  Image(
                    image: AssetImage('assets/images/register.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      height: height * 0.06,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.grey[500].withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Firstname',
                              hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey.withOpacity(.5)),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      height: height * 0.06,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.grey[500].withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Lastname',
                              hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey.withOpacity(.5)),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      height: height * 0.06,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.grey[500].withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey.withOpacity(.5)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      height: height * 0.06,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.grey[500].withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Phone number',
                              hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey.withOpacity(.5)),
                            ),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
