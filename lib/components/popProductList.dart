import 'package:flutter/material.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import '../constants.dart';

class PopProductList extends StatelessWidget {
  PopProductList({
    this.name,
    this.img,
    this.description,
    this.unit,
    this.totalSale,
  });

  final String name;
  final String img;
  final int unit;
  final String description;
  final double totalSale;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Container(
        child: Container(
          child: Container(
            child: Container(
              padding: const EdgeInsets.only(right: 20, left: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(this.img),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20, bottom: 5),
                          child: Text(
                            "${name}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryFont,
                                fontSize: 14),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 25),
                          child: Text(
                            "${description}",
                            style: TextStyle(color: kPrimaryFont),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 35,
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 0),
                                    child: Text(
                                      "Unit Sale",
                                      style: TextStyle(color: kPrimaryFont),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 0),
                                    child: Text(
                                      "${unit}",
                                      style: TextStyle(color: kPrimaryFont),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 7.5,
                              ),
                              Container(
                                  height: 35,
                                  child:
                                      VerticalDivider(color: Colors.grey[700])),
                              SizedBox(
                                width: 3.7,
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 0),
                                    child: Text(
                                      "Total Sale",
                                      style: TextStyle(color: kPrimaryFont),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 0),
                                    child: Text(
                                      "${totalSale}" + " Baht",
                                      style: TextStyle(color: kPrimaryFont),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            width: width,
            height: 150,
            decoration: DottedDecoration(
              shape: Shape.box,
              color: Color(0xFFB3ABBC),
              borderRadius:
                  BorderRadius.circular(10), //remove this to get plane rectange
            ),
          ),
        ),
      ),
    );
  }
}
