import 'package:bt_management_flutter/data/models/cart_item.dart';
import 'package:bt_management_flutter/data/models/product.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;

  CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addProduct(Product product) {
    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
  }

  void removeProduct(Product product) {
    _items.removeWhere((i) => i.product.id == product.id);
  }

  void updateQuantity(Product product, int quantity) {
    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      if (quantity <= 0) {
        removeProduct(product);
      } else {
        _items[index].quantity = quantity;
      }
    }
  }

  double get total =>
      _items.fold(0, (sum, item) => sum + item.totalPrice);

  void clear() {
    _items.clear();
  }
}
