import 'package:flutter/material.dart';
import '../constants.dart';

class TotalSaleList extends StatelessWidget {
  final int no;
  final String name;
  final int unit;
  final double totalSale;

  const TotalSaleList({Key key, this.no, this.name, this.unit, this.totalSale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$no." + name),
            Container(
              width: width * (37 / 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$unit",
                    style: TextStyle(
                        color: kPrimaryFont,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$totalSale baht",
                    style: TextStyle(
                        color: kPrimaryFont,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
