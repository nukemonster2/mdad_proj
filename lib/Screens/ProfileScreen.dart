import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Account%20Creation/ProfileMenu.dart';
import 'package:flutter_auth/Screens/Account%20Creation/Login.dart';
import 'package:flutter_auth/Screens/UserPage.dart';
import 'package:flutter_auth/network_utils/api.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",
            style: TextStyle(color: Color(0xff000000))),
        backgroundColor:Color(0xFFFFFFFF),

      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            ProfileMenu(
                icon: LineAwesomeIcons.user_shield,
                text: "My Account",
                press: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>
                          UserPage(url:url))
                  )
                }
            ),
            ProfileMenu(
              text: "Log Out",
              icon: LineAwesomeIcons.alternate_sign_out,
              press: () {
                logout();
              },
            ),
          ],
        ),
      ),
    );
  }
  void initState() {
    _getUrl();
    super.initState();

  }
  void logout() async{
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>Login()));
    }
  }
  _getUrl() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    var data={
      'id':user['id'],
    };

    var res = await Network().authData2(data, '/getimg');
    var body = json.decode(res.body);

    setState(() {
      url=body['url'];
    });

  }
}
