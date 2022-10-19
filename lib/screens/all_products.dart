import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/bloc/product_bloc/product_bloc.dart';
import 'package:ecommerce/screens/product_detail.dart';

import '../models/product.dart';

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
            return displayProducts(state.products);
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

  Widget displayProducts(List<Product> products) {
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
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
}
