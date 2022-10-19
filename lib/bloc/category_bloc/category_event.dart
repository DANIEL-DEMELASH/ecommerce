// ignore_for_file: must_be_immutable

part of 'category_bloc.dart';

abstract class CategoryListEvent extends Equatable {
  CategoryListEvent();
  @override
  List<Object> props = [];
}

class GetAllCategoies extends CategoryListEvent {}
