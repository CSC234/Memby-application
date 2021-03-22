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
        height: height * (12 / 100),
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
                  width: 60,
                  height: 60,
                  child: icon,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: colorCircle),
                ),
                Container(
                    child: Flexible(
                        child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: height * (1.5 / 100),
                    // ),

                    Container(
                        child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(text,
                          style: TextStyle(
                              fontSize: 23, fontFamily: 'Alef-Regular')),
                    )),
                    SizedBox(
                      height: 0,
                    ),
                    //center ครอบจะได้กลางๆ
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
