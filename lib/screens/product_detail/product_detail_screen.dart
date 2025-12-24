import 'package:bt_management_flutter/components/app_bar.dart';
import 'package:bt_management_flutter/components/button.dart';
import 'package:bt_management_flutter/core/utils/formatter.dart';
import 'package:bt_management_flutter/data/models/product.dart';
import 'package:bt_management_flutter/data/services/cart_service.dart';
import 'package:bt_management_flutter/screens/cart/cart_screen.dart';
import 'package:bt_management_flutter/screens/checkout/check_out_screen.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: product.name,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.imageUrl.isNotEmpty)
                    Center(
                      child: Image.network(
                        product.imageUrl,
                        height: 250,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image,
                              size: 250, color: Colors.grey);
                        },
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text(product.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text(Formatter.formatter.format(product.price),
                          style: const TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      Text(
                        " | ${product.category}",
                        style: TextStyle(color: Colors.grey[70]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.grey.withOpacity(0.3),
              height: 1,
            ),
            const SizedBox(height: 12),
            ButtonApp(
              title: 'Thêm vào giỏ hàng',
              opTap: () {
                CartService().addProduct(product);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                );
              },
              backgroundColor: Colors.black,
            ),
            const SizedBox(height: 12),
            ButtonApp(
              title: 'Mua ngay',
              opTap: () {
                CartService().addProduct(product);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
