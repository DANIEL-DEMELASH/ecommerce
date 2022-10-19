import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../resources/api_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  CategoryListBloc() : super(CategoryListInitial()) {
    final apiRepository = ApiRepository();
    on<GetAllCategoies>(
      (event, emit) async {
        try {
          emit(CategoryListLoading());
          final List<String> categories =
              await apiRepository.getAllCategories();
          emit(CategoryListLoaded(categories));
        } on NetworkError {
          emit(CategoryListError(
              'failed to fetch data. is your device online?'));
        }
      },
    );
  }
}
