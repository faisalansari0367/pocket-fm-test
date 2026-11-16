import 'package:flutter/material.dart';

import '../../cart/presentation/cart_quantity_control.dart';
import '../data/product.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product details')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProductHeroImage(imageUrl: product.imageUrl),
                  const SizedBox(height: 24),
                  _ProductInformation(product: product),
                ],
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CartQuantityControl(product: product, fullWidth: true),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductHeroImage extends StatelessWidget {
  const _ProductHeroImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      width: double.infinity,
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.image_not_supported_outlined, size: 48),
          );
        },
      ),
    );
  }
}

class _ProductInformation extends StatelessWidget {
  const _ProductInformation({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.category.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Text(product.title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber),
            const SizedBox(width: 4),
            Text('${product.rating} (${product.ratingCount} reviews)'),
          ],
        ),
        const SizedBox(height: 20),
        Text(product.description, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
