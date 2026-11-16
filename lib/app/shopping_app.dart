import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../core/network/http_api_client.dart';
import '../features/cart/application/cart_bloc.dart';
import '../features/cart/data/cart_repository.dart';
import '../features/navigation/presentation/home_shell.dart';
import '../features/products/data/products_repository.dart';

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductsRepository>(
          create: (_) =>
              ProductsRepository(HttpApiClient(client: http.Client())),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider<CartRepository>(
          create: (_) => const CartRepository(),
        ),
      ],
      child: BlocProvider<CartBloc>(
        create: (context) => CartBloc(context.read<CartRepository>()),
        child: MaterialApp(
          title: 'Shopping App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
            useMaterial3: true,
          ),
          home: const HomeShell(),
        ),
      ),
    );
  }
}
