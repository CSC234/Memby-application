import 'package:memby/models/OrderDetail.dart';
class Order {
  String id;
  List<OrderDetail> orderDetails;

  Order({
    this.id,
    this.orderDetails,
  });
}