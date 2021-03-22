import 'package:flutter/material.dart';
import 'package:memby/constants.dart';

class CreateOrderScreen extends StatefulWidget {
  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Create Order',
          style: TextStyle(
              color: kPrimaryFont,
              fontWeight: FontWeight.bold,
              fontSize: 28,
              fontFamily: 'Alef-Regular'),
        ),
      ],
    );
  }
}
