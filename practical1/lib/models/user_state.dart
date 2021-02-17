part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final List<User> users = [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final List<User> users;
  UserSuccess({this.users});
}
