import 'package:ecommerce/bloc/cart_bloc/cart_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'cart_detail.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _cartsBloc = CartBloc();
  @override
  void initState() {
    super.initState();
    _cartsBloc.add(GetUserCarts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: ((context) => _cartsBloc),
      child: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
            ));
          }
        },
        child: BlocBuilder<CartBloc, CartState>(builder: ((context, state) {
          if (state is CartInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartLoaded) {
            return ListView.builder(
                itemCount: state.categories.length,
                itemBuilder: ((context, index) {
                  final DateFormat formatter = DateFormat('yyyy-MM-dd');
                  final String formatted = formatter
                      .format(DateTime.parse(state.categories[index].date!));
                  return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CartDetail(cart: state.categories[index])));
                      },
                      title: Text('Cart ${state.categories[index].id}'),
                      trailing: Text(
                        formatted,
                      ));
                }));
          } else if (state is CartError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return Container(
              color: Colors.red,
            );
          }
        })),
      ),
    ));
  }
}
