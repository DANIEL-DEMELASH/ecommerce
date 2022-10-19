import 'package:flutter/material.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.orange,
              ))),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(
              child: Image.network(
                product.image.toString(),
                height: MediaQuery.of(context).size.height / 3,
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        product.title.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      RatingBar(
                        ignoreGestures: true,
                        initialRating:
                            double.parse(product.rating!.rate.toString()),
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                            full: const Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            half: const Icon(
                              Icons.star_half,
                              color: Colors.orange,
                            ),
                            empty: const Icon(
                              Icons.star_outline,
                              color: Colors.orange,
                            )),
                        onRatingUpdate: (value) => () {},
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text('${product.rating!.count} reviews'),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        product.description.toString(),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.0),
          color: Colors.orange,
        ),
        child: Center(
          child: Text(
            'Add to Cart \$${product.price}',
            style: const TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
