import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loading.dart';
import 'package:provider/provider.dart';
import 'models/all_user_data.dart';
import 'package:hive/hive.dart';
import 'models/userdata.dart';

class Tab1 extends StatefulWidget {
  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  void initState() {
    super.initState();
    Provider.of<AllUserData>(context, listen: false).getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: (Provider.of<AllUserData>(context).allUsers.length != 0)
            ? DataList()
            : Loading());
  }
}

class DataList extends StatefulWidget {
  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  ScrollController myScrollController = ScrollController();

  void initState() {
    super.initState();
    myScrollController.addListener(() {
      if (myScrollController.position.pixels ==
          myScrollController.position.maxScrollExtent) {
        Provider.of<AllUserData>(context, listen: false).getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Consumer<AllUserData>(
      builder: (context, userData, child) => ListView.builder(
        controller: myScrollController,
        itemBuilder: (context, index) {
          String userUrl = userData.allUsers[index].avatarUrl;
          String userName = userData.allUsers[index].loginName;

          return ListTile(
            leading: CircleAvatar(child: Image(image: NetworkImage(userUrl))),
            title: Text(userName),
            trailing: Checkbox(
                value: userData.allUsers[index].isChecked,
                onChanged: (newValue) {
                  userData.changeBookmark(newValue, index);
                  if (newValue == true) {
                    final userBox = Hive.box('users');
                    userBox.add(UserData(userName, userUrl));
                  }
                }),
          );
        },
        itemCount: userData.allUsers.length,
      ),
    ));
  }
}
