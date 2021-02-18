class User {
  User({this.loginName, this.avatarUrl, this.isChecked = false});

  final String loginName;
  final String avatarUrl;
  bool isChecked;
}
