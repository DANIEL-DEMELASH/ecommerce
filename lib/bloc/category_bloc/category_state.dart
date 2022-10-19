// ignore_for_file: must_be_immutable

part of 'category_bloc.dart';

abstract class CategoryListState extends Equatable {
  CategoryListState();

  @override
  List<Object> props = [];
}

class CategoryListInitial extends CategoryListState {}

class CategoryListLoading extends CategoryListState {}

class CategoryListLoaded extends CategoryListState {
  final List<String> categories;
  CategoryListLoaded(this.categories);
}

class CategoryListError extends CategoryListState {
  final String error;
  CategoryListError(this.error);
}
