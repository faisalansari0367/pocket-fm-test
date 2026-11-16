import '../../products/data/product.dart';
import '../application/cart_item.dart';
import '../application/cart_state.dart';

class CartRepository {
  const CartRepository();

  CartState addProduct(CartState state, Product product) {
    final existingItem = state.items[product.id];
    final updatedItems = Map<int, CartItem>.of(state.items)
      ..[product.id] = CartItem(
        product: product,
        quantity: (existingItem?.quantity ?? 0) + 1,
      );
    return CartState(items: updatedItems);
  }

  CartState incrementProduct(CartState state, int productId) {
    final item = state.items[productId];
    if (item == null) return state;

    final updatedItems = Map<int, CartItem>.of(state.items)
      ..[productId] = CartItem(
        product: item.product,
        quantity: item.quantity + 1,
      );
    return CartState(items: updatedItems);
  }

  CartState decrementProduct(CartState state, int productId) {
    final item = state.items[productId];
    if (item == null) return state;

    final updatedItems = Map<int, CartItem>.of(state.items);
    if (item.quantity == 1) {
      updatedItems.remove(productId);
    } else {
      updatedItems[productId] = CartItem(
        product: item.product,
        quantity: item.quantity - 1,
      );
    }
    return CartState(items: updatedItems);
  }

  CartState removeProduct(CartState state, int productId) {
    if (!state.items.containsKey(productId)) return state;
    final updatedItems = Map<int, CartItem>.of(state.items)..remove(productId);
    return CartState(items: updatedItems);
  }

  CartState clear(CartState state) =>
      state.items.isEmpty ? state : CartState(items: const {});

  int totalQuantity(CartState state) =>
      state.items.values.fold(0, (total, item) => total + item.quantity);

  double totalPrice(CartState state) => state.items.values.fold(
    0,
    (total, item) => total + item.product.price * item.quantity,
  );
}
