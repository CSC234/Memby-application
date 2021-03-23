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
    return Column(children: [
      Container(
        height: 100,
        width: width * (90 / 100),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'assets/images/product1.jpg',
                  width: 70,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 10),
                    child: Text(
                      "name: " + product,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Container(
                    child: Container(
                      padding: EdgeInsets.all(5),
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
                        padding: EdgeInsets.all(5),
                        height: 40,
                        width: 100,
                        child: Text("pirce: " + price.toString()),
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
      ),
      SizedBox(
        height: 10,
      )
    ]);
  }
}
