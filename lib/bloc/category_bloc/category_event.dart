part of 'category_bloc.dart';

abstract class CategoryListEvent extends Equatable {
  CategoryListEvent();
  @override
  List<Object> props = [];
}

class GetAllCategoies extends CategoryListEvent {}
