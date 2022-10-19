import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/bloc/product_bloc/product_bloc.dart';

import '../widgets/basic_widgets.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final _productsBloc = ProductsListBloc();
  @override
  void initState() {
    super.initState();
    _productsBloc.add(GetAllProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: ((context) => _productsBloc),
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
