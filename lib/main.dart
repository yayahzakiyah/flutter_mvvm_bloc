import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_bloc/bloc/user_bloc.dart';
import 'package:mvvm_bloc/data/api/service/user_service.dart';
import 'package:mvvm_bloc/view/user/add_user_page.dart';
import 'package:mvvm_bloc/view/user/user_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Example',
      theme: ThemeData(
        primarySwatch: Colors.blue
              ),
      initialRoute: '/user',
      routes: {
        '/user': (context) => UserPage(),
        '/add_user': (context) => AddUserPage(),
      },
      home: BlocProvider(
        create: (context) => UserBloc(userService: UserService()),
        child: UserPage(),
      ),
    );
  }
}