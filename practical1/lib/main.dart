import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:practical1/models/user_bloc.dart';
import 'package:practical1/tab1.dart';
import 'package:practical1/tab2.dart';

import 'models/user_bloc.dart';
import 'models/userdata.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory appDocumentDir =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(UserDataAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => UserBloc(),
        child: MaterialApp(
          home: HomePage(),
        ));
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox('users'),
      builder: (BuildContext context, AsyncSnapshot<Box<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return UserPage();
          }
        } else {
          return const Scaffold();
        }
      },
    );
  }
}

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Practical 1'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text('Users'),
                ),
                Tab(
                  child: Text('Bookmarked Users'),
                )
              ],
              indicatorColor: Colors.white,
            ),
          ),
          body: TabBarView(
            children: [Tab1(), Tab2()],
          ),
        ));
  }
}
