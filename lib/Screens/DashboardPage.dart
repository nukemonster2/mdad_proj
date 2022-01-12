import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var name;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child:Text('Welcome ${name}')
      ),
    );
  }

@override
void initState() {
  _loadUserData();
  super.initState();
}

_loadUserData() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var user = jsonDecode(localStorage.getString('user'));
  if (user != null) {
    setState(() {
      name = user['name'];
    });
  }
}
}
