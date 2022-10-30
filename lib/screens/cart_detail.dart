import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/product.dart';
import 'package:http/http.dart' as http;

class CartDetail extends StatelessWidget {
  const CartDetail({super.key, required this.cart});
  final Cart cart;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          child: MaterialButton(
            onPressed: () {},
            color: Colors.orange,
            child: const Text('Order'),
          )),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.orange,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                color: Colors.orange,
              ))
        ],
        elevation: 0,
        title: const Text(
          'Cart Products',
          style: TextStyle(color: Colors.orange),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: cart.products!.length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  FutureBuilder(
                      future: getProduct(cart.products![index].productId),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Image.network(
                                snapshot.data!.image.toString(),
                                height: 150,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                snapshot.data!.title.toString(),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text('\$${snapshot.data!.price.toString()}'),
                            ],
                          );
                        }
                        return Container(
                          color: Colors.red,
                        );
                      })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Quantity'),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.remove)),
                          Text(cart.products![index].quantity.toString()),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.add)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  Future<Product> getProduct(id) async {
    http.Response response;
    try {
      response =
          await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));
      final Product product = Product.fromJson(jsonDecode(response.body));
      return product;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
