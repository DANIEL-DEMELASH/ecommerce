// ignore_for_file: must_be_immutable

part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  CartState();

  @override
  List<Object> props = [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Cart> carts;
  CartLoaded(this.carts);
}

class CartDeleted extends CartState {
  final Cart cart;
  CartDeleted(this.cart);
}

class CartError extends CartState {
  final String error;
  CartError(this.error);
}
