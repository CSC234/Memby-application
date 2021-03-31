import 'package:flutter/material.dart';
import 'package:memby/components/TotalSaleList.dart';
import 'package:memby/components/topCustomer.dart';
import 'package:memby/components/popProduct.dart';
import 'package:memby/components/viewAll.dart';
import 'package:memby/screens/landingScreen.dart';
import '../constants.dart';

List<TotalSaleList> productList = [
  TotalSaleList(
    no: 1,
    name: "Selsun Selenium sulfide1",
    unit: 134,
    totalSale: 1554,
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
List<TopCustomer> popSaleList = [
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

class _DashBoardState extends State<DashBoard> {
  ListView makeProductList() {
    List<TotalSaleList> productHolder = [];
    for (int i = 0; i < productList.length; i++) {
      var p = productList[i];
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

  ListView makeTopCustomerList() {
    List<TopCustomer> customerHolder = [];
    for (int i = 0; i < popSaleList.length; i++) {
      var p = popSaleList[i];
      customerHolder.add(
        TopCustomer(
          no: p.no,
          name: p.name,
          phoneNo: p.phoneNo,
          totalPaid: p.totalPaid,
        ),
      );
    }
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 0),
      children: customerHolder,
    );
  }

  Widget HandleViewAll() {
    print(productList.length);

    if (productList.length > 5) {
      return TextButton(
        child: Text("view all"),
        onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => ViewAll(),
              ));
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
                      height: height * (30 / 100),
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
                                                        HandleViewAll(),
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
                                                      height:
                                                          height * (21 / 100),
                                                      width: width * (90 / 100),
                                                      child: makeProductList(),
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
                                                          Text(
                                                            "Popular Product",
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    PopProduct(),
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
                                                              "Top Customer",
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
                                                          Text(
                                                            "Name",
                                                            style: TextStyle(
                                                                color:
                                                                    kPrimaryFont,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Container(
                                                            width: width *
                                                                (45 / 100),
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
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  "Total Paid",
                                                                  style: TextStyle(
                                                                      color:
                                                                          kPrimaryFont,
                                                                      fontSize:
                                                                          14,
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
                                                      height:
                                                          height * (21 / 100),
                                                      width: width * (90 / 100),
                                                      child:
                                                          makeTopCustomerList(),
                                                    ),
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
