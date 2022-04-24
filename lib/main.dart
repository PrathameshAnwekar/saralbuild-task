import 'package:flutter/material.dart';
import 'package:task/app_screens/newUserScreen.dart';
import 'package:task/app_screens/userListScreen.dart';
import 'package:task/size_config.dart';
import 'package:task/widgets/initializer.dart';

import './login_screen/login_screen.dart';
void main() {


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.amber,
        scaffoldBackgroundColor: Colors.black
      ),
      home: const LoginScreen(),
      routes: {
        LoginScreen.routeName :(context) => LoginScreen(),
        UserListScreen.routeName :(context) => UserListScreen(),
        NewUserScreen.routeName:(context) =>  NewUserScreen(),
        InitializerWidget.routeName:(context) => InitializerWidget()
      },
    );
  }
}
