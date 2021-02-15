import 'package:flutter/material.dart';
import 'package:practical1/bookmarked_data.dart';
import 'package:provider/provider.dart';

class Tab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Consumer<BookmarkedData>(
            builder: (context, userData, child) => ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        // Provider.of<BookmarkedData>(context).add(User(
                        //     '${data[index]['login']}', '${data[index]['avatar_url']}'));
                      },
                      leading: CircleAvatar(
                          child: Image(
                              image: NetworkImage(
                                  '${userData.users[index].avatarUrl}'))),
                      title: Text('${userData.users[index].loginName}'),
                      trailing: Checkbox(
                        value: true,
                        onChanged: (newValue) {
                          if (newValue == false) {
                            userData.remove(userData.users[index]);
                          }
                        },
                      ),
                    );
                  },
                  itemCount: userData.users.length,
                )));
  }
}
