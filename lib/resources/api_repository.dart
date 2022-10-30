import '../models/cart.dart';
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

  Future<Product> getSingleProduct(id) {
    return _apiProvider.getSingleProduct(id);
  }

  Future<User> getUserInfo() {
    return _apiProvider.getUserInfo();
  }

  Future<List<Cart>> getUserCarts() {
    return _apiProvider.getUserCarts();
  }
}

class NetworkError extends Error {}
