import 'package:bt_management_flutter/data/models/order.dart';

class OrderService {
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();

  final List<Order> _orders = [];
  List<Order> get orders => _orders;

  void addOrder(Order order) {
    _orders.add(order);
  }

  void updateStatus(String orderId, OrderStatus status) {
    final order = _orders.firstWhere((o) => o.id == orderId);
    order.status = status;
  }
}
