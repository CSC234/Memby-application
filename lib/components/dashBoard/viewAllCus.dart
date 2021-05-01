import 'package:flutter/material.dart';
import 'package:memby/components/dashBoard/TotalSaleList.dart';
import 'package:memby/components/chart.dart';
import 'package:memby/components/publicComponent/emptyItem.dart';
import 'package:memby/components/dashBoard/topCustomer.dart';
import '../../constants.dart';
import 'package:memby/screens/dashBoard/viewDashboard.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';
import 'dart:collection';

class ViewCustomer extends StatefulWidget {
  @override
  final bool clickDaily;
  final bool clickMonthly;
  final bool clickYearly;
  final Function handleClickChangeToggleDaily;
  final Function handleClickChangeToggleMonthly;
  final Function handleClickChangeToggleYearly;
  final String startDate;
  const ViewCustomer(
      {Key key,
      this.clickDaily,
      this.clickMonthly,
      this.clickYearly,
      this.handleClickChangeToggleMonthly,
      this.handleClickChangeToggleDaily,
      this.handleClickChangeToggleYearly,
      this.startDate})
      : super(key: key);
  _ViewCustomerState createState() => _ViewCustomerState();
}

List<TotalSaleList> render = [];
List<TotalSaleList> renderFilter = [];

String isRender;

class _ViewCustomerState extends State<ViewCustomer> {
  
  Future _customerSummary;

  var _filterText = TextEditingController();
  
  String startDate;

  bool clickDaily = false;
  bool clickMonthly = true;
  bool clickYearly = true;

  @override
  void initState() {
    super.initState();
    clickDaily = widget.clickDaily;
    clickMonthly = widget.clickMonthly;
    clickYearly = widget.clickYearly;
    startDate = widget.startDate;
    _customerSummary =
        context.read<FlutterFireAuthService>().getCustomerSummary(startDate);
    
  }

  void handleClickChangeToggleDaily() {
    setState(() {
      clickDaily = false;
      clickMonthly = true;
      clickYearly = true;
      startDate = 'd';
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
      _customerSummary =
          context.read<FlutterFireAuthService>().getCustomerSummary(startDate);
      ;
    });
  }

  void handleClickChangeToggleYearly() {
    setState(() {
      clickDaily = true;
      clickMonthly = true;
      clickYearly = false;
      startDate = 'y';
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
    List<TopCustomer> renderFilter = customerHolder
        .where((el) =>
            el.name.indexOf(_filterText.text) != -1 || _filterText.text.isEmpty)
        .toList();
    customerHolder = renderFilter;
    return Column(
      children: customerHolder,
    );
    
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
                                                              "All customer",
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

                                                    FutureBuilder(
                                                        future:
                                                            _customerSummary,
                                                        builder: (context,
                                                            snapshot) {
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
