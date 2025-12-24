import 'package:bt_management_flutter/components/app_bar.dart';
import 'package:bt_management_flutter/core/utils/formatter.dart';
import 'package:bt_management_flutter/data/models/order.dart';
import 'package:bt_management_flutter/data/services/order_service.dart';
import 'package:bt_management_flutter/screens/order/oder_screen.dart';
import 'package:flutter/material.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  String _statusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.New:
        return "Mới";
      case OrderStatus.PendingStock:
        return "Chờ hàng";
      case OrderStatus.Processing:
        return "Đang xử lý";
      case OrderStatus.Shipping:
        return "Đang giao";
      case OrderStatus.Completed:
        return "Hoàn tất";
      case OrderStatus.Cancelled:
        return "Đã hủy";
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = OrderService().orders;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: 'Danh sách đơn hàng',
      ),
      body: orders.isEmpty
          ? const Center(child: Text("Chưa có đơn hàng nào"))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.grey[100],
                    child: ListTile(
                      title: Text(
                          "Đơn #${order.id} - Khách hàng: ${order.customerName}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text("Tổng tiền: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  Formatter.formatter.format(order.items
                                      .fold<double>(
                                          0,
                                          (t, i) =>
                                              t +
                                              i.product.price * i.quantity)),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                          Text(
                            "Trạng thái: ${_statusText(order.status)}",
                          ),
                        ],
                      ),
                      isThreeLine: true,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderScreen(order: order),
                          ),
                        );
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
