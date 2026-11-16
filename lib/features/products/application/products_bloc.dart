import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_exception.dart';
import '../data/product.dart';
import '../data/products_repository.dart';

sealed class ProductsEvent {
  const ProductsEvent();
}

class ProductsRequested extends ProductsEvent {
  const ProductsRequested();
}

sealed class ProductsState {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

class ProductsLoaded extends ProductsState {
  const ProductsLoaded(this.products);

  final List<Product> products;
}

class ProductsFailure extends ProductsState {
  const ProductsFailure(this.message);

  final String message;
}

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(this._repository) : super(const ProductsInitial()) {
    on<ProductsRequested>(_onProductsRequested);
  }

  final ProductsRepository _repository;

  Future<void> _onProductsRequested(
    ProductsRequested event,
    Emitter<ProductsState> emit,
  ) async {
    emit(const ProductsLoading());
    try {
      final products = await _repository.fetchProducts();
      emit(ProductsLoaded(products));
    } on ApiException catch (error) {
      emit(ProductsFailure(error.message));
    }
  }
}
