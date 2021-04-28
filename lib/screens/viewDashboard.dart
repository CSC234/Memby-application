import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:memby/components/TotalSaleList.dart';
import 'package:memby/components/topCustomer.dart';
import 'package:memby/components/popProduct.dart';
import 'package:memby/components/viewAll.dart';
import 'package:memby/models/Product.dart';
import '../constants.dart';
import 'package:memby/screens/landingScreen.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';

List<TotalSaleList> productListYearly = [
  TotalSaleList(
    no: 1,
    name: "Selsun Selenium sulfide1",
    unit: 1,
    totalSale: 1,
  ),
  TotalSaleList(
    no: 2,
    name: "Selsun Selenium sulfide2",
    unit: 2,
    totalSale: 200,
  ),
  TotalSaleList(
    no: 3,
    name: "Selsun Selenium sulfide3",
    unit: 3,
    totalSale: 31,
  ),
  TotalSaleList(
    no: 4,
    name: "Selsun Selenium sulfide3",
    unit: 4,
    totalSale: 124,
  ),
];
List<TotalSaleList> productListMonthly = [
  TotalSaleList(
    no: 1,
    name: "Selsun Selenium sulfide1",
    unit: 1341,
    totalSale: 153254,
  ),
  TotalSaleList(
    no: 2,
    name: "Selsun Selenium sulfide2",
    unit: 244,
    totalSale: 21554,
  ),
  TotalSaleList(
    no: 3,
    name: "Selsun Selenium sulfide3",
    unit: 123244,
    totalSale: 12554,
  ),
];
List<TotalSaleList> productListDaily = [
  TotalSaleList(
    no: 1,
    name: "Selsun Selenium sulfide1",
    unit: 134,
    totalSale: 15541,
  ),
  TotalSaleList(
    no: 2,
    name: "Selsun Selenium sulfide2",
    unit: 213244,
    totalSale: 1554,
  ),
  TotalSaleList(
    no: 3,
    name: "Selsun Selenium sulfide3",
    unit: 12344,
    totalSale: 1554,
  ),
  TotalSaleList(
    no: 4,
    name: "Selsun Selenium sulfide4",
    unit: 2344,
    totalSale: 1554,
  ),
  TotalSaleList(
    no: 5,
    name: "Selsun Selenium sulfide5",
    unit: 2244,
    totalSale: 11,
  ),
  TotalSaleList(
    no: 6,
    name: "Selsun Selenium sulfide5",
    unit: 2244,
    totalSale: 0,
  ),
];
List<TopCustomer> popSaleListYearly = [
  TopCustomer(
    no: 1,
    name: 'katak',
    phoneNo: "095955238",
    totalPaid: 123123,
  ),
  TopCustomer(
    no: 2,
    name: 'katak',
    phoneNo: "011928437",
    totalPaid: 55112,
  ),
  TopCustomer(
    no: 3,
    name: 'katak',
    phoneNo: "1234567890",
    totalPaid: 20,
  ),
  TopCustomer(
    no: 4,
    name: 'katak',
    phoneNo: "12345677",
    totalPaid: 2201,
  ),
];
List<TopCustomer> popSaleListMonthly = [
  TopCustomer(
    no: 1,
    name: 'Gun',
    phoneNo: "095955238",
    totalPaid: 1002,
  ),
  TopCustomer(
    no: 2,
    name: 'Gun',
    phoneNo: "011928437",
    totalPaid: 55030,
  ),
  TopCustomer(
    no: 3,
    name: 'Gun',
    phoneNo: "1234567890",
    totalPaid: 2110,
  ),
  TopCustomer(
    no: 4,
    name: 'Gun',
    phoneNo: "12345677",
    totalPaid: 2220,
  ),
];
List<TopCustomer> popSaleListDaily = [
  TopCustomer(
    no: 1,
    name: 'Best',
    phoneNo: "095955238",
    totalPaid: 100,
  ),
  TopCustomer(
    no: 2,
    name: 'Best',
    phoneNo: "011928437",
    totalPaid: 5500,
  ),
  TopCustomer(
    no: 3,
    name: 'Best',
    phoneNo: "1234567890",
    totalPaid: 20,
  ),
  TopCustomer(
    no: 4,
    name: 'Best',
    phoneNo: "12345677",
    totalPaid: 220,
  ),
];

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

