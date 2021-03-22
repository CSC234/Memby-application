import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:memby/components/CardProduct.dart';

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
  List<Product> product = [
    Product(question: "test", answer: [0])
  ];
  void change() {
    setState(() {
      product.add(Product(question: 'aasdg', answer: [val]));
      val += 1;
      // print(val);
      for (var i = 0; i < product.length; i++) {
        print(product[i].answer.toString());
      }
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
                    CardProductButton(
                      press: () {
                        change();
                      },
                    ),
                    
                    CardProductButton(
                      press: () {
                        change();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
