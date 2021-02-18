import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:practical1/models/user_bloc.dart';

import 'loading.dart';
import 'models/user_bloc.dart';
import 'models/userdata.dart';

class Tab1 extends StatefulWidget {
  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  ScrollController myScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context, listen: false).add(GetData());
    myScrollController.addListener(() {
      if (myScrollController.position.pixels ==
          myScrollController.position.maxScrollExtent) {
        BlocProvider.of<UserBloc>(context, listen: false).add(GetData());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: BlocBuilder<UserBloc, UserState>(
        builder: (BuildContext context, UserState state) {
      if (state is UserLoading) {
        return Loading();
      } else if (state is UserSuccess) {
        return ListView.builder(
          controller: myScrollController,
          itemBuilder: (BuildContext context, int index) {
            final String userUrl = state.users[index].avatarUrl;
            final String userName = state.users[index].loginName;

            return ListTile(
              leading: CircleAvatar(
                child: CachedNetworkImage(
                  imageUrl: userUrl,
                  placeholder: (BuildContext context, String url) =>
                      const CircularProgressIndicator(),
                  errorWidget:
                      (BuildContext context, String url, dynamic error) =>
                          const Icon(Icons.error),
                ),
              ),
              title: Text(userName),
              trailing: Checkbox(
                  value: state.users[index].isChecked,
                  onChanged: (bool newValue) {
                    BlocProvider.of<UserBloc>(context, listen: false)
                        .add(ChangeBookmark(index, newValue));
                    final Box<dynamic> userBox = Hive.box('users');
                    if (newValue == true) {
                      userBox.add(
                          UserData(loginName: userName, avatarUrl: userUrl));
                    }
                    if (newValue == false) {
                      for (int i = 0; i < userBox.length; i++) {
                        final UserData user = userBox.getAt(i) as UserData;
                        if (user.loginName == userName) {
                          userBox.deleteAt(i);
                          break;
                        }
                      }
                    }
                  }),
            );
          },
          itemCount: state.users.length,
        );
      } else if (state is UserFail) {
        return Container(
          child: const Center(child: Text('Fail to load!!!')),
        );
      } else {
        return Container(
          child: const Center(child: Text('Some error!!!')),
        );
      }
    }));
  }
}
