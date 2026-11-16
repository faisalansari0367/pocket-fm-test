import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/products_bloc.dart';
import '../data/products_repository.dart';
import 'products_view.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsBloc(context.read<ProductsRepository>())
            ..add(const ProductsRequested()),
      child: const ProductsView(),
    );
  }
}
