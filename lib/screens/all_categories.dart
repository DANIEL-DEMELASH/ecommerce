import 'package:ecommerce/bloc/category_bloc/category_bloc.dart';
// import 'package:fake_store/screens/product_by_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fake_store/product_bloc/products_list_bloc.dart';

import '../widgets/basic_widgets.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  final _categoriesBloc = CategoryListBloc();
  @override
  void initState() {
    super.initState();
    _categoriesBloc.add(GetAllCategoies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: ((context) => _categoriesBloc),
      child: BlocListener<CategoryListBloc, CategoryListState>(
        listener: (context, state) {},
        child: BlocBuilder<CategoryListBloc, CategoryListState>(
            builder: ((context, state) {
          if (state is CategoryListInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CategoryListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CategoryListLoaded) {
            return displayCategories(state.categories, context);
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
