import 'package:flutter/cupertino.dart';
import 'user.dart';
import 'package:practical1/networking.dart';

class AllUserData extends ChangeNotifier {
  List<User> allUsers = [];
  void getData() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://api.github.com/users?per_page=12');

    var allData = await networkHelper.getData();
    for (var x in allData) {
      allUsers.add(User(x['login'], x['avatar_url']));
    }
    notifyListeners();
  }

  void changeBookmark(bool newV, int i) {
    allUsers[i].isChecked = newV;
    notifyListeners();
  }
}
