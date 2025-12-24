import 'package:bt_management_flutter/components/app_bar.dart';
import 'package:bt_management_flutter/components/button.dart';
import 'package:bt_management_flutter/data/models/product.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String code = "";
  String category = "Trang sức Phong cách Ý";
  double price = 0;
  int stock = 0;
  String imageUrl = "";
  final categories = mockProducts.map((p) => p.category).toSet().toList();

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: 'Thêm sản phẩm mới',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Tên sản phẩm"),
                validator: (v) => v == null || v.isEmpty ? "Nhập tên" : null,
                onSaved: (v) => name = v!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Mã sản phẩm"),
                onSaved: (v) => code = v ?? "",
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Danh mục"),
                value: category,
                items: categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => category = v!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Giá"),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? "Nhập giá" : null,
                onSaved: (v) => price = double.tryParse(v!) ?? 0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Số lượng tồn"),
                keyboardType: TextInputType.number,
                onSaved: (v) => stock = int.tryParse(v ?? "0") ?? 0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Ảnh (URL)"),
                onSaved: (v) => imageUrl = v ?? "",
              ),
              const SizedBox(height: 20),
              ButtonApp(
                title: 'Lưu sản phẩm',
                opTap: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final newProduct = Product(
                      id: mockProducts.length + 1,
                      name: name,
                      category: category,
                      code: code,
                      price: price,
                      stock: stock,
                      imageUrl: imageUrl.isNotEmpty
                          ? imageUrl
                          : "https://via.placeholder.com/150",
                    );

                    mockProducts.add(newProduct);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Thêm sản phẩm thành công")),
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
