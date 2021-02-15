import 'package:flutter/material.dart';
import 'package:practical1/tab1.dart';
import 'package:practical1/tab2.dart';
import 'package:provider/provider.dart';
import 'bookmarked_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookmarkedData>(
        create: (context) => BookmarkedData(),
        child: MaterialApp(
          home: HomePage(),
        ));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new AppBar(
            title: Text('Practical 1'),
            bottom: new TabBar(
              tabs: [
                new Tab(
                  child: Text('Users'),
                ),
                new Tab(
                  child: Text('Bookmarked Users'),
                )
              ],
              indicatorColor: Colors.white,
            ),
          ),
          body: new TabBarView(
            children: [Tab1(), Tab2()],
          ),
        ));
  }
}
