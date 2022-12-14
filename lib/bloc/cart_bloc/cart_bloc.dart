import 'package:ecommerce/models/cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../resources/api_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    final apiRepository = ApiRepository();
    on<GetUserCarts>(
      (event, emit) async {
        try {
          emit(CartLoading());
          final List<Cart> carts = await apiRepository.getUserCarts();
          emit(CartLoaded(carts));
          if (carts[0].errorMessage != null) {
            emit(CartError(carts[0].errorMessage.toString()));
          }
        } on NetworkError {
          emit(CartError('failed to fetch data. is your device online?'));
        }
      },
    );

    on<DeleteCartById>(
      (event, emit) async {
        late Cart cart;
        try {
          emit(CartLoading());
          await Future.delayed(const Duration(seconds: 3), () async {
            cart = await apiRepository.deleteCartById(event.id);
          });
          emit(CartDeleted(cart));
          if (cart.errorMessage != null) {
            emit(CartError(cart.errorMessage.toString()));
          }
        } on NetworkError {
          emit(CartError('failed to fetch data. is your device online?'));
        }
      },
    );
  }
}
