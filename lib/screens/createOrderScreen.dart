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
                  'create order customer',
                  style: kPrimaryHeadingTextStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.normal),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 200.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ProductBox(
                    img: 'product1',
                    title: 'product1',
                    isFilled: false,
                  ),
                  ProductBox(
                    img: 'product1',
                    title: 'product2',
                    isFilled: true,
                  ),
                  ProductBox(
                    img: 'product1',
                    title: 'product3',
                    isFilled: false,
                  ),
                  ProductBox(
                    img: 'product1',
                    title: 'product4',
                    isFilled: false,
                  ),
                  ProductBox(
                    img: 'product1',
                    title: 'product5',
                    isFilled: true,
                  ),
                  ProductBox(
                    img: 'product1',
                    title: 'product6',
                    isFilled: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Customer Product List',
                    style: kPrimaryHeadingTextStyle.copyWith(
                        fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    OrderCard(
                      title: 'Product 1',
                      img: 'product1',
                      description:
                          'Lorem ipsum, or lipsum as it is sometimes known',
                      price: '888',
                    ),
                    OrderCard(
                      title: 'Product 2',
                      img: 'product1',
                      description:
                          'Lorem ipsum, or lipsum as it is sometimes known',
                      price: '999',
                    ),
                    OrderCard(
                      title: 'Product 3',
                      img: 'product1',
                      description:
                          'Lorem ipsum, or lipsum as it is sometimes known',
                      price: '1112',
                    ),
                    OrderCard(
                      title: 'Product 4',
                      img: 'product1',
                      description:
                          'Lorem ipsum, or lipsum as it is sometimes known',
                      price: '1112',
                    ),
                    OrderCard(
                      title: 'Product 5',
                      img: 'product1',
                      description:
                          'Lorem ipsum, or lipsum as it is sometimes known',
                      price: '1112',
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  OrderCard({this.title, this.img, this.description, this.price});

  final String title;
  final String img;
  final String price;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'assets/images/$img.jpg',
                  width: 100,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Container(
                      alignment: Alignment.topLeft,
                      width: 200,
                      child: Text(
                        description,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 100,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text('$price Baht'),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFFC0C0C0),
                            width: 1,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration:
                              kTextFieldDecoration.copyWith(hintText: 'amount'),
                        ),
                        width: 100,
                        height: 40,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        decoration: DottedDecoration(
          shape: Shape.box,
          color: Color(0xFFB3ABBC),
          borderRadius: BorderRadius.circular(10),
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
