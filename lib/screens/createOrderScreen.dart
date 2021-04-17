import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:memby/models/Product.dart';
import 'package:memby/models/OrderDetail.dart';
import 'package:memby/models/Order.dart';
import 'package:memby/components/RoundedButton.dart';
import 'package:memby/components/OrderCard.dart';
import 'package:memby/components/ProductBox.dart';
import 'package:memby/screens/confirmOrderScreen.dart';
import 'package:memby/components/emptyItem.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Mock up data

class CreateOrderScreen extends StatefulWidget {
  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  Future _productsData;
  bool _alreadyLoadProductsFromFirestore = false;
  List<Product> Products = [];

  @override
  void initState() {
    super.initState();
    _productsData = context.read<FlutterFireAuthService>().getProducts();
  }

  Order order1 = Order(
    id: '00001',
    orderDetails: [],
  );

  ListView makeProductCard() {
    List<ProductBox> productCards = [];

    for (int i = 0; i < Products.length; i++) {
      var p = Products[i];
      productCards.add(
        ProductBox(
          img: p.img,
          title: p.productName,
          isFilled: p.isFilled,
          onPress: () {
            handleClickedProductItem(i);
          },
        ),
      );
    }
    return ListView(
      scrollDirection: Axis.horizontal,
      children: productCards,
    );
  }

  void handleClickedProductItem(int index) {
    setState(() {
      Products[index].isFilled = !Products[index].isFilled;
      if (Products[index].isFilled == true) {
        OrderDetail order = OrderDetail(product: Products[index], amount: 1);
        order1.orderDetails.add(order);
      } else {
        int deletedIndex;
        for (int i = 0; i < order1.orderDetails.length; i++) {
          if (order1.orderDetails[i].product.id == Products[index].id) {
            deletedIndex = i;
          }
        }
        order1.orderDetails.removeAt(deletedIndex);
      }
    });
  }

  ListView makeOrderCard() {
    List<OrderCard> orderCards = [];

    for (OrderDetail o in order1.orderDetails) {
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
              height: 170.0,
              child: FutureBuilder(
                  future: _productsData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (!_alreadyLoadProductsFromFirestore) {
                        final List<DocumentSnapshot> productDocs =
                            snapshot.data.docs;

                        for (int i = 0; i < productDocs.length; i++) {
                          final pid = productDocs[i].id;
                          final p = productDocs[i].data();
                          Products.add(Product(
                              id: pid,
                              productName: p['name'],
                              price: (p['price'].toDouble()),
                              isFilled: false,
                              description: p['description'],
                              img: p['product_img']));
                        }

                        _alreadyLoadProductsFromFirestore = true;
                      }

                      return makeProductCard();
                    } else {
                      return SizedBox(
                          child: CircularProgressIndicator(),
                          height: 300.0,
                          width: 175.0);
                    }
                  }),
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
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: order1.orderDetails.isEmpty
                    ? EmptyList(
                        text: "Empty Order",
                      )
                    : makeOrderCard(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 95,
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
        child: Row(
          children: [
            Expanded(
              child: RoundedButton(
                color: kPrimaryLightColor,
                title: 'ORDER',
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ConfirmOrderScreen(
                          order: order1,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
