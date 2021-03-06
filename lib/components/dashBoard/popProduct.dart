import 'package:flutter/material.dart';
import 'package:memby/components/dashBoard/popProductList.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'package:memby/components/publicComponent/emptyItem.dart';

class PopProduct extends StatefulWidget {
  final String handleRender;
  final product;

  const PopProduct({Key key, this.handleRender, this.product})
      : super(key: key);
  @override
  _PopProductState createState() => _PopProductState();
}

List<PopProductList> render = [];

class _PopProductState extends State<PopProduct> {
  Future _productInfo;
  @override
  void initState() {
    super.initState();
    _productInfo = context
        .read<FlutterFireAuthService>()
        .getProductbyID(widget.product['id']);
  }

  @override
  void didUpdateWidget(PopProduct oldWidget) {
    super.didUpdateWidget(oldWidget);
    _productInfo = context
        .read<FlutterFireAuthService>()
        .getProductbyID(widget.product['id']);
  }

  makePopProductList(productInfo) {
    List<PopProductList> popProductHolder = [];
    if (productInfo['name'] == "Not Found") {
      return EmptyList(
        text: "Empty",
      );
    }
    popProductHolder.add(
      PopProductList(
        name: productInfo['name'],
        description: productInfo['description'],
        img: productInfo['product_img'],
        unit: widget.product['unitSale'].round(),
        totalSale: widget.product['totalSale'] * 1.0,
      ),
    );
    return Column(
      children: popProductHolder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _productInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                child: CircularProgressIndicator(), height: 50.0, width: 50.0);
          } else if (snapshot.hasData) {
            return makePopProductList(snapshot.data);
          }
        });
  }
}
