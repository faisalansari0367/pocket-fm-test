import '../../../core/network/api_exception.dart';
import '../../../core/network/http_api_client.dart';
import 'product.dart';

class ProductsRepository {
  const ProductsRepository(this._apiClient);

  final HttpApiClient _apiClient;

  Future<List<Product>> fetchProducts() async {
    final response = await _apiClient.getJson('products');
    if (response is! List) {
      throw const ApiException('The product response has an invalid format.');
    }

    try {
      return response
          .map((item) {
            if (item is! Map<String, dynamic>) {
              throw const FormatException('A product has an invalid format.');
            }
            return Product.fromJson(item);
          })
          .toList(growable: false);
    } on FormatException catch (error) {
      throw ApiException(
        'The product response contains invalid data.',
        cause: error,
      );
    }
  }

  void dispose() => _apiClient.close();
}
