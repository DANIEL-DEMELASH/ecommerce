import 'package:flutter/material.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cart_screen.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final _items = <String, Product>{};

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
                widget.product.image.toString(),
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
                        widget.product.title.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      RatingBar(
                        ignoreGestures: true,
                        initialRating: double.parse(
                            widget.product.rating!.rate.toString()),
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
                      Text('${widget.product.rating!.count} reviews'),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        widget.product.description.toString(),
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
      bottomNavigationBar: GestureDetector(
        onTap: () {
          setState(() {
            // final id = Localstore.instance.collection('products').doc().id;
            final item = Product(
              id: widget.product.id,
              title: widget.product.title,
              price: widget.product.price,
              description: widget.product.description,
              category: widget.product.category,
              image: widget.product.image,
              rating: widget.product.rating,
              errorMessage: widget.product.errorMessage,
            );
            item.save();
            _items.putIfAbsent(item.id.toString(), () => item);
            double totalPrice = 0;
            _items.forEach((key, value) {
              totalPrice += value.price!;
            });
            CartScreen.totalPrice = totalPrice;
          });
          Fluttertoast.showToast(
              msg: "product added to the cart",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.orange,
              textColor: Colors.white,
              fontSize: 16.0);
        },
        child: Container(
          height: 50,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.0),
            color: Colors.orange,
          ),
          child: Center(
            child: Text(
              'Add to Cart \$${widget.product.price}',
              style: const TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
