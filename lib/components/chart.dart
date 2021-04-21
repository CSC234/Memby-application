import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

class Chart extends StatefulWidget {
  @override
  final LinkedHashMap saleSummmary;
  const Chart({Key key, this.saleSummmary}) : super(key: key);
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<charts.Series> seriesList;
  List<charts.Series<Sales, String>> _createRandomData() {
    print('hi');
    print(widget.saleSummmary);
    List<Sales> unit = [];
    List<Sales> totalSale = [];
    int i = 1;
    widget.saleSummmary.forEach((productId, product) {
      unit.add(Sales(
        i.toString(),
        product['unitSale'],
      ));
      totalSale.add(Sales(i.toString(), product['totalSale'].round()));
      i++;
    });
    // final random = Random();
    // final unit = [
    //   Sales('Salson1', random.nextInt(1000)),
    //   Sales('Salson2', random.nextInt(1000)),
    //   Sales('Salson3', random.nextInt(1000)),
    //   Sales('Salson4', random.nextInt(1000)),
    //   Sales('Salson5', random.nextInt(1000)),
    // ];
    // final totalSale = [
    //   Sales('Salson1', random.nextInt(1000)),
    //   Sales('Salson2', random.nextInt(1000)),
    //   Sales('Salson3', random.nextInt(1000)),
    //   Sales('Salson4', random.nextInt(1000)),
    //   Sales('Salson5', random.nextInt(1000)),
    // ];
    return [
      charts.Series<Sales, String>(
        id: 'Sale',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: unit,
      ),
      charts.Series<Sales, String>(
        id: 'Sale',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: totalSale,
      ),
    ];
  }

  barChart(seriesList) {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    seriesList = _createRandomData();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.4,
              padding: EdgeInsets.only(top: 0, left: 20, right: 20),
              child: barChart(seriesList),
            ),
            Container(
              margin: EdgeInsets.only(left: 50, top: 20),
              height: height * 0.3,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                     /*  Container(
                        child: Text("Product No. <-- ย้ายไปไว้ข้างๆ chart ให้หน่อย"),
                      ), */
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Sales {
  final String year;
  final int sales;

  Sales(this.year, this.sales);
}
