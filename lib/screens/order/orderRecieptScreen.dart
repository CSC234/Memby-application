import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memby/models/Order.dart';
import 'package:memby/constants.dart';
import 'package:memby/components/publicComponent/RoundedButton.dart';
import 'package:memby/models/OrderDetail.dart';
import 'package:memby/models/Product.dart';
import 'package:memby/screens/landingScreen.dart';

class OrderRecieptScreen extends StatelessWidget {
  final Order order;
  final QueryDocumentSnapshot customer;
  final int discount;
  final String companyName;
  bool isGeneralCustomer() {
    print("Checking Genneral Customer");
    print(customer);
    print(customer == null);
    return customer == null;
  }

  String getDate() {
    return new DateTime.now().toString().substring(0, 19);
  }

  OrderRecieptScreen(
      {this.order, this.customer, this.discount, this.companyName});

  double getTotalPrice() {
    double totalPrice = 0;
    for (OrderDetail i in order.orderDetails) {
      totalPrice += i.amount * i.product.price;
    }
    return totalPrice * (100 - discount) / 100;
  }

  double getActualPrice() {
    double totalPrice = 0;
    for (OrderDetail i in order.orderDetails) {
      totalPrice += i.amount * i.product.price;
    }
    return totalPrice;
  }

  makeRecieptDescription() {
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
    // print('====');
    return Column(
      // scrollDirection: Axis.vertical,
      children: itemsListTile,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Company Name: KTBNG Co.,Ltd',
                            style: kPrimaryHeadingTextStyle.copyWith(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            isGeneralCustomer()
                                ? "General Customer"
                                : 'Member ID: ${customer.id}',
                            style: kPrimaryHeadingTextStyle.copyWith(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      isGeneralCustomer()
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Member Name: ${customer.get("firstname") + " " + customer.get("lastname")}',
                                  style: kPrimaryHeadingTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Date: ${getDate()}',
                            style: kPrimaryHeadingTextStyle.copyWith(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    child: Divider(
                      height: 5,
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: order.orderDetails.isEmpty
                      ? Text('Empty Order')
                      : makeRecieptDescription(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        child: Divider(
                          height: 5,
                          thickness: 2,
                          indent: 0,
                          endIndent: 0,
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total: ",
                              style: kPrimaryHeadingTextStyle.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            ),
                            Text(
                              '${getActualPrice()}',
                              style: kPrimaryHeadingTextStyle.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Discount: ",
                              style: kPrimaryHeadingTextStyle.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            ),
                            Text(
                              '-${getActualPrice() * discount / 100}',
                              style: kPrimaryHeadingTextStyle.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Divider(
                          height: 5,
                          thickness: 2,
                          indent: 0,
                          endIndent: 0,
                        ),
                      ),
                      Container(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "NET: ",
                              style: kPrimaryHeadingTextStyle.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${getTotalPrice()}',
                              style: kPrimaryHeadingTextStyle.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    width: 200,
                    child: RoundedButton(
                      color: kPrimaryLightColor,
                      title: 'Back to home',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Landing();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
