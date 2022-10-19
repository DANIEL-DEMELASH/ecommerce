import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiProvider {
  Future<List<Product>> getProducts() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );
      List<Product> products = (jsonDecode(response.body) as List)
          .map((e) => Product.fromJson(e))
          .toList();
      return products;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
