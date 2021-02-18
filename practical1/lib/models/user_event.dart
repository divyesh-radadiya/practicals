part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetData extends UserEvent {}

class ChangeBookmark extends UserEvent {
  ChangeBookmark({this.index, this.newValue});
  final int index;
  final bool newValue;
}
