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
                              margin: EdgeInsets.only(left: width * (25 / 100)),
                              child: Row(children: [
                                TextButton(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 1),
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                      '+',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    )),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kPrimaryMain),
                                  ),
                                ),
                                TextButton(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 1),
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                      '-',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    )),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF6961D6)),
                                  ),
                                ),
                              ]))
                        ])
                      ],
                    )))
              ],
            )),
      ),
    ));
  }
}
