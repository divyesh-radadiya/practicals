import 'package:flutter/material.dart';
import 'package:practical1/models/userdata.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models/user_bloc.dart';

class Tab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('users').listenable(),
        builder: (context, userBox, widget) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final user = userBox.getAt(index) as UserData;
              return ListTile(
                  leading: CircleAvatar(
                      child: Image(image: NetworkImage('${user.avatarUrl}'))),
                  title: Text('${user.loginName}'),
                  trailing: IconButton(
                    onPressed: () {
                      final user = userBox.getAt(index) as UserData;
                      final allUser =
                          BlocProvider.of<UserBloc>(context).allUsers;
                      for (var i = 0; i < allUser.length; i++) {
                        if (user.loginName == allUser[i].loginName) {
                          BlocProvider.of<UserBloc>(context, listen: false)
                              .add(ChangeBookmark(i, false));
                        }
                      }
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
