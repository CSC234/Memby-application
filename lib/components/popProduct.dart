import 'package:flutter/material.dart';
import 'package:memby/components/popProductList.dart';
import 'package:memby/models/Product.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<PopProductList> popProductMonthly = [
  PopProductList(
    name: 'Seksun Sekenium Monthly',
    description: "Lorem ipsum, or lipsum as it is sometimes known",
    unit: 500,
    totalSale: 123,
  ),
];

List<PopProductList> popProductYearly = [
  PopProductList(
    name: 'Seksun Sekenium Yearly',
    description: "Lorem ipsum, or lipsum as it is sometimes known",
    unit: 555,
    totalSale: 1111,
  )
];
List<PopProductList> popProductDaily = [
  PopProductList(
    name: 'Seksun Sekenium Daily',
    description: "Lorem ipsum, or lipsum as it is sometimes known",
    unit: 234,
    totalSale: 1554,
  )
];

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
    // if (widget.handleRender == 'daily') {
    //   render = popProductDaily;
    // }
    // if (widget.handleRender == 'monthly') {
    //   render = popProductMonthly;
    // }
    // if (widget.handleRender == 'yearly') {
    //   render = popProductYearly;
    // }
    List<PopProductList> popProductHolder = [];
    // for (int i = 0; i < render.length; i++) {

    //   var p = render[i];
    //   popProductHolder.add(
    //     PopProductList(
    //       name: p.name,
    //       description: p.description,
    //       unit: p.unit,
    //       totalSale: p.totalSale,
    //     ),
    //   );
    // }
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
      // padding: EdgeInsets.symmetric(vertical: 0),
      children: popProductHolder,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hieght = MediaQuery.of(context).size.height;

    return Container(
      height: hieght * 0.2,
      width: width,
      child: FutureBuilder(
          future: _productInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return makePopProductList(snapshot.data);
            } else {
              return SizedBox(
                  child: CircularProgressIndicator(),
                  height: 50.0,
                  width: 50.0);
            }
          }),
    );
  }
}
