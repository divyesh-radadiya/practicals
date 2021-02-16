import 'package:flutter/material.dart';
import 'package:practical1/bookmarked_data.dart';
import 'package:practical1/models/userdata.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'user.dart';

class Tab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox('users'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError)
            return Text(snapshot.error.toString());
          else
            return UserPage();
        } else
          return Scaffold();
      },
    );
  }
}

class UserPage extends StatelessWidget {
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
                  trailing: FlatButton(
                    onPressed: () {
                      userBox.deleteAt(index);
                      Provider.of<BookmarkedData>(context, listen: false)
                          .remove(
                              User('${user.loginName}', '${user.avatarUrl}'));
                    },
                    child: Icon(
                      Icons.clear,
                    ),
                  ));
            },
            itemCount: userBox.length,
          );
        });
  }
}
