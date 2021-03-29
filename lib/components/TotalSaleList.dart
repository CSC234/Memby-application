import 'package:flutter/material.dart';

class TotalSaleList extends StatelessWidget {
  final int no;
  final String name;
  final int unit;
  final double totalSale;

  const TotalSaleList({Key key, this.no, this.name, this.unit, this.totalSale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, top: 0, right: 30),
      child: Stack(
        children: <Widget>[
          Align(alignment: Alignment.topLeft, child: Text("1" + ".")),
          Align(
              alignment: Alignment(-0.90, 0.0), child: Text("Selsun Selenium"))
        ],
      ),
    );
  }
}
