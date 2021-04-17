import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:memby/components/Profile/editProfile.dart';
import 'package:memby/components/Profile/changePassword.dart';
import 'package:memby/components/rounded_button.dart';

class Main extends StatefulWidget {
  final Function onPress;
  final Function onPressEditProfile;

  const Main({
    Key key,
    this.onPress,
    this.onPressEditProfile,
  }) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  String onPage = 'm';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int index = 0;
    return Container(
        child: onPage == 'm'
            ? Column(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        onPage = 'e';
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              onPage = 'e';
                            });
                          },
                          icon: Icon(
                            Icons.create_rounded,
                            color: Colors.grey[500],
                            size: 30,
                          ),
                        ),
                        Text(
                          'Edit Profile',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 15),
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
                      setState(() {
                        onPage = 'p';
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              onPage = 'p';
                            });
                          },
                          icon: Icon(
                            Icons.lock_open_rounded,
                            color: Colors.grey[500],
                            size: 30,
                          ),
                        ),
                        Text(
                          'Change Password',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 15),
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
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 15),
                          )
                        ]),
                      ),
                      onPressed: widget.onPress),
                  Container(
                      padding: EdgeInsets.all(50),
                      height: height * (35 / 100),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/images/Employee.png'),
                            )),
                          )),
                        ],
                      )),
                ],
              )
            : onPage == 'e'
                ? Column(
                    children: [
                      EditProfile(),
                      RoundedButton(
                          color: Color(0xFFB7B7B7),
                          buttonHight: 45,
                          fontsize: 15,
                          buttonSize: 0.4,
                          textColor: Colors.white,
                          text: "cancel",
                          press: () {
                            setState(() {
                              onPage = 'm';
                            });
                          }),
                    ],
                  )
                : Column(
                    children: [
                      ChangePassword(),
                      RoundedButton(
                          color: Color(0xFFB7B7B7),
                          buttonHight: 45,
                          fontsize: 15,
                          buttonSize: 0.4,
                          textColor: Colors.white,
                          text: "cancel",
                          press: () {
                            setState(() {
                              onPage = 'm';
                            });
                          }),
                    ],
                  ));
  }
}



// import 'package:flutter/material.dart';
// import 'package:memby/constants.dart';
// import 'package:memby/components/Profile/editProfile.dart';
// import 'package:memby/components/Profile/changePassword.dart';

// class Main extends StatelessWidget {
//   final Function onPress;
//   final Function onPressEditProfile;

//   const Main({
//     Key key,
//     this.onPress,
//     this.onPressEditProfile,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     int index = 0;
//     return Container(
//         child: Column(
//       children: [
//         TextButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) {
//                   return EditProfile();
//                 },
//               ),
//             );
//           },
//           child: Container(
//             margin: EdgeInsets.only(left: 20),
//             child: Row(children: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return EditProfile();
//                       },
//                     ),
//                   );
//                 },
//                 icon: Icon(
//                   Icons.create_rounded,
//                   color: Colors.grey[500],
//                   size: 30,
//                 ),
//               ),
//               Text(
//                 'Edit Profile',
//                 style: TextStyle(color: Colors.grey[500], fontSize: 15),
//               )
//             ]),
//           ),
//         ),
//         Divider(
//           height: 10,
//           thickness: 2,
//           indent: 20,
//           endIndent: 20,
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) {
//                   return ChangePassword();
//                 },
//               ),
//             );
//           },
//           child: Container(
//             margin: EdgeInsets.only(left: 20),
//             child: Row(children: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return ChangePassword();
//                       },
//                     ),
//                   );
//                 },
//                 icon: Icon(
//                   Icons.lock_open_rounded,
//                   color: Colors.grey[500],
//                   size: 30,
//                 ),
//               ),
//               Text(
//                 'Change Password',
//                 style: TextStyle(color: Colors.grey[500], fontSize: 15),
//               )
//             ]),
//           ),
//         ),
//         Divider(
//           height: 10,
//           thickness: 2,
//           indent: 20,
//           endIndent: 20,
//         ),
//         TextButton(
//             child: Container(
//               margin: EdgeInsets.only(left: 20),
//               child: Row(children: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.exit_to_app,
//                     color: Colors.grey[500],
//                     size: 30,
//                   ),
//                 ),
//                 Text(
//                   'Log out',
//                   style: TextStyle(color: Colors.grey[500], fontSize: 15),
//                 )
//               ]),
//             ),
//             onPressed: onPress),
//       ],
//     ));
//   }
// }
