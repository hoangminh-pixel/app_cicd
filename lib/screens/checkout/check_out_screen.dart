import 'package:bt_management_flutter/components/app_bar.dart';
import 'package:bt_management_flutter/components/button.dart';
import 'package:bt_management_flutter/data/models/customer.dart';
import 'package:bt_management_flutter/data/models/order.dart';
import 'package:bt_management_flutter/data/services/cart_service.dart';
import 'package:bt_management_flutter/data/services/order_service.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  String customerName = "";
  String customerPhone = "";
  String customerAddress = "";
  String paymentMethod = "Tiền mặt";
  String shippingMethod = "Nhận tại cửa hàng";
  // String customer = "";
  Customer? selectedCustomer;
  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: 'Thanh toán',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Center(
                child: Text("Thông tin khách hàng",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 30),
               const Text("Chọn khách hàng có sẵn,\nhoặc nhập khách hàng mới",
                  ),
              DropdownButtonFormField<Customer>(
                value: selectedCustomer,
                items: customers
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    setState(() {
                      nameCtrl.text = v.name;
                      phoneCtrl.text = v.phone;
                      addressCtrl.text = v.address ?? "";
                      selectedCustomer = v;
                    });
                  }
                },
              ),

              // Họ tên
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Họ tên"),
                validator: (v) => v == null || v.isEmpty ? "Nhập họ tên" : null,
              ),

              // SĐT
              TextFormField(
                controller: phoneCtrl,
                decoration: const InputDecoration(labelText: "Số điện thoại"),
                validator: (v) => v == null || v.isEmpty ? "Nhập SĐT" : null,
              ),

              // Địa chỉ
              TextFormField(
                controller: addressCtrl,
                decoration: const InputDecoration(labelText: "Địa chỉ"),
                validator: (v) =>
                    v == null || v.isEmpty ? "Nhập địa chỉ" : null,
              ),
              const SizedBox(height: 20),
              const Text("Phương thức thanh toán"),
              DropdownButtonFormField<String>(
                value: paymentMethod,
                items: ["Tiền mặt", "Chuyển khoản", "COD"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => paymentMethod = v!),
              ),
              const SizedBox(height: 20),
              const Text("Phương thức vận chuyển"),
              DropdownButtonFormField<String>(
                value: shippingMethod,
                items: ["Nhận tại cửa hàng", "Giao hàng"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => shippingMethod = v!),
              ),
              const SizedBox(height: 30),
              ButtonApp(
                title: 'Thanh toán',
                opTap: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final order = Order(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      items: List.from(cart.items),
                      customerName: customerName,
                      customerPhone: customerPhone,
                      customerAddress: customerAddress,
                      paymentMethod: paymentMethod,
                      shippingMethod: shippingMethod,
                    );

                    // Kiểm tra tồn kho
                    bool enoughStock = true;
                    for (var item in order.items) {
                      if (item.product.stock < item.quantity) {
                        enoughStock = false;
                        break;
                      }
                    }

                    if (enoughStock) {
                      // trừ tồn
                      for (var item in order.items) {
                        item.product.stock -= item.quantity;
                      }
                      order.status = OrderStatus.Processing;
                    } else {
                      order.status = OrderStatus.PendingStock;
                    }

                    OrderService().addOrder(order);
                    cart.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text("Tạo đơn hàng thành công (#${order.id})")),
                    );

                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
