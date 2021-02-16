import 'package:hive/hive.dart';

part 'userdata.g.dart';

@HiveType(typeId: 0)
class UserData {
  @HiveField(0)
  final String loginName;

  @HiveField(1)
  final String avatarUrl;

  UserData(this.loginName, this.avatarUrl);
}
