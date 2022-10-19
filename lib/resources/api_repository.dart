import '../models/product.dart';
import '../models/user.dart';
import 'api_provider.dart';

class ApiRepository {
  final _apiProvider = ApiProvider();
  Future<List<Product>> getAllProducts() {
    return _apiProvider.getProducts();
  }

  Future<List<String>> getAllCategories() {
    return _apiProvider.getAllCategories();
  }

  Future<List<Product>> getProductsByCategory(category) {
    return _apiProvider.getProductsByCategory(category);
  }

  Future<User> getUserInfo() {
    return _apiProvider.getUserInfo();
  }
}

class NetworkError extends Error {}
