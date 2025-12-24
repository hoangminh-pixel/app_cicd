import 'dart:developer';

import 'package:bt_management_flutter/core/utils/formatter.dart';
import 'package:bt_management_flutter/data/models/product.dart';
import 'package:bt_management_flutter/screens/add_product/add_product.dart';
import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  void _editStock(Product product) {
    final controller = TextEditingController(text: product.stock.toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Cập nhật tồn kho - ${product.name}"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Số lượng tồn"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Hủy"),
          ),
          ElevatedButton(
            onPressed: () {
              final newStock = int.tryParse(controller.text);
              if (newStock != null) {
                setState(() {
                  product.stock = newStock;
                });
              }
              Navigator.pop(ctx);
            },
            child: const Text("Lưu"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: const CommonAppBar(
      //   title: 'Quản lý tồn kho',
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProduct()),
          );
          setState(() {});
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: mockProducts.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final product = mockProducts[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    color: Colors.grey[100],
                    child: ListTile(
                      leading: product.imageUrl.isNotEmpty
                          ? Image.network(
                              product.imageUrl,
                              width: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.image,
                                    size: 50, color: Colors.grey);
                              },
                            )
                          : const Icon(Icons.image),
                      title: Text(product.name),
                      subtitle: Text(
                          "Giá: ${Formatter.formatter.format(product.price)}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("SL: ${product.stock}"),
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _editStock(product);
                                log('message');
                              }),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
