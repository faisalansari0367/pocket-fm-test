import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/products_bloc.dart';
import 'product_list_tile.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading || state is ProductsInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProductsFailure) {
          return _ProductsError(message: state.message);
        }
        if (state is ProductsLoaded) {
          if (state.products.isEmpty) {
            return const Center(child: Text('No products are available.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return ProductListTile(product: state.products[index]);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _ProductsError extends StatelessWidget {
  const _ProductsError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off_outlined, size: 40),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () {
                context.read<ProductsBloc>().add(const ProductsRequested());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
