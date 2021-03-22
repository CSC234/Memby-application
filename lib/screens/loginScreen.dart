import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:memby/components/rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';

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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String _value;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
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
                  controller: emailController,
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
                  controller: passwordController,
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
                  context.read<FlutterFireAuthService>().signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        context: context,
                      );
                }),
            buildButtonGoogle(context),
          ],
        ),
      ),
    );
  }
}

Widget buildButtonGoogle(BuildContext context) {
  return InkWell(
      child: Container(
          constraints: BoxConstraints.expand(height: 50),
          child: Text("Login with Google ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.blue[600])),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.white),
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.all(12)),
      onTap: () => context.read<FlutterFireAuthService>().signInWithGoogle());
}
