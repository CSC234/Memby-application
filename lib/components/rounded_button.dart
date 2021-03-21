import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final double fontsize;
  final Color color, textColor;
  final double buttonSize;
  final double buttonHight;

  const RoundedButton(
      {Key key,
      this.text,
      this.press,
      this.color,
      this.textColor,
      this.buttonSize,
      this.buttonHight,
      this.fontsize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: buttonHight,
      width: size.width * buttonSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
                color: textColor,
                fontSize: fontsize,
                fontFamily: 'Alef-Regular'),
          ),
        ),
      ),
    );
  }
}
