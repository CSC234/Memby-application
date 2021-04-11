import 'package:flutter/material.dart';
import 'package:memby/models/Order.dart';
import 'package:memby/constants.dart';
import 'package:memby/components/OrderCard.dart';
import 'package:memby/models/OrderDetail.dart';
import 'package:memby/models/Product.dart';

class OrderRecieptScreen extends StatelessWidget {
  final Order order;
  OrderRecieptScreen({this.order});

  ListView makeOrderCard() {
    List<OrderCard> orderCards = [];

    ////////////////////
    for (OrderDetail o in order.orderDetails) {
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
                  'Confirm Order',
                  style: kPrimaryHeadingTextStyle,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Confirmed Products',
            //         style: kPrimaryHeadingTextStyle.copyWith(
            //             fontSize: 20, fontWeight: FontWeight.normal),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: order.orderDetails.isEmpty
                    ? Text('Empty Order')
                    : makeOrderCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
