import 'package:mobx/mobx.dart';
import 'package:practical1/models/user.dart';
import 'package:practical1/networking.dart';

part 'user_list.g.dart';

class UserList = _UserList with _$UserList;

abstract class _UserList with Store {
  @observable
  ObservableList<User> users = ObservableList<User>();
  @observable
  int from = 0;

  @action
  void getData() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://api.github.com/users?per_page=12&since=$from');

    var allData = await networkHelper.getData();
    for (var x in allData) {
      users.add(User(x['login'], x['avatar_url']));
    }
    from += 12;
  }

  @action
  void changeBookmark(int i, bool newV) {
    users[i].isChecked = newV;
  }
}
