import 'package:hive/hive.dart';

part 'userdata.g.dart';

@HiveType(typeId: 0)
class UserData {
  UserData({this.loginName, this.avatarUrl, this.isChecked = false});

  @HiveField(0)
  final String loginName;

  @HiveField(1)
  final String avatarUrl;

  @HiveField(2)
  final bool isChecked;
}
