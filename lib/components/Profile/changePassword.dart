import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'package:memby/components/TextFieldPassword.dart';
import 'package:memby/components/publicComponent/rounded_button.dart';
import 'package:memby/screens/landingScreen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:memby/components/publicComponent/OverlayNotification.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePassword createState() => _ChangePassword();
}

bool _ownPasswordVisible = false;
bool _newPasswordVisible = false;
bool _confirmNewPasswordVisible = false;

class _ChangePassword extends State<ChangePassword> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  @override
  void initState() {
    _ownPasswordVisible = false;
    _newPasswordVisible = false;
    _confirmNewPasswordVisible = false;
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          child: Positioned(height: height, child: Container()),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: width * (80 / 100),
          child: Text(
            'Change your password',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 20,
                fontFamily: 'Alef-Regular'),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Textfield(
          controller: oldPasswordController,
          isShow: _ownPasswordVisible,
          press: () {
            setState(() {
              _ownPasswordVisible = !_ownPasswordVisible;
            });
          },
          text: 'Password...',
          width: 320,
          min: 1,
          max: 5,
        ),
        Textfield(
          controller: newPasswordController,
          isShow: _newPasswordVisible,
          press: () {
            setState(() {
              _newPasswordVisible = !_newPasswordVisible;
            });
          },
          text: 'New Password...',
          width: 320,
          min: 1,
          max: 5,
        ),
        Textfield(
          controller: confirmNewPasswordController,
          isShow: _confirmNewPasswordVisible,
          press: () {
            setState(() {
              _confirmNewPasswordVisible = !_confirmNewPasswordVisible;
            });
          },
          text: 'Confirm New Password...',
          width: 320,
          min: 1,
          max: 5,
        ),
        RoundedButton(
            color: kPrimaryLightColor,
            buttonHight: 45,
            fontsize: 15,
            buttonSize: 0.4,
            textColor: Colors.white,
            text: "confirm",
            press: () async {
              if (newPasswordController.text ==
                  confirmNewPasswordController.text) {
                String msg = await context
                    .read<FlutterFireAuthService>()
                    .changePassword(
                        oldPassword: oldPasswordController.text,
                        newPassword: newPasswordController.text);
                showOverlayNotification(
                  (context) {
                    return OverlayNotification(
                        title: "Changing Password Status", subtitle: msg);
                  },
                  duration: Duration(milliseconds: 4000),
                );
                if (msg == "Your password has been updated!") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Landing();
                      },
                    ),
                  );
                }
              }
            }),
      ]),
    );
  }
}
