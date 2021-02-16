import 'package:flutter/material.dart';
import 'package:practical1/tab1.dart';
import 'package:practical1/tab2.dart';
import 'package:provider/provider.dart';
import 'models/all_user_data.dart';
import 'models/userdata.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
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
    return ChangeNotifierProvider<AllUserData>(
        create: (context) => AllUserData(),
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
    return DefaultTabController(
        length: 2,
        child: Scaffold(
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
