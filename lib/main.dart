import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Account%20Creation/Login.dart';
import 'package:flutter_auth/Screens/EmployeeList.dart';
import 'package:flutter_auth/Screens/ForgetPassword.dart';
import 'package:flutter_auth/Screens/Home.dart';
import 'package:flutter_auth/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Login(),
    );
  }
}
