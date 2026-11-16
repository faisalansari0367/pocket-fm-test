import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/cart_bloc.dart';
import '../application/cart_state.dart';
import '../data/cart_repository.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({required this.state, super.key});

  final CartState state;

  @override
  Widget build(BuildContext context) {
    final repository = context.read<CartRepository>();
    final itemCount = repository.totalQuantity(state);
    final total = repository.totalPrice(state);
    return SafeArea(  
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Items ($itemCount)'),
                Text('\$${total.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: itemCount == 0 ? null : () => _checkout(context),
                child: const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkout(BuildContext context) {
    final cartBloc = context.read<CartBloc>();
    if (context.read<CartRepository>().totalQuantity(cartBloc.state) == 0) {
      return;
    }

    cartBloc.add(const CartCleared());
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Checkout complete. Your cart is empty.')),
      );
  }
}
