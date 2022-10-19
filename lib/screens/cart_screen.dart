import 'dart:async';

import 'package:ecommerce/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static double totalPrice = 0;
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _db = Localstore.instance;
  final _items = <String, Product>{};

  StreamSubscription<Map<String, dynamic>>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = _db.collection('products').stream.listen((event) {
      setState(() {
        final item = Product.fromJson(event);
        _items.putIfAbsent(item.id.toString(), () => item);
        double totalPrice = 0;
        _items.forEach((key, value) {
          totalPrice += value.price!;
        });
        CartScreen.totalPrice = totalPrice;
      });
    });
    if (kIsWeb) _db.collection('products').stream.asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: _items.keys.length,
          itemBuilder: (context, index) {
            final key = _items.keys.elementAt(index);
            final item = _items[key]!;
            return Column(
              children: [
                ListTile(
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: FractionallySizedBox(
                        widthFactor: 0.2,
                        child: Image(
                          image: NetworkImage(item.image!),
                        ),
                      )),
                  title: Text(
                    item.title!,
                    // style: kLargeTextStyle,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '\$${item.price}',
                      // style: kMediumTextStyle,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      setState(() {
                        item.delete();
                        _items.remove(item.id.toString());
                        double totalPrice = 0;
                        _items.forEach((key, value) {
                          totalPrice += value.price!;
                        });
                        CartScreen.totalPrice = totalPrice;
                      });
                    },
                  ),
                ),
                const Divider()
              ],
            );
          },
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
              'Buy for \$${CartScreen.totalPrice}',
              style: const TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ));
  }
}
