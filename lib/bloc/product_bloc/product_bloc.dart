import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/product.dart';
import '../../resources/api_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductsListBloc extends Bloc<ProductsListEvent, ProductsListState> {
  ProductsListBloc() : super(ProductsListInitial()) {
    final apiRepository = ApiRepository();
    on<GetAllProducts>(
      (event, emit) async {
        try {
          emit(ProductsListLoading());
          final List<Product> products = await apiRepository.getAllProducts();
          emit(ProductsListLoaded(products));
          if (products[0].errorMessage != null) {
            emit(ProductsListError(products[0].errorMessage.toString()));
          }
        } on NetworkError {
          emit(ProductsListError(
              'failed to fetch data. is your device online?'));
        }
      },
    );

    // on<GetAllProducts>(
    //   (event, emit) async {
    //     try {
    //       emit(ProductsListLoading());
    //       final products = await apiRepository.getAllProducts();
    //       emit(ProductsListLoaded(products));
    //     } on NetworkError {
    //       emit(ProductsListError(
    //           'failed to fetch data. is your device online?'));
    //     }
    //   },
    // );
  }
}
