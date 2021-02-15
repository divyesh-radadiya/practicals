import 'package:flutter/cupertino.dart';
import 'user.dart';
import 'package:practical1/networking.dart';

class BookmarkedData extends ChangeNotifier {
  List<User> users = [];
  List<User> allUsers = [];
  void getData() async {
    NetworkHelper networkHelper = NetworkHelper('https://api.github.com/users');

    var allData = await networkHelper.getData();
    for (var x in allData) {
      allUsers.add(User(x['login'], x['avatar_url']));
    }
    notifyListeners();
  }

  void add(User user) {
    users.add(user);
    notifyListeners();
  }

  void remove(User user) {
    users.remove(user);
    allUsers[allUsers.indexOf(user)].isChecked = false;
    notifyListeners();
  }
}
