import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<charts.Series> seriesList;
  static List<charts.Series<Sales, String>> _createRandomData() {
    final random = Random();
    final unit = [
      Sales('Salson1', random.nextInt(1000)),
      Sales('Salson2', random.nextInt(1000)),
      Sales('Salson3', random.nextInt(1000)),
      Sales('Salson4', random.nextInt(1000)),
      Sales('Salson5', random.nextInt(1000)),
    ];
    final totalSale = [
      Sales('Salson1', random.nextInt(1000)),
      Sales('Salson2', random.nextInt(1000)),
      Sales('Salson3', random.nextInt(1000)),
      Sales('Salson4', random.nextInt(1000)),
      Sales('Salson5', random.nextInt(1000)),
    ];
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

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
    );
  }

  @override
  void initState() {
    super.initState();
    seriesList = _createRandomData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.4,
              padding: EdgeInsets.only(top: 0, left: 20, right: 20),
              child: barChart(),
            ),
            Container(
              margin: EdgeInsets.only(left: 50, top: 20),
              height: height * 0.3,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: height * 0.01,
                        width: width * 0.1,
                        color: Colors.blue,
                      ),
                      Container(
                        child: Text("  UNIT"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: height * 0.01,
                        width: width * 0.1,
                        color: Colors.blue.shade100,
                      ),
                      Container(
                        child: Text("  TOTAL SALE"),
                      ),
                    ],
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
