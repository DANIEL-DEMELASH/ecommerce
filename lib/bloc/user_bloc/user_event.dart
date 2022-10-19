// ignore_for_file: must_be_immutable

part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  UserEvent();
  @override
  List<Object> props = [];
}

class GetUser extends UserEvent {}
