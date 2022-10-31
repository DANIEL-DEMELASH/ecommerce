// ignore_for_file: must_be_immutable

part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  CartEvent();
  @override
  List<Object> props = [];
}

class GetUserCarts extends CartEvent {}

class DeleteCartById extends CartEvent {
  final int id;

  DeleteCartById(this.id);
}
