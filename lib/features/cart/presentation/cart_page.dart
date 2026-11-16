import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/cart_state.dart';
import '../application/cart_bloc.dart';
import 'cart_item_tile.dart';
import 'cart_summary.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.items.isEmpty) {
          return const _EmptyCart();
        }

        final items = state.items.values.toList(growable: false);
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return CartItemTile(item: items[index]);
                },
              ),
            ),
            CartSummary(state: state),
          ],
        );
      },
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.remove_shopping_cart_outlined, size: 48),
          SizedBox(height: 12),
          Text('Your cart is empty.'),
        ],
      ),
    );
  }
}
