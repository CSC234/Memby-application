import 'package:flutter/material.dart';
import 'package:memby/components/rounded_button.dart';
import 'package:memby/constants.dart';
import 'package:memby/screens/loginScreen.dart';

class Guide extends StatefulWidget {
  @override
  _GuideState createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  final int _numPage = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _builtPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPage; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 24.0 : 10.0,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF6961D6) : Color(0xFFC4C4C4),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: height * (90 / 100),
              child: PageView(
                physics: ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "MEMBY",
                          style: TextStyle(
                              fontSize: 36,
                              fontFamily: 'Alef-Regular',
                              color: kPrimaryFont,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Because every data matters.",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Alef-Regular',
                              color: kPrimaryFont),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: height * 0.25,
                          child: Image(
                            image: AssetImage(
                                'assets/images/NonCashAssetDonation.png'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            'Memby is an application that makes membership system be a breeze! ' +
                                'It is designed to be smart, simple ,and stable system. ' +
                                'Memby helps businesses to analyze data, so they are able to gain insight of the business' +
                                'and improve the sales significantly',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Alef-Regular',
                                color: kPrimaryFont),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "LET’S GET STARTED",
                          style: TextStyle(
                              fontSize: 36,
                              fontFamily: 'Alef-Regular',
                              color: kPrimaryFont,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Please Login to Continue",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Alef-Regular',
                              color: kPrimaryFont),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: height * 0.25,
                          child: Image(
                            image: AssetImage('assets/images/StartupIdea.png'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: height * 0.25,
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            'Your data will be securely stored online.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Alef-Regular',
                                color: kPrimaryFont),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Alef-Regular',
                              ),
                            ),
                            color: Color(0xFF4941BB),
                            textColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 10),
                            onPressed: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _builtPageIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
