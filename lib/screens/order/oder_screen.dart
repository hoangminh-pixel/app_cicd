import 'package:bt_management_flutter/components/app_bar.dart';
import 'package:bt_management_flutter/core/utils/formatter.dart';
import 'package:bt_management_flutter/data/models/order.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  final Order order;
  const OrderScreen({super.key, required this.order});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: 'Chi tiết đơn #${order.id}',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              "Khách hàng: ${order.customerName}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              "SĐT: ${order.customerPhone}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              "Địa chỉ: ${order.customerAddress}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              "Thanh toán: ${order.paymentMethod}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              "Giao hàng: ${order.shippingMethod}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            const Text("Sản phẩm:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            ...order.items.map((item) => ListTile(
                  leading: item.product.imageUrl.isNotEmpty
                      ? Image.network(
                          item.product.imageUrl,
                          width: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image,
                                size: 50, color: Colors.grey);
                          },
                        )
                      : const Icon(Icons.image),
                  title: Text(item.product.name),
                  subtitle: Text(
                      "SL: ${item.quantity} x ${Formatter.formatter.format(item.product.price)}"),
                  trailing: Text(Formatter.formatter
                      .format(item.product.price * item.quantity)),
                )),
            const Divider(),
            Text(
              "Tổng cộng: ${Formatter.formatter.format(order.items.fold<double>(0, (t, i) => t + i.product.price * i.quantity))}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text("Cập nhật trạng thái:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<OrderStatus>(
              value: order.status,
              items: OrderStatus.values.map((s) {
                return DropdownMenuItem(
                  value: s,
                  child: Text(s.toString().split('.').last),
                );
              }).toList(),
              onChanged: (newStatus) {
                if (newStatus != null) {
                  setState(() {
                    order.status = newStatus;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
