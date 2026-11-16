import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../products/data/product.dart';
import '../application/cart_bloc.dart';
import '../application/cart_state.dart';

class CartQuantityControl extends StatelessWidget {
  const CartQuantityControl({
    required this.product,
    this.compact = false,
    this.fullWidth = false,
    super.key,
  });

  final Product product;
  final bool compact;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartBloc, CartState, int>(
      selector: (state) => state.items[product.id]?.quantity ?? 0,
      builder: (context, quantity) {
        if (quantity == 0) {
          return SizedBox(
            width: fullWidth ? double.infinity : null,
            child: FilledButton.icon(
              onPressed: () {
                context.read<CartBloc>().add(CartProductAdded(product));
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: Text(compact ? 'Add' : 'Add to cart'),
            ),
          );
        }

        return Row(
          mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: fullWidth
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            IconButton(
              tooltip: 'Decrease ${product.title} quantity',
              onPressed: () {
                context.read<CartBloc>().add(CartItemDecremented(product.id));
              },
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text(
              '$quantity',
              semanticsLabel: 'Quantity $quantity',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            IconButton(
              tooltip: 'Increase ${product.title} quantity',
              onPressed: () {
                context.read<CartBloc>().add(CartItemIncremented(product.id));
              },
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        );
      },
    );
  }
}
