// ignore_for_file: must_be_immutable

part of 'product_bloc.dart';

abstract class ProductsListEvent extends Equatable {
  ProductsListEvent();
  @override
  List<Object> props = [];
}

class GetAllProducts extends ProductsListEvent {}

class GetSingleProduct extends ProductsListEvent {
  final int id;

  GetSingleProduct({required this.id});
}
