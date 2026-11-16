import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart/application/cart_bloc.dart';
import '../../cart/application/cart_state.dart';
import '../../cart/data/cart_repository.dart';
import '../../cart/presentation/cart_page.dart';
import '../../products/presentation/products_page.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _selectedIndex = 0;

  static const _pages = [ProductsPage(), CartPage()];
  static const _titles = ['Products', 'Cart'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        final cartCount = context.read<CartRepository>().totalQuantity(
          cartState,
        );
        return Scaffold(
          appBar: AppBar(title: Text(_titles[_selectedIndex])),
          body: IndexedStack(index: _selectedIndex, children: _pages),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.storefront_outlined),
                selectedIcon: Icon(Icons.storefront),
                label: 'Products',
              ),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: cartCount > 0,
                  label: Text('$cartCount'),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
                selectedIcon: Badge(
                  isLabelVisible: cartCount > 0,
                  label: Text('$cartCount'),
                  child: const Icon(Icons.shopping_cart),
                ),
                label: 'Cart',
              ),
            ],
          ),
        );
      },
    );
  }
}
