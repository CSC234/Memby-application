import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:memby/models/Product.dart';
import 'package:memby/models/OrderDetail.dart';
import 'package:memby/models/Order.dart';
import 'package:memby/components/RoundedButton.dart';
import 'package:memby/components/OrderCard.dart';
import 'package:memby/screens/createOrderScreen.dart';
import 'package:memby/screens/orderRecieptScreen.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:memby/components/toggle/animated_toggle_button.dart';
import 'package:memby/components/toggle/theme_color.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memby/screens/orderRecieptScreen.dart';
import 'package:memby/components/Register/TextBox.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final Order order;
  ConfirmOrderScreen({this.order});

  @override
  _ConfirmOrderScreenState createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  ListView makeOrderCard() {
    List<OrderCard> orderCards = [];

    ////////////////////
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

  AnimationController _animationController;
  bool isDarkMode = false;
  changeThemeMode() {
    if (isDarkMode) {
      _animationController.forward(from: 0.0);
    } else {
      _animationController.reverse(from: 1.0);
    }
  }

  ScrollController _scrollController = ScrollController();

  ThemeColor darkMode = ThemeColor(
    gradient: [
      const Color(0xFF6E7CE4),
      const Color(0xFF6E7CE4),
    ],
    backgroundColor: const Color(0xFF6E7CE4),
    textColor: const Color(0xFFFFFFFF),
    toggleButtonColor: const Color(0xFF6E7CE4),
    toggleBackgroundColor: const Color(0xFFe7e7e8),
    shadow: const <BoxShadow>[
      BoxShadow(
        color: const Color(0xFFd8d7da),
        spreadRadius: 5,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  );
  ThemeColor lightMode = ThemeColor(
    gradient: [
      const Color(0xFF6E7CE4),
      const Color(0xFF6E7CE4),
    ],
    backgroundColor: const Color(0xFF6E7CE4),
    textColor: const Color(0xFFFFFFFF),
    toggleButtonColor: const Color(0xFF6E7CE4),
    toggleBackgroundColor: const Color(0xFFe7e7e8),
    shadow: const [
      BoxShadow(
        color: const Color(0xFFd8d7da),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 5),
      ),
    ],
  );
  int initialIndex = 0;
  int discount = 0;
  bool isGeneralCustomer = false;
  bool isCustomerPhoneValid = false;
  String customerName = "Please Enter Customer Phone";
  String customerPhone = "";
  QueryDocumentSnapshot customer;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
            SizedBox(
              height: height * 0.035,
            ),
            Row(
              children: [
                Container(
                    width: width * 0.155,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.grey[700]),
                        onPressed: () => Navigator.of(context).pop(false))),
                SizedBox(
                  width: width * 0.01,
                ),
                Text(
                  "Confirm Order",
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
                  child: AnimatedToggle(
                    values: ['Member', 'Normal'],
                    textColor:
                        isDarkMode ? darkMode.textColor : lightMode.textColor,
                    backgroundColor: isDarkMode
                        ? darkMode.toggleBackgroundColor
                        : lightMode.toggleBackgroundColor,
                    buttonColor: isDarkMode
                        ? darkMode.toggleButtonColor
                        : lightMode.toggleButtonColor,
                    shadows: isDarkMode ? darkMode.shadow : lightMode.shadow,
                    onToggleCallback: (index) {
                      print('switched to: $index');
                      setState(() {
                        customerName = "Please Enter Customer Phone";
                        customerPhone = "";
                        isCustomerPhoneValid = false;
                        initialIndex = index;
                        isGeneralCustomer = index == 1;
                        if (isGeneralCustomer) {
                          Future.delayed(Duration(milliseconds: 100), () {
                            _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          });
                        }
                      });
                    },
                  ),
                  // ToggleSwitch(
                  //   minWidth: 100.0,
                  //   minHeight: 50,
                  //   initialLabelIndex: initialIndex,
                  //   cornerRadius: 30.0,
                  //   fontSize: 15,
                  //   activeFgColor: Colors.white,
                  //   inactiveBgColor: Color(0xFF61656D),
                  //   inactiveFgColor: Colors.white,
                  //   labels: ['Member', 'Normal'],
                  //   activeBgColors: [kPrimaryLightColor, kPrimaryLightColor],
                  //   onToggle: (index) {
                  //     print('switched to: $index');
                  //     setState(() {
                  //       initialIndex = index;
                  //       isMember = index == 1;
                  //     });
                  //   },
                  // ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: isGeneralCustomer
                      ? Center(
                          child: Container(
                            child: Text('General user'),
                          ),
                        )
                      : Container(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (value) async {
                              if (value.length == 10) {
                                String customerPhone = value;
                                print(customerPhone);
                                customer = await context
                                    .read<FlutterFireAuthService>()
                                    .getCustomerFromPhoneNo(customerPhone);

                                setState(() {
                                  isCustomerPhoneValid = customer != null;
                                  customerName = isCustomerPhoneValid
                                      ? customer.get("firstname") +
                                          " " +
                                          customer.get("lastname")
                                      : 'Member Not Found!';
                                });
                              } else {
                                setState(() {
                                  isCustomerPhoneValid = false;
                                  customer = null;

                                  customerName = "Please Enter Customer Phone";
                                });
                              }
                            },
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
                isGeneralCustomer
                    ? Container()
                    : Expanded(
                        flex: 2,
                        child: Container(
                          child: isCustomerPhoneValid
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 24.0,
                                )
                              : Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                          decoration: BoxDecoration(
                              color: isCustomerPhoneValid
                                  ? kPrimaryLightColor
                                  : Color(0xFFB7B7B7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: 40,
                        ),
                      ),
              ],
            ),
            isGeneralCustomer
                ? Container()
                : Row(
                    children: [
                      Text(
                        customerName,
                        style: isCustomerPhoneValid
                            ? TextStyle()
                            : TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: isGeneralCustomer
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
                            onChanged: (value) {
                              if (value != '' &&
                                  value[value.length - 1] != '.') {
                                setState(() {
                                  double input = double.parse(value);
                                  discount = input.floor();
                                  print(discount);
                                  discount = discount > 100
                                      ? 100
                                      : discount < 0
                                          ? 0
                                          : discount;
                                });
                              } else {
                                setState(() {
                                  discount = 0;
                                });
                              }
                            },
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
                        '${getTotalPrice() * (100 - discount) / 100} Baht',
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
                      color: isCustomerPhoneValid || isGeneralCustomer
                          ? kPrimaryLightColor
                          : Color(0xFFB7B7B7),
                      title: 'ORDER',
                      onPress: isCustomerPhoneValid || isGeneralCustomer
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return OrderRecieptScreen(
                                        order: widget.order,
                                        customer: customer,
                                        discount: discount);
                                  },
                                ),
                              );

                              final discountRate = discount / 100;
                              final actualPrice = getTotalPrice();
                              final totalPrice =
                                  getTotalPrice() * (100 - discount) / 100;
                              final customerId =
                                  customer == null ? null : customer.id;
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
                                  customerId,
                                  discountRate,
                                  actualPrice,
                                  totalPrice,
                                  productList);
                            }
                          : null),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
