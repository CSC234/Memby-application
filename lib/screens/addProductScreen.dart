import 'package:flutter/material.dart';
import 'package:memby/constants.dart';

class AddProductList extends StatefulWidget {
  @override
  final ValueChanged<String> onChanged;
  const AddProductList({
    Key key,
    this.onChanged,
  }) : super(key: key);
  _AddProductList createState() => _AddProductList();
}

class _AddProductList extends State<AddProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: Container(
          child: Text('Add Product List'),
        ));
  }
}
