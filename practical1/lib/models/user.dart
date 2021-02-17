import 'package:mobx/mobx.dart';

part 'user.g.dart';

class User = _User with _$User;

abstract class _User with Store {
  _User(this.loginName, this.avatarUrl, {this.isChecked = false});

  @observable
  String loginName;
  @observable
  String avatarUrl;
  @observable
  bool isChecked;
}
