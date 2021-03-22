import 'package:flutter/material.dart';
import 'package:memby/constants.dart';

class CreateOrderScreen extends StatefulWidget {
  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create Order',
                  style: kPrimaryHeadingTextStyle,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Image.asset('assets/images/product1.png'),
                      Text('product1')
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
