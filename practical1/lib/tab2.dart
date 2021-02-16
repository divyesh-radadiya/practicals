import 'package:flutter/material.dart';
import 'package:practical1/models/userdata.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Tab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
        box: Hive.box('users'),
        builder: (context, userBox) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final user = userBox.getAt(index) as UserData;
              return ListTile(
                  leading: CircleAvatar(
                      child: Image(image: NetworkImage('${user.avatarUrl}'))),
                  title: Text('${user.loginName}'),
                  trailing: IconButton(
                    onPressed: () {
                      userBox.deleteAt(index);
                    },
                    icon: Icon(
                      Icons.clear,
                    ),
                  ));
            },
            itemCount: userBox.length,
          );
        });
  }
}
