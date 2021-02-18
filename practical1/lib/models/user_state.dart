part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserFail extends UserState {}

class UserSuccess extends UserState {
  UserSuccess({this.users});

  final List<User> users;
}
