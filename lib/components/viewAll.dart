import 'package:flutter/material.dart';
import 'package:memby/components/TotalSaleList.dart';
import 'package:memby/components/chart.dart';
import '../constants.dart';

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
  _ViewAllState createState() => _ViewAllState();
}

List<TotalSaleList> render = [];
String isRender;

class _ViewAllState extends State<ViewAll> {
  ListView makeProductList() {
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
    for (int i = 0; i < render.length; i++) {
      var p = render[i];
      productHolder.add(
        TotalSaleList(
          no: p.no,
          name: p.name,
          unit: p.unit,
          totalSale: p.totalSale,
        ),
      );
    }
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 0),
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
    });
  }

  void handleClickChangeToggleMonthly() {
    setState(() {
      clickDaily = true;
      clickMonthly = false;
      clickYearly = true;
    });
  }

  void handleClickChangeToggleYearly() {
    setState(() {
      clickDaily = true;
      clickMonthly = true;
      clickYearly = false;
    });
  }

  Widget HandleViewAll() {
    print(productListDaily.length);

    if (productListDaily.length > 5) {
      return TextButton(
        child: Text("view less"),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    } else {
      return Text("");
    }
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
                                    top: height * (10 / 100),
                                    left: 20,
                                    child: Text(
                                      'View DashBoard',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 48,
                                          fontFamily: 'Alef-Regular'),
                                    )),
                                Positioned(
                                    top: height * (18 / 100),
                                    left: width * (30 / 100),
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
                      top: 200,
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
                                                                (38 / 100),
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
                                                    Container(
                                                      height: height * 0.25,
                                                      width: width * (90 / 100),
                                                      child: makeProductList(),
                                                    ),
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
                                                    Chart(),
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
