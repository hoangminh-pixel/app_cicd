import 'package:bt_management_flutter/components/app_bar.dart';
import 'package:bt_management_flutter/components/button.dart';
import 'package:bt_management_flutter/core/utils/formatter.dart';
import 'package:bt_management_flutter/data/services/cart_service.dart';
import 'package:bt_management_flutter/screens/checkout/check_out_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = CartService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: 'Giỏ hàng',
      ),
      body: Column(
        children: [
          if (cart.items.isEmpty) ...[
            const Expanded(child: Center(child: Text("Chưa có đơn hàng nào")))
          ] else ...[
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final item = cart.items[index];
                  return ListTile(
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
                    title: Text(
                      item.product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                        '${Formatter.formatter.format(item.product.price)}x ${item.quantity}',
                        style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                            fontSize: 12)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              cart.updateQuantity(
                                  item.product, item.quantity - 1);
                            });
                          },
                        ),
                        Text("${item.quantity}"),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              cart.updateQuantity(
                                  item.product, item.quantity + 1);
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              cart.removeProduct(item.product);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.3),
                  height: 1,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Tổng tiền:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(Formatter.formatter.format(cart.total),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.orange,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
                const SizedBox(height: 16),
                SafeArea(
                  bottom: true,
                  child: ButtonApp(
                    title: 'Thanh toán',
                    opTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CheckoutScreen()),
                      );
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
