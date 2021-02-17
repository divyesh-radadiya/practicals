import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loading.dart';
import 'package:hive/hive.dart';
import 'models/userdata.dart';
import 'models/user_list.dart';
import 'package:provider/provider.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

class Tab1 extends StatefulWidget {
  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  ScrollController myScrollController = ScrollController();

  void initState() {
    super.initState();
    Provider.of<UserList>(context, listen: false).getData();
    myScrollController.addListener(() {
      if (myScrollController.position.pixels ==
          myScrollController.position.maxScrollExtent) {
        Provider.of<UserList>(context, listen: false).getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<UserList>(context);
    return Observer(builder: (_) {
      if (list.users.isEmpty) {
        return Loading();
      } else {
        return ListView.builder(
          controller: myScrollController,
          itemBuilder: (context, index) {
            String userUrl = list.users[index].avatarUrl;
            String userName = list.users[index].loginName;

            return ListTile(
              leading: CircleAvatar(child: Image(image: NetworkImage(userUrl))),
              title: Text(userName),
              trailing: Observer(
                builder: (_) => Checkbox(
                    value: list.users[index].isChecked,
                    onChanged: (newValue) {
                      Provider.of<UserList>(context, listen: false)
                          .changeBookmark(index, newValue);
                      if (newValue == true) {
                        final userBox = Hive.box('users');
                        userBox.add(UserData(userName, userUrl));
                      }
                    }),
              ),
            );
          },
          itemCount: list.users.length,
        );
      }
    });
  }
}
