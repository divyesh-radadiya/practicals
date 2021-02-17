import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practical1/models/user_bloc.dart';
import 'loading.dart';
import 'package:hive/hive.dart';
import 'models/userdata.dart';
import 'models/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Tab1 extends StatefulWidget {
  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  ScrollController myScrollController = ScrollController();

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
    return Container(
        child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserLoading) {
        return Loading();
      } else if (state is UserSuccess) {
        return ListView.builder(
          controller: myScrollController,
          itemBuilder: (context, index) {
            String userUrl = state.users[index].avatarUrl;
            String userName = state.users[index].loginName;

            return ListTile(
              leading: CircleAvatar(
                child: CachedNetworkImage(
                  imageUrl: userUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              title: Text(userName),
              trailing: Checkbox(
                  value: state.users[index].isChecked,
                  onChanged: (newValue) {
                    BlocProvider.of<UserBloc>(context, listen: false)
                        .add(ChangeBookmark(index, newValue));
                    if (newValue == true) {
                      final userBox = Hive.box('users');
                      userBox.add(UserData(userName, userUrl));
                    }
                  }),
            );
          },
          itemCount: state.users.length,
        );
      } else {
        return Container();
      }
    }));
  }
}