List<TotalSaleList> render = [];
String isRender;

class _DashBoardState extends State<DashBoard> {
  Future _productSummary;
  Future _customerSummary;

  String startDate = "d";

  @override
  void initState() {
    super.initState();
    _productSummary =
        context.read<FlutterFireAuthService>().getProductSummary(startDate);
    _customerSummary =
        context.read<FlutterFireAuthService>().getCustomerSummary(startDate);
  }

  makeProductList(LinkedHashMap productSummary) {
    if (clickDaily == false) {
      isRender = 'daily';
    }
    if (clickMonthly == false) {
      isRender = 'monthly';
    }
    if (clickYearly == false) {
      isRender = 'yearly';
    }
    List<TotalSaleList> productHolder = [];
    if (clickDaily == false) {
      render = productListDaily;
    }
    if (clickMonthly == false) {
      render = productListMonthly;
    }
    if (clickYearly == false) {
      render = productListYearly;
    }
    int no = 1;
    productSummary.forEach((productId, product) {
      if (no <= 5) {
        productHolder.add(TotalSaleList(
          no: no,
          name: product['name'],
          unit: product['unitSale'],
          totalSale: (product['totalSale'] * 100).round() / 100,
        ));
        no++;
      }
    });

    return Column(
      children: productHolder,
    );
  }

  bool clickDaily = false;
  bool clickMonthly = true;
  bool clickYearly = true;

  void handleClickChangeToggleDaily() {
    setState(() {
      clickDaily = false;
      clickMonthly = true;
      clickYearly = true;
      startDate = 'd';
      _productSummary =
          context.read<FlutterFireAuthService>().getProductSummary(startDate);
      _customerSummary =
          context.read<FlutterFireAuthService>().getCustomerSummary(startDate);
    });
  }

  void handleClickChangeToggleMonthly() {
    setState(() {
      clickDaily = true;
      clickMonthly = false;
      clickYearly = true;
      startDate = 'm';
      _productSummary =
          context.read<FlutterFireAuthService>().getProductSummary(startDate);
      _customerSummary =
          context.read<FlutterFireAuthService>().getCustomerSummary(startDate);
    });
  }

  void handleClickChangeToggleYearly() {
    setState(() {
      clickDaily = true;
      clickMonthly = true;
      clickYearly = false;
      startDate = 'y';
      _productSummary =
          context.read<FlutterFireAuthService>().getProductSummary(startDate);
      _customerSummary =
          context.read<FlutterFireAuthService>().getCustomerSummary(startDate);
    });
  }

  List<TopCustomer> renderCustomer = [];
  makeTopCustomerList(LinkedHashMap customerSummary) {
    List<TopCustomer> customerHolder = [];

    int no = 1;
    customerSummary.forEach((customerID, customer) {
      if (no <= 5) {
        customerHolder.add(
          TopCustomer(
            no: no,
            name: customer['name'],
            phoneNo: customer['phone'],
            totalPaid: (customer['totalPaid'] * 100).round() / 100,
          ),
        );
        no++;
      }
    });
    return Column(
      children: customerHolder,
    );
  }

