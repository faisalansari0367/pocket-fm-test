import 'package:flutter/material.dart';

import '../../cart/presentation/cart_quantity_control.dart';
import '../data/product.dart';
import 'product_details_page.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        height: 216,
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => ProductDetailsPage(product: product),
                    ),
                  );
                },
                child: Row(
                  children: [
                    _ProductImage(imageUrl: product.imageUrl),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              product.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              product.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: CartQuantityControl(product: product, compact: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.image_not_supported_outlined),
            );
          },
        ),
      ),
    );
  }
}
