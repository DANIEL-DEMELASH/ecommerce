import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/user.dart';
import '../../resources/api_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final apiRepository = ApiRepository();
    on<GetUser>(
      (event, emit) async {
        try {
          emit(UserLoading());
          final User user = await apiRepository.getUserInfo();
          emit(UserLoaded(user));
        } on NetworkError {
          emit(UserError('failed to fetch data. is your device online?'));
        }
      },
    );
  }
}
