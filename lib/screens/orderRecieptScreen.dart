import 'package:flutter/material.dart';
import 'package:memby/components/Profile/main.dart';
import 'package:memby/models/Order.dart';
import 'package:memby/constants.dart';
import 'package:memby/components/OrderCard.dart';
import 'package:memby/models/OrderDetail.dart';
import 'package:memby/models/Product.dart';

class OrderRecieptScreen extends StatelessWidget {
  final Order order;
  OrderRecieptScreen({this.order});

  double getTotalPrice() {
    double totalPrice = 0;
    for (OrderDetail i in order.orderDetails) {
      totalPrice += i.amount * i.product.price;
    }
    return totalPrice;
  }

  ListView makeRecieptDescription() {
    List<ListTile> itemsListTile = [];
    int count = 1;
    itemsListTile.add(
      ListTile(
        leading: Text(''),
        title: Text(
          'Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          'Total Price',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
    ////////////////////
    for (OrderDetail o in order.orderDetails) {
      Product p = o.product;
      int a = o.amount;
      // print(p.productName + "\n amount: " + a.toString());
      itemsListTile.add(
        ListTile(
          leading: Text('$count. '),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(p.productName),
              Text((a * p.price).toString() + ' THB'),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(a.toString() + ' unit'),
              SizedBox(
                width: 10,
              ),
              Text('(${p.price} THB)'),
            ],
          ),
        ),
      );
      count++;
    }
    itemsListTile.add(
      ListTile(
        trailing: Column(
          children: [
            Text(
              'Net Total',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${getTotalPrice().toString()} THB',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
    // print('====');
    return ListView(
      scrollDirection: Axis.vertical,
      children: itemsListTile,
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
                  'Reciept',
                  style: kPrimaryHeadingTextStyle,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Member ID: 193330000',
                        style: kPrimaryHeadingTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Member Name: Kodchapong',
                        style: kPrimaryHeadingTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Date: 14/04/2021',
                        style: kPrimaryHeadingTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: order.orderDetails.isEmpty
                    ? Text('Empty Order')
                    : makeRecieptDescription(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
