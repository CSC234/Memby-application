import 'package:flutter/material.dart';
import 'package:memby/components/constants.dart';
import 'package:memby/components/rounded_button.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // const kPrimaryColor = Color(0xFF96A64F);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Text(
            'Memby ',
            style: TextStyle(
                color: kPrimaryFont,
                fontWeight: FontWeight.bold,
                fontSize: 28,
                fontFamily: 'Alef-Regular'),
          ),
          Container(
              padding: EdgeInsets.all(50),
              height: 280,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/Invest.png'),
                    )),
                  )),
                ],
              )),
          SizedBox(
            height: 40,
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              width: 325,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Email Address',
                    icon: Icon(
                      Icons.person_rounded,
                      color: Colors.black54,
                    ),
                    border: InputBorder.none),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              width: 325,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    // _value = value;
                  });
                  // widget.onChanged(value);
                },
                decoration: InputDecoration(
                    hintText: 'Password',
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black54,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: Colors.black54,
                    ),
                    border: InputBorder.none),
              )),
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
                    // return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
