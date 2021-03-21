import 'package:flutter/material.dart';

import 'package:memby/components/rounded_button.dart';


class Login extends StatefulWidget {
  @override
  final ValueChanged<String> onChanged;
  const Login({
    Key key,
    this.onChanged,
  }) : super(key: key);
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String _value;
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/recycling5.png'),
            )),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              height: 50,
              width: 325,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('Regenarate',
                    style:
                        TextStyle(fontFamily: 'quicksandBold', fontSize: 25)),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 50,
              width: 325,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('login with email to start regenarate your items',
                    style: TextStyle(fontFamily: 'quicksand', fontSize: 15)),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              width: size.width * 0.8,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Email',
                    icon: Icon(
                      Icons.perm_identity_rounded,
                      color: Colors.black54,
                    ),
                    border: InputBorder.none),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              width: size.width * 0.8,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    _value = value;
                  });
                  widget.onChanged(value);
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
          Center(
            child: Container(
              height: 25,
              width: 300,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text("Forgot password?"),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RoundedButton(
            text: "Login",
            fontsize: 14,
            buttonHight: 57,
            buttonSize: 0.4,
            textColor: Colors.white,
            color: Color(0xFF96A64F),
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    // return InsertPage();
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
