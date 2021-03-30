import 'package:flutter/material.dart';
import '../constants.dart';

class TopCustomer extends StatelessWidget {
  final int no;
  final String name;
  final String phoneNo;
  final double totalPaid;

  const TopCustomer({Key key, this.no, this.name, this.phoneNo, this.totalPaid})
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
            Text("${no}." + name),
            Container(
              width: width * (45 / 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${phoneNo}",
                    style: TextStyle(
                        color: kPrimaryFont,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${totalPaid}",
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
