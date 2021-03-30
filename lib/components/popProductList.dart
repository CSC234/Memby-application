import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:dotted_decoration/dotted_decoration.dart';

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
  final double unit;
  final String description;
  final int totalSale;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        child: Container(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset('assets/images/product1.jpg'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: Text("${name}"),
                    ),
                  ),
                  Container(
                    child: Text("test"),
                  )
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
