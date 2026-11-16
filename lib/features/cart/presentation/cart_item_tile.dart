import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/cart_bloc.dart';
import '../application/cart_item.dart';
import 'cart_quantity_control.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({required this.item, super.key});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CartProductImage(imageUrl: product.imageUrl),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Remove ${product.title}',
                        onPressed: () {
                          context.read<CartBloc>().add(
                            CartProductRemoved(product.id),
                          );
                        },
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                  Text('\$${product.price.toStringAsFixed(2)} each'),
                  const SizedBox(height: 4),
                  Text(
                    'Line total: \$${(product.price * item.quantity).toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  CartQuantityControl(product: product, compact: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartProductImage extends StatelessWidget {
  const _CartProductImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 96,
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.image_not_supported_outlined);
        },
      ),
    );
  }
}
