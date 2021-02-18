import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:practical1/models/user.dart';
import 'package:practical1/models/userdata.dart';
import 'package:practical1/networking.dart';

import 'user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  List<User> allUsers = <User>[];
  int from = 0;

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetData) {
      if (allUsers.isEmpty) {
        yield UserLoading();
      }
      final dynamic allData = await getData(from);
      if (allData == null) {
        yield UserFail();
      } else {
        for_all:
        for (final dynamic x in allData) {
          final Box<dynamic> userBox = Hive.box('users');
          bool isChecked = false;
          from++;
          for (final User i in allUsers) {
            if (i.loginName == x['login']) continue for_all;
          }

          for (int i = 0; i < userBox.length; i++) {
            final UserData user = userBox.getAt(i) as UserData;
            if (user.loginName == x['login']) {
              isChecked = true;
              break;
            }
          }
          allUsers.add(User(
              loginName: x['login'].toString(),
              avatarUrl: x['avatar_url'].toString(),
              isChecked: isChecked));
        }
        yield UserSuccess(users: allUsers);
      }
    }

    if (event is ChangeBookmark) {
      allUsers[event.index].isChecked = event.newValue;
      yield UserSuccess(users: allUsers);
    }
  }
}

dynamic getData(int from) async {
  final NetworkHelper networkHelper =
      NetworkHelper('https://api.github.com/users?per_page=12&since=$from');

  final dynamic allData = await networkHelper.getData();

  return allData;
}
