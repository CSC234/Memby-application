import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:memby/components/popProductList.dart';

List<PopProductList> popProduct = [
  PopProductList(
    name: 'Seksun Sekenium sulfide',
    description: "testttttttttttttt",
    unit: 234,
    totalSale: 1554,
  )
];

class PopProduct extends StatefulWidget {
  @override
  _PopProductState createState() => _PopProductState();
}

class _PopProductState extends State<PopProduct> {
  ListView makePopProductList() {
    List<PopProductList> popProductHolder = [];
    for (int i = 0; i < popProduct.length; i++) {
      var p = popProduct[i];
      popProductHolder.add(
        PopProductList(
          name: p.name,
          description: p.description,
          unit: p.unit,
          totalSale: p.totalSale,
        ),
      );
    }
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 0),
      children: popProductHolder,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hieght = MediaQuery.of(context).size.height;

    return Container(
      height: hieght * 0.2,
      width: width,
      child: makePopProductList(),
    );
  }
}