  Widget HandleViewAll() {
    return TextButton(
      child: Text("view all"),
      onPressed: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => ViewAll(
                clickMonthly: clickMonthly,
                clickDaily: clickDaily,
                clickYearly: clickYearly,
                startDate: startDate),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        // height: height * (50 / 100),
                        // height: ,/
                        child: SizedBox(
                            width: width,
                            height: 350,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                color: kPrimaryMain,
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: height * (6 / 100),
                                    // left: 20,
                                    child: Row(children: [
                                      Container(
                                        width: width * 0.15,
                                        child: IconButton(
                                            icon: Icon(Icons.arrow_back,
                                                color: Colors.white),
                                            onPressed: () => Navigator.of(context).pop(false))),
                                      Text(
                                        'View DashBoard',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.1,
                                            fontFamily: 'Alef-Regular'),
                                      )
                                    ]),
                                  ),
                                  Positioned(
                                      top: height * (14 / 100),
                                      left: width * (29 / 100),
                                      child: Text(
                                        'insight information',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'Alef-Regular'),
                                      )),
                                ],
                              ),
                            )),
                      ),
                      Positioned(
                        top: height * 0.21,
                        height: height * (100 / 100),
                        child: Container(
                          width: width * (100 / 100),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  height: height,
                                  width: width,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              topNav(
                                                isClick: clickDaily,
                                                title: 'Daily',
                                                click:
                                                    handleClickChangeToggleDaily,
                                              ),
                                              topNav(
                                                isClick: clickMonthly,
                                                title: 'Monthly',
                                                click:
                                                    handleClickChangeToggleMonthly,
                                              ),
                                              topNav(
                                                isClick: clickYearly,
                                                title: 'Yearly',
                                                click:
                                                    handleClickChangeToggleYearly,
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 0,
                                          thickness: 1,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 13.0),
                                                    child: Text("Total Sale",
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                  HandleViewAll(),
                                                ],
                                              ),
                                              Divider(
                                                height: 0,
                                                thickness: 1,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Product Name"),
                                                    Container(
                                                      width: width * (38 / 100),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("Unit Sale"),
                                                          Text("Total Sale"),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              // Container(
                                              //   width: width * (90 / 100),
                                              //   child: makeProductList(),
                                              // ),
                                              FutureBuilder(
                                                  future: _productSummary,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      var _popRef = snapshot
                                                          .data.entries
                                                          .toList();
                                                      var popularProduct = {
                                                        'id': 'n',
                                                        'unitSale': 0,
                                                        'totalSale': 0.0
                                                      };

                                                      if (_popRef.length > 0) {
                                                        _popRef = _popRef[0];
                                                        popularProduct = {
                                                          'id': _popRef.key,
                                                          'unitSale':
                                                              _popRef.value[
                                                                  'unitSale'],
                                                          'totalSale':
                                                              _popRef.value[
                                                                  'totalSale']
                                                        };
                                                      }

                                                      return Column(
                                                        children: [
                                                          Container(
                                                            height: height *
                                                                (21 / 100),
                                                            width: width *
                                                                (90 / 100),
                                                            child:
                                                                makeProductList(
                                                                    snapshot
                                                                        .data),
                                                          ),
                                                          Divider(
                                                            height: 0,
                                                            thickness: 1,
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Popular Product",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          PopProduct(
                                                            handleRender:
                                                                isRender,
                                                            product:
                                                                popularProduct,
                                                          )
                                                        ],
                                                      );
                                                    } else {
                                                      return SizedBox(
                                                          child:
                                                              CircularProgressIndicator(),
                                                          height: 50.0,
                                                          width: 50.0);
                                                    }
                                                  }),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 13.0),
                                                    child: Text("Top Customer",
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                height: 0,
                                                thickness: 1,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Name",
                                                      style: TextStyle(
                                                          color: kPrimaryFont,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Container(
                                                      width: width * (45 / 100),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Phone NO.",
                                                            style: TextStyle(
                                                                color:
                                                                    kPrimaryFont,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            "Total Paid",
                                                            style: TextStyle(
                                                                color:
                                                                    kPrimaryFont,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Container(
                                                height: height * (21 / 100),
                                                width: width * (90 / 100),
                                                child: FutureBuilder(
                                                    future: _customerSummary,
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return makeTopCustomerList(
                                                            snapshot.data);
                                                      } else {
                                                        return SizedBox(
                                                            child:
                                                                CircularProgressIndicator(),
                                                            height: 50.0,
                                                            width: 50.0);
                                                      }
                                                    }),
                                              ),
                                              ////////-------------- history ------------------
                                              SizedBox(
                                                height: 220,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            decoration: const BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      )
                      //
                    ],
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

class topNav extends StatefulWidget {
  topNav({Key key, this.title, this.isClick, this.click}) : super(key: key);
  final String title;
  final bool isClick;
  final Function click;
  @override
  _topNavState createState() => _topNavState();
}

class _topNavState extends State<topNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: [
      TextButton(
        child: Container(
          padding: EdgeInsets.only(
            bottom: 2, // Space between underline and text
          ),
          decoration: widget.isClick
              ? BoxDecoration()
              : BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                  color: Color(0xFF2336C0),
                  width: 3.0, // Underline thickness
                ))),
          child: Text(widget.title,
              style: TextStyle(
                color: kPrimaryFont,
                fontSize: 18,
              )),
        ),
        onPressed: () {
          widget.click();
        },
      ),
    ]));
  }
}
