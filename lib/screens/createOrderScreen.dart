import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:memby/models/Product.dart';
import 'package:memby/models/OrderDetail.dart';
import 'package:memby/models/Order.dart';

//Mock up data
List<Product> Products = [
  Product(
      img: 'product1',
      productName: 'Product 1',
      description: 'Lorem ipsum, or lipsum as it is sometimes known',
      price: 100.0,
      id: '1',
      isFilled: false),
  Product(
      img: 'product1',
      productName: 'Product 2',
      description: 'Lorem ipsum, or lipsum as it is sometimes known',
      price: 200.0,
      id: '2',
      isFilled: false),
  Product(
      img: 'product1',
      productName: 'Product 3',
      description: 'Lorem ipsum, or lipsum as it is sometimes known',
      price: 300.0,
      id: '3',
      isFilled: false),
  Product(
      img: 'product1',
      productName: 'Product 4',
      description: 'Lorem ipsum, or lipsum as it is sometimes known',
      price: 400.0,
      id: '4',
      isFilled: false),
  Product(
      img: 'product1',
      productName: 'Product 5',
      description: 'Lorem ipsum, or lipsum as it is sometimes known',
      price: 500.0,
      id: '5',
      isFilled: false),
];

class CreateOrderScreen extends StatefulWidget {
  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  List<Product> selectedProduct = [];
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
            handleClicked(i);
          },
        ),
      );
    }
    return ListView(
      scrollDirection: Axis.horizontal,
      children: productCards,
    );
  }

  void handleClicked(int index) {
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

      // for (Product p in selectedProduct) {
      //   print(p.productName);
      // }
      // print('======');
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
              child: makeProductCard(),
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
                    ? Text('Empty Order')
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
                  for (OrderDetail i in order1.orderDetails) {
                    print(i.product.productName);
                    print(i.amount);
                  }
                  print('=======');
                  print(selectedProduct.length);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final Function onPress;
  final String title;
  final Color color;

  RoundedButton({this.color, this.onPress, this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(title),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) return color;
            return color; // Use the component's default.
          },
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  OrderCard(
      {this.title,
      this.img,
      this.description,
      this.price,
      this.amount,
      this.setAmount});

  final String title;
  final String img;
  final double price;
  final String description;
  final int amount;
  final Function setAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        'assets/images/${img}.jpg',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Container(
                          alignment: Alignment.topLeft,
                          width: 200,
                          child: Text(
                            description,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$price Baht'),
                          Container(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                setAmount(int.parse(value));
                              },
                              controller: TextEditingController()
                                ..text = amount.toString(),
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'amount',
                              ),
                            ),
                            width: 100,
                            height: 40,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        decoration: DottedDecoration(
          shape: Shape.box,
          color: Color(0xFFB3ABBC),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  ProductBox({this.img, this.title, this.isFilled, this.onPress});
  final String img;
  final String title;
  final bool isFilled;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        child: Container(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'assets/images/$img.jpg',
                    width: 100,
                  ),
                ),
                Text(title),
              ],
            ),
            height: 150,
            decoration: BoxDecoration(
              color: isFilled ? Color(0xFFDDDDDD) : null,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          decoration: DottedDecoration(
            shape: Shape.box,
            color: Color(0xFFB3ABBC),
            borderRadius:
                BorderRadius.circular(10), //remove this to get plane rectange
          ),
        ),
        onTap: onPress,
      ),
    );
  }
}
