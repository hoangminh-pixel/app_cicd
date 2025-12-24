import 'package:bt_management_flutter/data/models/cart_item.dart';

enum OrderStatus { New, PendingStock, Processing, Shipping, Completed, Cancelled }

class Order {
  final String id;
  final List<CartItem> items;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String paymentMethod;
  final String shippingMethod;
  OrderStatus status;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.items,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.paymentMethod,
    required this.shippingMethod,
    this.status = OrderStatus.New,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}