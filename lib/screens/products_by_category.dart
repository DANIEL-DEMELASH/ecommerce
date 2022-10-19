import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/bloc/product_bloc/product_bloc.dart';

import '../widgets/basic_widgets.dart';

class ProductByCategoryScreen extends StatefulWidget {
  const ProductByCategoryScreen({super.key, required this.category});
  final String category;

  @override
  State<ProductByCategoryScreen> createState() =>
      _ProductByCategoryScreenState();
}

class _ProductByCategoryScreenState extends State<ProductByCategoryScreen> {
  final _productBloc = ProductsListBloc();
  @override
  void initState() {
    super.initState();
    _productBloc.add(GetProductsByCategory(category: widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              widget.category,
              style: const TextStyle(color: Colors.orange),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.orange,
                ))),
        body: BlocProvider(
          create: ((context) => _productBloc),
          child: BlocListener<ProductsListBloc, ProductsListState>(
            listener: (context, state) {
              if (state is ProductsListError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.error),
                ));
              }
            },
            child: BlocBuilder<ProductsListBloc, ProductsListState>(
                builder: ((context, state) {
              if (state is ProductsListInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProductsListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProductsListLoaded) {
                return displayProducts(state.products, context);
              } else if (state is ProductsListError) {
                return const Center(
                  child: Text('something is wrong'),
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
