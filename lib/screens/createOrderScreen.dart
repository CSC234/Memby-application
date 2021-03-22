import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:dotted_decoration/dotted_decoration.dart';

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
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'crate order customer',
                  style: kPrimaryHeadingTextStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.normal),
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
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(3),
        child: Column(
          children: [
            Image.asset(
              'assets/images/$img.jpg',
              width: 100,
            ),
            Text(title),
          ],
        ),
        decoration: DottedDecoration(
          shape: Shape.box,
          color: Color(0xFFB3ABBC),
          borderRadius:
              BorderRadius.circular(10), //remove this to get plane rectange
        ),
      ),
    );
  }
}

// BoxDecoration(
//           border: Border.all(color: Color(0xFFB3ABBC), width: 1),
//           borderRadius: BorderRadius.circular(12),
//         ),