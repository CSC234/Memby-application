import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:memby/components/rounded_button.dart';

import 'package:memby/components/Textfield.dart';

class AddProductList extends StatefulWidget {
  @override
  final ValueChanged<String> onChanged;
  const AddProductList({
    Key key,
    this.onChanged,
  }) : super(key: key);

  _AddProductList createState() => _AddProductList();
}

class Product {
  String question;
  List<double> answer;
  Product({this.question, this.answer});
}

class _AddProductList extends State<AddProductList> {
  double val = 0;
// [{question:'',answer:[],{},{}]

  List<Product> product = [
    Product(question: "test", answer: [0])
  ];

  void change() {
    setState(() {
      product.add(Product(question: 'aasdg', answer: [val]));
      val += 1;
      print(product.length);
      print('---------------------');
    });
  }

  void changeDecrease(i) {
    setState(() {
      if (product.length > 1) product.removeAt(i);
      val -= 1;
      print(product.length);
      print('---------------------');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Container(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Add Product',
                      style: TextStyle(
                          color: kPrimaryFont,
                          fontSize: 45,
                          fontFamily: 'Alef-Regular'),
                    ),
                    Text(
                      'insert your product list',
                      style: TextStyle(
                          color: kPrimaryFont,
                          fontSize: 20,
                          fontFamily: 'Alef-Regular'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Textfield(
                              text: 'Product name...',
                              width: 210,
                              min: 1,
                              max: 5,
                            ),
                            Textfield(
                              text: 'Description...',
                              width: 210,
                              min: 5,
                              max: 5,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Textfield(
                              width: 150,
                              text: 'Price',
                              min: 1,
                              max: 5,
                            ),
                            Textfield(
                              text: 'Picture',
                              width: 150,
                              min: 5,
                              max: 5,
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: RoundedButton(
                            color: kPrimaryLightColor,
                            buttonHight: 50,
                            fontsize: 15,
                            buttonSize: 0.4,
                            textColor: Colors.white,
                            text: "Add to prodct",
                            press: () {}),
                      ),
                    ),
                    Divider(
                      height: 10,
                      thickness: 2,
                      indent: 25,
                      endIndent: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
