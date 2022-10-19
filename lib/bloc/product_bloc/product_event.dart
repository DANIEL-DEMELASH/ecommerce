// ignore_for_file: must_be_immutable

part of 'product_bloc.dart';

abstract class ProductsListEvent extends Equatable {
  ProductsListEvent();
  @override
  List<Object> props = [];
}

class GetAllProducts extends ProductsListEvent {}

class GetProductsByCategory extends ProductsListEvent {
  final String category;

  GetProductsByCategory({required this.category});
}
