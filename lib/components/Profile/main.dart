import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:memby/components/Profile/editProfile.dart';
import 'package:memby/components/Profile/changePassword.dart';

class Main extends StatelessWidget {
  final Function onPress;
  final Function onPressEditProfile;

  const Main({
    Key key,
    this.onPress,
    this.onPressEditProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Container(
        child: Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return EditProfile();
                },
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditProfile();
                      },
                    ),
                  );
                },
                icon: Icon(
                  Icons.create_rounded,
                  color: Colors.grey[500],
                  size: 30,
                ),
              ),
              Text(
                'Edit Profile',
                style: TextStyle(color: Colors.grey[500], fontSize: 15),
              )
            ]),
          ),
        ),
        Divider(
          height: 10,
          thickness: 2,
          indent: 20,
          endIndent: 20,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChangePassword();
                },
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ChangePassword();
                      },
                    ),
                  );
                },
                icon: Icon(
                  Icons.lock_open_rounded,
                  color: Colors.grey[500],
                  size: 30,
                ),
              ),
              Text(
                'Change Password',
                style: TextStyle(color: Colors.grey[500], fontSize: 15),
              )
            ]),
          ),
        ),
        Divider(
          height: 10,
          thickness: 2,
          indent: 20,
          endIndent: 20,
        ),
        TextButton(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.grey[500],
                    size: 30,
                  ),
                ),
                Text(
                  'Log out',
                  style: TextStyle(color: Colors.grey[500], fontSize: 15),
                )
              ]),
            ),
            onPressed: onPress),
      ],
    ));
  }
}
