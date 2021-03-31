import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:memby/models/Product.dart';
import 'package:memby/models/OrderDetail.dart';
import 'package:memby/models/Order.dart';
import 'package:memby/components/RoundedButton.dart';
import 'package:memby/components/OrderCard.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final Order order;
  ConfirmOrderScreen({this.order});

  @override
  _ConfirmOrderScreenState createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  ListView makeOrderCard() {
    List<OrderCard> orderCards = [];

    for (OrderDetail o in widget.order.orderDetails) {
      Product p = o.product;
      int a = o.amount;
      // print(p.productName + "\n amount: " + a.toString());
      orderCards.add(
        OrderCard(
          title: p.productName,
          img: p.img,
          description: p.description,
          price: p.price,
          amount: a,
          setAmount: o.setAmount,
        ),
      );
    }
    print('====');
    return ListView(
      scrollDirection: Axis.vertical,
      children: orderCards,
    );
  }

  int initialIndex = 0;
  bool isMember = false;
  @override
  Widget build(BuildContext context) {
    double getTotalPrice() {
      double totalPrice = 0;
      for (OrderDetail i in widget.order.orderDetails) {
        totalPrice += i.amount * i.product.price;
      }
      return totalPrice;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Confirm Order',
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
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Confirmed Products',
                    style: kPrimaryHeadingTextStyle.copyWith(
                        fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: widget.order.orderDetails.isEmpty
                    ? Text('Empty Order')
                    : makeOrderCard(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15.0,
                offset: Offset(0.0, 0.75))
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: ToggleSwitch(
                    minWidth: 100.0,
                    minHeight: 50,
                    initialLabelIndex: initialIndex,
                    cornerRadius: 30.0,
                    fontSize: 15,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Color(0xFF61656D),
                    inactiveFgColor: Colors.white,
                    labels: ['Member', 'Normal'],
                    activeBgColors: [kPrimaryLightColor, kPrimaryLightColor],
                    onToggle: (index) {
                      print('switched to: $index');
                      setState(() {
                        initialIndex = index;
                        isMember = index == 1;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {},
                      // controller: TextEditingController()
                      //   ..text = amount.toString(),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Customer\'s Phone no.',
                      ),
                    ),
                    height: 40,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 40,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('Kodchapong Dechboonyapichart'),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: isMember
                        ? Container(
                            child: Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xFFB7B7B7),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: 40,
                          )
                        : TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (value) {},
                            // controller: TextEditingController()
                            //   ..text = amount.toString(),
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Discount(%)',
                            ),
                          ),
                    height: 40,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Total Price',
                      ),
                      Text(
                        '${getTotalPrice()} Baht',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: RoundedButton(
                    color: kPrimaryLightColor,
                    title: 'ORDER',
                    onPress: () {
                      final customerPhone = '77797777977';
                      final discountRate = 0.95;
                      final totalPrice = getTotalPrice();
                      final orderDetails = widget.order.orderDetails;
                      dynamic _productList = {};
                      orderDetails.forEach((item) {
                        String productId = item.product.id;
                        _productList[productId] = item.amount;
                        print(_productList);
                      });
                      Map<String, dynamic> productList =
                          new Map<String, dynamic>.from(_productList);
                      context.read<FlutterFireAuthService>().addOrder(
                          customerPhone, discountRate, totalPrice, productList);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
