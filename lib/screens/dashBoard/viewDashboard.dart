import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:memby/components/dashBoard/TotalSaleList.dart';
import 'package:memby/components/dashBoard/topCustomer.dart';
import 'package:memby/components/dashBoard/popProduct.dart';
import 'package:memby/components/dashBoard/viewAll.dart';
import 'package:memby/components/dashBoard/viewAllCus.dart';
import 'package:memby/models/Product.dart';
import '../../constants.dart';
import 'package:memby/screens/landingScreen.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'package:memby/components/publicComponent/emptyItem.dart';

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
    if (productSummary.isEmpty) {
      return EmptyList(
        text: "Empty Product",
      );
    }
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

  makeTopCustomerList(LinkedHashMap customerSummary) {
    List<TopCustomer> customerHolder = [];

    int no = 1;

    if (customerSummary.isEmpty) {
      return EmptyList(
        text: "Empty Customer",
      );
    }
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

  Widget HandleViewAllCustomer() {
    return TextButton(
      child: Text("view all"),
      onPressed: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => ViewCustomer(
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
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false))),
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
                                                    child: Text("Total Sales",
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
                                                          Text("Unit Sales"),
                                                          Text("Total Sales"),
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
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return SizedBox(
                                                          child:
                                                              CircularProgressIndicator(),
                                                          height: 50.0,
                                                          width: 50.0);
                                                    } else if (snapshot
                                                        .hasData) {
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
                                                          height: 20.0,
                                                          width: 20.0);
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
                                                  HandleViewAllCustomer()
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

                                              FutureBuilder(
                                                  future: _customerSummary,
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return SizedBox(
                                                          child:
                                                              CircularProgressIndicator(),
                                                          height: 50.0,
                                                          width: 50.0);
                                                    } else if (snapshot
                                                        .hasData) {
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
