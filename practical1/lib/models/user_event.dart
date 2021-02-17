part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetData extends UserEvent {}

class ChangeBookmark extends UserEvent {
  final int index;
  final bool newValue;
  ChangeBookmark(this.index, this.newValue);
}
