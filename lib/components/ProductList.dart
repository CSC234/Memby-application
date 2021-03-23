import 'package:flutter/material.dart';
import 'package:dotted_decoration/dotted_decoration.dart';

class ProductList extends StatelessWidget {
  final double fontsize;
  final String product;
  final String description;
  final int price;

  const ProductList(
      {Key key, this.fontsize, this.product, this.description, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: 100,
      width: width * (90 / 100),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              // child: Image.asset(
              // 'assets/images/$img.jpg',
              // width: 100,
              // ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  child: Container(
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
                      height: 40,
                      width: 100,
                      child: Text(price.toString()),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      decoration: DottedDecoration(
        shape: Shape.box,
        color: Color(0xFFB3ABBC),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
