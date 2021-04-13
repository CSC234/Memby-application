import 'package:flutter/material.dart';
import 'package:memby/components/popProductList.dart';

List<PopProductList> popProductMonthly = [
  PopProductList(
    name: 'Seksun Sekenium Monthly',
    description: "Lorem ipsum, or lipsum as it is sometimes known",
    unit: 500,
    totalSale: 123,
  )
];

List<PopProductList> popProductYearly = [
  PopProductList(
    name: 'Seksun Sekenium Yearly',
    description: "Lorem ipsum, or lipsum as it is sometimes known",
    unit: 555,
    totalSale: 1111,
  )
];
List<PopProductList> popProductDaily = [
  PopProductList(
    name: 'Seksun Sekenium Daily',
    description: "Lorem ipsum, or lipsum as it is sometimes known",
    unit: 234,
    totalSale: 1554,
  )
];

class PopProduct extends StatefulWidget {
  final String handleRender;

  const PopProduct({Key key, this.handleRender}) : super(key: key);
  @override
  _PopProductState createState() => _PopProductState();
}

List<PopProductList> render = [];

class _PopProductState extends State<PopProduct> {
  makePopProductList() {
    if (widget.handleRender == 'daily') {
      render = popProductDaily;
    }
    if (widget.handleRender == 'monthly') {
      render = popProductMonthly;
    }
    if (widget.handleRender == 'yearly') {
      render = popProductYearly;
    }
    List<PopProductList> popProductHolder = [];
    for (int i = 0; i < render.length; i++) {
      var p = render[i];
      popProductHolder.add(
        PopProductList(
          name: p.name,
          description: p.description,
          unit: p.unit,
          totalSale: p.totalSale,
        ),
      );
    }
    return Column(
      // padding: EdgeInsets.symmetric(vertical: 0),
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
