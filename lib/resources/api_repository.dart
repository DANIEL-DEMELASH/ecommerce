import '../models/product.dart';
import 'api_provider.dart';

class ApiRepository {
  final _apiProvider = ApiProvider();
  Future<List<Product>> getAllProducts() {
    return _apiProvider.getProducts();
  }
}

class NetworkError extends Error {}
