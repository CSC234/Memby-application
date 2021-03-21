import 'package:flutter/material.dart';
import 'package:memby/constants.dart';

class CardButton extends StatelessWidget {
  final String text;
  final Function press;
  final double fontsize;
  final Color colorCircle, textColor;
  final double buttonSize;
  final Icon icon;

  const CardButton(
      {Key key,
      this.text,
      this.press,
      this.colorCircle,
      this.textColor,
      this.buttonSize,
      this.icon,
      this.fontsize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        child: FlatButton(
      padding: EdgeInsets.only(
        top: 20,
      ),
      onPressed: press,
     
      child: SizedBox(
        width: width - 60,
        height: 100,
        child: DecoratedBox(
            decoration: BoxDecoration(
                color: kPrimaryCard,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ]),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: 80,
                  height: 80,
                  child: icon,
                  decoration: BoxDecoration(
                    // 0xFF4941BB
                      shape: BoxShape.circle, color: colorCircle),
                ),
                Container(
                    child: Flexible(
                        child: Column(
                  children: [
                    SizedBox(
                      height: 13,
                    ),
                    Container(
                        child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(text,
                          style: TextStyle(
                              fontSize: 23, fontFamily: 'Alef-Regular')),
                    )),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                          'Lorem ipsum, or lipsum as it is sometimes known',
                          style: TextStyle(fontFamily: 'Alef-Regular')),
                    )),
                  ],
                )))
              ],
            )),
      ),
    ));
  }
}