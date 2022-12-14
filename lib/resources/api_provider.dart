import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/cart.dart';
import '../models/product.dart';
import '../models/user.dart';

class ApiProvider {
  String baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> getProducts() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse('$baseUrl/products'),
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

  Future<List<String>> getAllCategories() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse('$baseUrl/products/categories'),
      );
      final categories =
          (jsonDecode(response.body) as List<dynamic>).cast<String>();
      return categories;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<Product>> getProductsByCategory(category) async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse('$baseUrl/products/category/$category'),
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

  Future<Product> getSingleProduct(id) async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse('$baseUrl/products/$id'),
      );
      Product products = Product.fromJson(jsonDecode(response.body));
      return products;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<User> getUserInfo() async {
    http.Response response;
    try {
      response = await http.get(Uri.parse('$baseUrl/users/2'));
      User user = User.fromJson(jsonDecode(response.body));
      return user;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<Cart>> getUserCarts() async {
    http.Response response;
    try {
      response = await http.get(Uri.parse('$baseUrl/carts/user/3'));
      List<Cart> cart = (jsonDecode(response.body) as List)
          .map((e) => Cart.fromJson(e))
          .toList();
      return cart;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<Cart> deleteCartById(id) async {
    http.Response response;
    try {
      response = await http.get(Uri.parse('$baseUrl/carts/$id'));
      Cart cart = Cart.fromJson(jsonDecode(response.body));
      return cart;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
