import 'package:memby/models/Product.dart';

class OrderDetail {
  String id;
  Product product;
  int amount;
  OrderDetail({this.amount, this.product, this.id});

  void setAmount(int newAmount) {
    this.amount = newAmount;
  }
}