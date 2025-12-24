import 'package:bt_management_flutter/components/app_bar.dart';
import 'package:bt_management_flutter/data/models/customer.dart';
import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
 

  void _addCustomer() {
    showDialog(
      context: context,
      builder: (ctx) {
        final nameCtrl = TextEditingController();
        final phoneCtrl = TextEditingController();
        return AlertDialog(
          title: const Text("Thêm khách hàng"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Tên")),
              TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: "SĐT")),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Hủy")),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  customers.add(Customer(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: nameCtrl.text,
                    phone: phoneCtrl.text,
                  ));
                });
                Navigator.pop(ctx);
              },
              child: const Text("Lưu"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:const CommonAppBar(
        title: 'Khách hàng',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCustomer,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (ctx, i) {
          final c = customers[i];
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(c.name),
            subtitle: Text(c.phone),
            onTap: () {
              // chọn khách hàng khi tạo đơn hàng
              // Navigator.pop(context, c);
            },
          );
        },
      ),
    );
  }
}
