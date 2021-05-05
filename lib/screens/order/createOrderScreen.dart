import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:memby/models/Product.dart';
import 'package:memby/models/OrderDetail.dart';
import 'package:memby/models/Order.dart';
import 'package:memby/components/publicComponent/RoundedButton.dart';
import 'package:memby/components/order/OrderCard.dart';
import 'package:memby/components/order/ProductBox.dart';
import 'package:memby/screens/order/confirmOrderScreen.dart';
import 'package:memby/components/publicComponent/emptyItem.dart';
import 'package:memby/screens/landingScreen.dart';
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
    _productsData =
        context.read<FlutterFireAuthService>().getProducts(visible: true);
  }

  Order order1 = Order(
    id: '00001',
    orderDetails: [],
  );

  bool isHasOrder = false;

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
      setState(() {
        if (order1.orderDetails.isNotEmpty) {
          isHasOrder = true;
        } else {
          isHasOrder = false;
        }
      });
    });
  }

  ListView makeOrderCard() {
    List<OrderCard> orderCards = [];

    for (OrderDetail o in order1.orderDetails) {
      Product p = o.product;
      int a = o.amount;
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
    setState(() {
      if (orderCards.isNotEmpty) {
        isHasOrder = true;
      }
    });

    return ListView(
      scrollDirection: Axis.vertical,
      children: orderCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.035,
            ),
            Row(
              children: [
                Container(
                    width: width * 0.15,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.grey[700]),
                        onPressed: () =>
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Landing();
                              },
                            )))),
                SizedBox(
                  width: width * 0.05,
                ),
                Text(
                  "Create Order",
                  style: TextStyle(
                      fontSize: 43,
                      fontFamily: 'Alef-Regular',
                      color: Colors.grey[700]),
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
                      return snapshot.data.docs.length == 0
                          ? EmptyList(
                              text: "Empty Product",
                            )
                          : makeProductCard();
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
                color: isHasOrder ? kPrimaryLightColor : Color(0xFFB7B7B7),
                title: 'ORDER',
                onPress: isHasOrder
                    ? () {
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
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
