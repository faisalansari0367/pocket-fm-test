import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../products/data/product.dart';
import '../data/cart_repository.dart';
import 'cart_item.dart';
import 'cart_state.dart';

sealed class CartEvent {
  const CartEvent();
}

class CartProductAdded extends CartEvent {
  const CartProductAdded(this.product);

  final Product product;
}

class CartItemIncremented extends CartEvent {
  const CartItemIncremented(this.productId);

  final int productId;
}

class CartItemDecremented extends CartEvent {
  const CartItemDecremented(this.productId);

  final int productId;
}

class CartProductRemoved extends CartEvent {
  const CartProductRemoved(this.productId);

  final int productId;
}

class CartCleared extends CartEvent {
  const CartCleared();
}

class CartBloc extends HydratedBloc<CartEvent, CartState> {
  CartBloc(this._repository) : super(CartState(items: const {})) {
    on<CartProductAdded>(
      (event, emit) => emit(_repository.addProduct(state, event.product)),
    );
    on<CartItemIncremented>(
      (event, emit) =>
          emit(_repository.incrementProduct(state, event.productId)),
    );
    on<CartItemDecremented>(
      (event, emit) =>
          emit(_repository.decrementProduct(state, event.productId)),
    );
    on<CartProductRemoved>(
      (event, emit) => emit(_repository.removeProduct(state, event.productId)),
    );
    on<CartCleared>((event, emit) => emit(_repository.clear(state)));
  }

  final CartRepository _repository;

  @override
  CartState? fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'];
    if (rawItems is! List) {
      throw const FormatException('The saved cart has an invalid format.');
    }

    final items = <int, CartItem>{};
    for (final rawItem in rawItems) {
      if (rawItem is! Map<String, dynamic>) {
        throw const FormatException('A saved cart item has an invalid format.');
      }
      final rawProduct = rawItem['product'];
      final rawQuantity = rawItem['quantity'];
      if (rawProduct is! Map<String, dynamic> ||
          rawQuantity is! num ||
          rawQuantity < 1 ||
          rawQuantity != rawQuantity.toInt()) {
        throw const FormatException('A saved cart item contains invalid data.');
      }

      final product = Product.fromJson(rawProduct);
      if (items.containsKey(product.id)) {
        throw const FormatException('The saved cart contains duplicate items.');
      }
      items[product.id] = CartItem(
        product: product,
        quantity: rawQuantity.toInt(),
      );
    }
    return CartState(items: items);
  }

  @override
  Map<String, Object?> toJson(CartState state) => {
    'items': state.items.values
        .map(
          (item) => {
            'product': item.product.toJson(),
            'quantity': item.quantity,
          },
        )
        .toList(growable: false),
  };
}
