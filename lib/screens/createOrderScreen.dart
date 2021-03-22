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
                    ProductBox(
                      img: 'product1',
                      title: 'product1',
                      isFilled: true,
                    ),
                    ProductBox(
                      img: 'product1',
                      title: 'product1',
                      isFilled: false,
                    ),
                    ProductBox(
                      img: 'product1',
                      title: 'product1',
                      isFilled: false,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProductBox(
                      img: 'product1',
                      title: 'product1',
                      isFilled: false,
                    ),
                    ProductBox(
                      img: 'product1',
                      title: 'product1',
                      isFilled: true,
                    ),
                    ProductBox(
                      img: 'product1',
                      title: 'product1',
                      isFilled: false,
                    ),
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
  ProductBox({this.img, this.title, this.isFilled});
  final String img;
  final String title;
  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'assets/images/$img.jpg',
                  width: 100,
                ),
              ),
              Text(title),
            ],
          ),
          height: 150,
          decoration: BoxDecoration(
            color: isFilled ? Color(0xFFDDDDDD) : null,
            borderRadius: BorderRadius.circular(10),
          ),
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