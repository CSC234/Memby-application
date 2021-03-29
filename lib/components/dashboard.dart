import 'package:flutter/material.dart';
import 'package:memby/components/TotalSaleList.dart';
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

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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

  Widget HandleViewAll() {
    print(productList.length);

    if (productList.length > 5) {
      return TextButton(
        child: Text("view all"),
        onPressed: () {},
      );
    } else {
      return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
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
                                left: 30,
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
                    top: height * (25 / 100),
                    height: height * (100 / 100),
                    width: width * (100 / 100),
                    child: SizedBox(
                      child: DecoratedBox(
                        child: Column(
                          children: [
                            Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          topNav(
                                            title: 'Daily',
                                          ),
                                          topNav(
                                            title: 'Monthly',
                                          ),
                                          topNav(
                                            title: 'Yearly',
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
                                            Container(
                                              height: height * (21 / 100),
                                              width: width * (90 / 100),
                                              child: makeProductList(),
                                            ),
                                            Divider(
                                              height: 0,
                                              thickness: 1,
                                            ),
                                          ],
                                        )),
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
                    ))
                //
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class topNav extends StatefulWidget {
  topNav({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _topNavState createState() => _topNavState();
}

class _topNavState extends State<topNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: [
      TextButton(
        child: Text(widget.title,
            style: TextStyle(
              color: kPrimaryFont,
              fontSize: 18,
            )),
        onPressed: () {},
      ),
    ]));
  }
}

// Positioned(
//     top: height * (25 / 100),
//     height: height * (100 / 100),
//     width: width * (100 / 100),
//     child: SizedBox(
//       child: DecoratedBox(
//         decoration: const BoxDecoration(
//           color: kPrimaryColor,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),

//       ),
//     )),

//
//             Container(
//               margin:
//                   EdgeInsets.only(left: 30, top: 15, right: 30),
//               child: Stack(
//                 children: [
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       'Total sale',
//                       style: TextStyle(
//                         color: kPrimaryFont,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                   Align(
//                       alignment: Alignment.topRight,
//                       child: TextButton(
//                         child: Text("view all"),
//                         onPressed: () {},
//                       )),
//                 ],
//               ),
//             ),
//             Divider(
//               height: 30,
//               thickness: 2,
//               indent: 20,
//               endIndent: 20,
//             ),
//             Container(
//               margin:
//                   EdgeInsets.only(left: 30, top: 0, right: 30),
//               child: Stack(
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       "Product Name",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: kPrimaryFont,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment(0.30, 0.0),
//                     child: Text(
//                       "Unit Sale",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: kPrimaryFont,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.topRight,
//                     child: Text(
//                       "Total Sale",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: kPrimaryFont,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               child: Column(
//                 children: <Widget>[
//
//                 ],
//               ),
//             ),
//           ],
//         ),
//       )),
//     ),
//   ),
