import 'package:cloud_firestore/cloud_firestore.dart';

class UserOrders {
  final String email;
  final String orderState;
  final String total;
  final String userAddress;
  final String userPhoneNumber;
  final String userName;
  final List<OrderItems> orderItems;
  final DateTime orderDate;
  final String orderId;

  UserOrders(
      {required this.email,
      required this.orderId,
      required this.orderDate,
      required this.orderItems,
      required this.orderState,
      required this.total,
      required this.userAddress,
      required this.userName,
      required this.userPhoneNumber});
  factory UserOrders.fromJson(json) => UserOrders(
      email: json["email"],
      orderId: json["orderId"],
      orderItems: (json["orderItems"] as List<dynamic>)
          .map((order) => OrderItems.fromJson(order))
          .toList(),
      orderState: json["orderstate"],
      total: json["total"],
      userAddress: json["userAddress"],
      userName: json["userName"],
      userPhoneNumber: json["userPhoneNumber"],
      orderDate: (json["dateOfOrder"] as Timestamp).toDate());
}

class OrderItems {
  final num quantity;
  final num price;
  final String title;
  OrderItems(
      {required this.price, required this.quantity, required this.title});

  factory OrderItems.fromJson(json) => OrderItems(
      price: json["price"], quantity: json["quantity"], title: json["title"]);
}
