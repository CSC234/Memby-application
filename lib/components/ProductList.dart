import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:memby/constants.dart';

class ProductList extends StatelessWidget {
  final String picture;
  final String product;
  final String description;
  final double price;
  final Function press;

  const ProductList(
      {Key key,
      this.picture,
      this.product,
      this.description,
      this.price,
      this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(children: [
      Container(
        child: Container(
          width: width * (90 / 100),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: 70,
                    width: 70,
                    padding: EdgeInsets.all(5),
                    child: picture != null
                        ? CircleAvatar(
                            radius: 10,
                            backgroundImage: NetworkImage(this.picture),
                          )
                        : CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.grey.withOpacity(.5),
                          )

                    // Image.asset(
                    //   'assets/images/product1.jpg',
                    //   width: 70,
                    // ),
                    ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 5, top: 15),
                      child: Text(
                        "name: " + product,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Container(
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        alignment: Alignment.topLeft,
                        width: 200,
                        child: Text(
                          description,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          height: 40,
                          width: 100,
                          child: Text("pirce: " + price.toString()),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 43,
                          child: TextButton(
                            child: Container(
                              width: 30,
                              height: 30,
                              child: Center(
                                  child: Text(
                                '-',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              )),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.grey),
                            ),
                            onPressed: press,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            // height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          decoration: DottedDecoration(
            shape: Shape.box,
            color: Color(0xFFB3ABBC),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      )
    ]);
  }
}
