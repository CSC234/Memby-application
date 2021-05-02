import 'package:flutter/material.dart';
import 'package:memby/components/dashBoard/TotalSaleList.dart';
import 'package:memby/components/chart.dart';
import 'package:memby/components/publicComponent/emptyItem.dart';
import '../../constants.dart';
import 'package:memby/screens/dashBoard/viewDashboard.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'dart:collection';

List<TotalSaleList> productListDaily = [
  TotalSaleList(
    no: 1,
    name: "Selsun Selenium sulfide1",
    unit: 134,
    totalSale: 1754,
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
    totalSale: 1554,
  ),
  TotalSaleList(
    no: 6,
    name: "Selsun Selenium sulfide5",
    unit: 2244,
    totalSale: 1554,
  ),
];
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
    totalSale: 2,
  ),
  TotalSaleList(
    no: 3,
    name: "Selsun Selenium sulfide3",
    unit: 3,
    totalSale: 3,
  ),
  TotalSaleList(
    no: 4,
    name: "Selsun Selenium sulfide3",
    unit: 4,
    totalSale: 4,
  ),
];
List<TotalSaleList> productListMonthly = [
  TotalSaleList(
    no: 1,
    name: "Selsun Selenium sulfide1",
    unit: 1341,
    totalSale: 1524,
  ),
  TotalSaleList(
    no: 2,
    name: "Selsun Selenium sulfide2",
    unit: 244,
    totalSale: 2554,
  ),
  TotalSaleList(
    no: 3,
    name: "Selsun Selenium sulfide3",
    unit: 123244,
    totalSale: 12554,
  ),
];

class ViewAll extends StatefulWidget {
  @override
  final bool clickDaily;
  final bool clickMonthly;
  final bool clickYearly;
  final Function handleClickChangeToggleDaily;
  final Function handleClickChangeToggleMonthly;
  final Function handleClickChangeToggleYearly;
  final String startDate;
  const ViewAll(
      {Key key,
      this.clickDaily,
      this.clickMonthly,
      this.clickYearly,
      this.handleClickChangeToggleMonthly,
      this.handleClickChangeToggleDaily,
      this.handleClickChangeToggleYearly,
      this.startDate})
      : super(key: key);
  _ViewAllState createState() => _ViewAllState();
}

List<TotalSaleList> render = [];
List<TotalSaleList> renderFilter = [];

String isRender;

class _ViewAllState extends State<ViewAll> {
  var _filterText = TextEditingController();
  Future _productSummary;
  String startDate;

  bool clickDaily = false;
  bool clickMonthly = true;
  bool clickYearly = true;
  List<TotalSaleList> productHolder = [];

  @override
  void initState() {
    super.initState();
    clickDaily = widget.clickDaily;
    clickMonthly = widget.clickMonthly;
    clickYearly = widget.clickYearly;
    startDate = widget.startDate;
    _productSummary =
        context.read<FlutterFireAuthService>().getProductSummary(startDate);
  }

  makeProductList(LinkedHashMap productSummary) {
    productHolder = [];
    if (clickDaily == false) {
      isRender = 'daily';
    }
    if (clickMonthly == false) {
      isRender = 'monthly';
    }
    if (clickYearly == false) {
      isRender = 'yearly';
    }

    if (clickDaily == false) {
      render = productListDaily;
    }
    if (clickMonthly == false) {
      render = productListMonthly;
    }
    if (clickYearly == false) {
      render = productListYearly;
    }
    if (productSummary.isEmpty) {
      return EmptyList(
        text: "Empty Customer",
      );
    }
    int no = 1;
    productSummary.forEach((productId, product) {
      productHolder.add(TotalSaleList(
        no: no,
        name: product['name'],
        unit: product['unitSale'],
        totalSale: (product['totalSale'] * 100).round() / 100,
      ));
      no++;
    });

    List<TotalSaleList> renderFilter = productHolder
        .where((el) =>
            el.name.indexOf(_filterText.text) != -1 || _filterText.text.isEmpty)
        .toList();
    productHolder = renderFilter;
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 0),
      children: productHolder,
    );
  }

  void handleClickChangeToggleDaily() {
    setState(() {
      clickDaily = false;
      clickMonthly = true;
      clickYearly = true;
      startDate = 'd';
      _productSummary =
          context.read<FlutterFireAuthService>().getProductSummary(startDate);
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
      ;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      height: height * (60 / 100),
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
                                    child: Row(
                                      children: [
                                        Row(children: [
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
                                      ],
                                    )),
                                Positioned(
                                    top: height * (14 / 100),
                                    left: width * (26 / 100),
                                    child: Text(
                                      'Total sale information',
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
                      child: SingleChildScrollView(
                        child: Container(
                            width: width * (100 / 100),
                            child: SingleChildScrollView(
                              child: SingleChildScrollView(
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      13.0),
                                                          child: Text(
                                                              "Total Sale",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      18)),
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.05,
                                                        ),
                                                        Expanded(
                                                          child: SizedBox(
                                                            height: 30,
                                                            child: TextField(
                                                              controller:
                                                                  _filterText,
                                                              decoration:
                                                                  InputDecoration(
                                                                prefixIcon:
                                                                    Icon(Icons
                                                                        .search),
                                                                hintText:
                                                                    'What are you looking for?',
                                                                hintStyle:
                                                                    TextStyle(
                                                                        fontSize:
                                                                            14),
                                                              ),
                                                              onSubmitted:
                                                                  (value) {
                                                                setState(() {});

                                                                print(
                                                                    _filterText
                                                                        .text);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      height: 0,
                                                      thickness: 1,
                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("Product Name"),
                                                          Container(
                                                            width: width *
                                                                (40 / 100),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                    "Unit Sale"),
                                                                Text(
                                                                    "Total Sale"),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    FutureBuilder(
                                                        future: _productSummary,
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return Container(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                                height: 50.0,
                                                                width: 50.0);
                                                          } else if (snapshot
                                                              .hasData) {
                                                            return Container(
                                                              height:
                                                                  height * 0.25,
                                                              width: width *
                                                                  (90 / 100),
                                                              child:
                                                                  makeProductList(
                                                                      snapshot
                                                                          .data),
                                                            );
                                                          } else {
                                                            return SizedBox(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                                height: 50.0,
                                                                width: 50.0);
                                                          }
                                                        }),

                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 13.0),
                                                        child: Text(
                                                            "Total Sale",
                                                            style: TextStyle(
                                                                fontSize: 18)),
                                                      ),
                                                    ]),
                                                    FutureBuilder(
                                                        future: _productSummary,
                                                        builder: (context,
                                                            snapshot) {
                                                          print("ดูข้างล่างไอสัส");
                                                          print(snapshot.data.isEmpty);
                                                          print(snapshot
                                                                  .data[0] ==
                                                              null);
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return Container(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                                height: 50.0,
                                                                width: 50.0);
                                                          } else if (snapshot
                                                                  .data.isNotEmpty) {
                                                            return Chart(
                                                                saleSummmary:
                                                                    snapshot
                                                                        .data);
                                                          } else if (snapshot
                                                                  .data[0] ==
                                                              null) {
                                                            return EmptyList(
                                                              text:
                                                                  "Empty",
                                                            );
                                                          }
                                                        }),

                                                    // Chart(),
                                                    SizedBox(
                                                      height: 60,
                                                    )
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
                            )),
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
