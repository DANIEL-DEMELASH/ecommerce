// ignore_for_file: must_be_immutable

part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  UserState();

  @override
  List<Object> props = [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;
  UserLoaded(this.user);
}

class UserError extends UserState {
  final String error;
  UserError(this.error);
}
