import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:memby/components/publicComponent/rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:memby/components/publicComponent/toggle/animated_toggle_button.dart';
import 'package:memby/components/publicComponent/toggle/theme_color.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:memby/components/publicComponent/OverlayNotification.dart';

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
  AnimationController _animationController;
  bool isDarkMode = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isRegister = false;
  changeThemeMode() {
    if (isDarkMode) {
      _animationController.forward(from: 0.0);
    } else {
      _animationController.reverse(from: 1.0);
    }
  }

  ThemeColor darkMode = ThemeColor(
    gradient: [
      const Color(0xFF6E7CE4),
      const Color(0xFF6E7CE4),
    ],
    backgroundColor: const Color(0xFF6E7CE4),
    textColor: const Color(0xFFFFFFFF),
    toggleButtonColor: const Color(0xFF6E7CE4),
    toggleBackgroundColor: const Color(0xFFe7e7e8),
    shadow: const <BoxShadow>[
      BoxShadow(
        color: const Color(0xFFd8d7da),
        spreadRadius: 5,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  );
  ThemeColor lightMode = ThemeColor(
    gradient: [
      const Color(0xFF6E7CE4),
      const Color(0xFF6E7CE4),
    ],
    backgroundColor: const Color(0xFF6E7CE4),
    textColor: const Color(0xFFFFFFFF),
    toggleButtonColor: const Color(0xFF6961D6),
    toggleBackgroundColor: const Color(0xFFe7e7e8),
    shadow: const [
      BoxShadow(
        color: const Color(0xFFd8d7da),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 5),
      ),
    ],
  );
  int initialIndex = 0;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  ScrollController _scrollController = ScrollController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController bussinessNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      _passwordVisible = false;
      _confirmPasswordVisible = false;
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
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
                padding: EdgeInsets.all(20),
                height: 240,
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
              height: 10,
            ),
            AnimatedToggle(
              values: ['Sign in', 'Sign up'],
              textColor: isDarkMode ? darkMode.textColor : lightMode.textColor,
              backgroundColor: isDarkMode
                  ? darkMode.toggleBackgroundColor
                  : lightMode.toggleBackgroundColor,
              buttonColor: isDarkMode
                  ? darkMode.toggleButtonColor
                  : lightMode.toggleButtonColor,
              shadows: isDarkMode ? darkMode.shadow : lightMode.shadow,
              onToggleCallback: (index) {
                setState(() {
                  initialIndex = index;
                  isRegister = index == 1;
                  if (isRegister) {
                    Future.delayed(Duration(milliseconds: 100), () {
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    });
                  }
                });
              },
            ),
            SizedBox(
              height: 15,
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
                  keyboardType: TextInputType.emailAddress,
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
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      icon: Icon(
                        Icons.lock,
                        color: Colors.black54,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      border: InputBorder.none),
                )),
            isRegister
                ? Column(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                          width: 325,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            controller: confirmPasswordController,
                            obscureText: !_confirmPasswordVisible,
                            decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.black54,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _confirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _confirmPasswordVisible =
                                          !_confirmPasswordVisible;
                                    });
                                  },
                                ),
                                border: InputBorder.none),
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                          width: 325,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            controller: bussinessNameController,
                            maxLength: 10,
                            decoration: InputDecoration(
                                hintText: 'Business Name',
                                counterText: '',
                                icon: Icon(
                                  Icons.business,
                                  color: Colors.black54,
                                ),
                                border: InputBorder.none),
                          )),
                    ],
                  )
                : Container(),
            RoundedButton(
                color: Color(0xFF4941BB),
                buttonHight: 50,
                fontsize: 15,
                buttonSize: 0.4,
                textColor: Colors.white,
                text: isRegister ? "Register" : "Login",
                press: () async {
                  String msg = '';
                  if (!isRegister) {
                    msg = await context.read<FlutterFireAuthService>().signIn(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          context: context,
                        );
                    showOverlayNotification(
                      (context) {
                        return OverlayNotification(
                          title:
                              isRegister ? "Sign Up Status" : "Sign In Status",
                          subtitle: msg,
                        );
                      },
                      duration: Duration(milliseconds: 4000),
                    );
                  } else {
                    if (confirmPasswordController.text !=
                        passwordController.text) {
                      showOverlayNotification(
                        (context) {
                          return OverlayNotification(
                            title: "Sign Up Status",
                            subtitle:
                                'Password and Comfirm Password doesn\'t match.',
                          );
                        },
                        duration: Duration(milliseconds: 4000),
                      );
                    } else {
                      msg = await context.read<FlutterFireAuthService>().signUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            bussinessName: bussinessNameController.text.trim(),
                            context: context,
                          );
                      showOverlayNotification(
                        (context) {
                          return OverlayNotification(
                            title: isRegister
                                ? "Sign Up Status"
                                : "Sign In Status",
                            subtitle: msg,
                          );
                        },
                        duration: Duration(milliseconds: 4000),
                      );
                    }
                  }
                }),
            SizedBox(
              height: 10,
            ),
            // Text(
            //   '?????????????????????????????????????????????  or  ?????????????????????????????????????????????',
            //   style: TextStyle(color: Colors.grey[600]),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160,
                  child: Divider(
                    height: 5,
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                ),
                Text(
                  'or',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Container(
                  width: 160,
                  child: Divider(
                    height: 5,
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),
            GoogleSignInButton(
                onPressed: () {
                  context
                      .read<FlutterFireAuthService>()
                      .signInWithGoogle(context: context);
                },
                splashColor: Colors.white,
                textStyle: TextStyle(
                    color: kPrimaryFont,
                    fontSize: 15,
                    fontFamily: 'Alef-Regular')),
            SizedBox(
              height: 40,
            ),
            Text(
              'Powered by KTBNG Group ??',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(
              height: 40,
            ),
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
