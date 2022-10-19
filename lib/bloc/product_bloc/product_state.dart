// ignore_for_file: must_be_immutable

part of 'product_bloc.dart';

abstract class ProductsListState extends Equatable {
  ProductsListState();

  @override
  List<Object> props = [];
}

class ProductsListInitial extends ProductsListState {}

class ProductsListLoading extends ProductsListState {}

class ProductsListLoaded extends ProductsListState {
  final List<Product> products;
  ProductsListLoaded(this.products);
}

class SingleProductLoaded extends ProductsListState {
  final Product product;
  SingleProductLoaded(this.product);
}

class ProductsListError extends ProductsListState {
  final String error;
  ProductsListError(this.error);
}

class SingleProductError extends ProductsListState {
  final String error;
  SingleProductError(this.error);
}
