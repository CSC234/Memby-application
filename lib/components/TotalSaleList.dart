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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$no." + name),
            Text("$unit"),
            Text("$totalSale baht")
          ],
        ),
      ),
    );
  }
}
