import 'package:flutter/material.dart';
// import 'package:memby/constants.dart';

class Textfield extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final double fontsize;
  final Color colorCircle, textColor;
  final int min;
  final double width;
  final int max;
  final bool isShow;
  final Icon icon;
  final Function press;
  const Textfield(
      {Key key,
      this.press,
      this.width,
      this.isShow,
      this.text,
      this.controller,
      this.colorCircle,
      this.textColor,
      this.min,
      this.max,
      this.icon,
      this.fontsize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      width: 350,
      height: 60,
      // width: width,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        TextField(
          controller: controller,
          obscureText: !isShow,
          decoration: InputDecoration(
              hintText: text,
              suffixIcon: IconButton(
                icon: Icon(
                  isShow ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black54,
                ),
                onPressed: () {
                  press();
                },
              ),
              border: InputBorder.none),
        ),
      ]),
    );
  }
}
