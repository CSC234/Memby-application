import 'package:flutter/material.dart';
import 'package:memby/constants.dart';

class CardProductButton extends StatelessWidget {
  final String text;
  final Function press;
  final double fontsize;
  final Color colorCircle, textColor;
  final double buttonSize;
  final Icon icon;

  const CardProductButton(
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
      onPressed: press,
      child: SizedBox(
        width: width - 25,
        height: height * (35 / 100),
        child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white,
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
                    margin: EdgeInsets.only(left: 20),
                    child: Container(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text(
                            'Product 1',
                            style: TextStyle(
                                fontSize: 20,
                                color: kPrimaryMain,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            width: 60,
                            height: 60,
                            child: icon,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: kPrimaryMain),
                          ),
                        ])
                      ],
                    )))
              ],
            )),
      ),
    ));
  }
}
