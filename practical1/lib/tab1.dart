import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loading.dart';
import 'package:provider/provider.dart';
import 'bookmarked_data.dart';
import 'package:hive/hive.dart';
import 'models/userdata.dart';

class Tab1 extends StatefulWidget {
  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  void initState() {
    super.initState();
    Provider.of<BookmarkedData>(context, listen: false).getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: (Provider.of<BookmarkedData>(context).allUsers.length != 0)
            ? DataList()
            : Loading());
  }
}

class DataList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Consumer<BookmarkedData>(
      builder: (context, userData, child) => ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
                child: Image(
                    image:
                        NetworkImage('${userData.allUsers[index].avatarUrl}'))),
            title: Text('${userData.allUsers[index].loginName}'),
            trailing: Checkbox(
                value: userData.allUsers[index].isChecked,
                onChanged: (newValue) {
                  userData.allUsers[index].isChecked = newValue;
                  if (newValue == true) {
                    final userBox = Hive.box('users');
                    userBox.add(UserData(userData.allUsers[index].loginName,
                        userData.allUsers[index].avatarUrl));

                    userData.add(userData.allUsers[index]);
                  }
                  if (newValue == false) {
                    userData.remove(userData.allUsers[index]);
                  }
                  // setState(() {});
                  userData.allUsers[index].isChecked = newValue;
                }),
          );
        },
        itemCount: userData.allUsers.length,
      ),
    ));
  }
}
