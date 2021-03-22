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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProductBox(img: 'product1', title: 'product1'),
                    ProductBox(img: 'product1', title: 'product1'),
                    ProductBox(img: 'product1', title: 'product1'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProductBox(img: 'product1', title: 'product1'),
                    ProductBox(img: 'product1', title: 'product1'),
                    ProductBox(img: 'product1', title: 'product1'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  ProductBox({this.img, this.title});
  final String img;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(
            'assets/images/$img.jpg',
            width: 100,
          ),
          Text(title),
        ],
      ),
    );
  }
}
