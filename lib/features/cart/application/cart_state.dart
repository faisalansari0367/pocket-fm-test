import 'cart_item.dart';

class CartState {
  CartState({required Map<int, CartItem> items})
    : items = Map.unmodifiable(items);

  final Map<int, CartItem> items;
}
