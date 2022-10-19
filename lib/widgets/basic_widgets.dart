import 'package:flutter/material.dart';

import '../models/product.dart';
import '../screens/product_detail.dart';

Widget displayProducts(List<Product> products, BuildContext context) {
  return GridView.count(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: List.generate(products.length, (index) {
        final Product product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetail(product: product)));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            height: MediaQuery.of(context).size.height / 4,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    product.image.toString(),
                    height: MediaQuery.of(context).size.height / 7,
                  ),
                ),
                SizedBox(height: 20.0, child: Text(product.title.toString())),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('\$${product.price}'),
                    Row(
                      children: [
                        Text('${product.rating!.rate}'),
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 15,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }));
}

Widget displayCategories(List<String> categories, BuildContext context) {
  return GridView.count(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: List.generate(categories.length, (index) {
        final String category = categories[index];
        return GestureDetector(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             ProductByCategoryScreen(category: category)));
          },
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              height: MediaQuery.of(context).size.height / 4,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Center(
                  child: Text(
                category,
                style: const TextStyle(fontSize: 20.0),
              ))),
        );
      }));
}
