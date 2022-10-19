import '../models/product.dart';
import 'api_provider.dart';

class ApiRepository {
  final _apiProvider = ApiProvider();
  Future<List<Product>> getAllProducts() {
    return _apiProvider.getProducts();
  }

  Future<List<String>> getAllCategories() {
    return _apiProvider.getAllCategories();
  }
}

class NetworkError extends Error {}
