import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/EditScreen.dart';
import 'package:flutter_auth/network_utils/api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  final String url;
  const UserPage({Key key, this.url}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String name, email, number;
 int id;
  Widget _submitButton() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          new Column(
            children: <Widget>[
              SizedBox(
                height: 12.0,
              ),
              SizedBox(
                  width: 150.0,
                  height: 50.0,
                  child: TextButton(
                    child: Text("Edit",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white)
                    ),
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.black),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.black),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.black),
                            )
                        )
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => EditScreen()
                        ),
                      );
                    },
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
print(widget.url);
    //url="data:image/jpeg;base64,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";
    return new Scaffold(
        body: new Container(
          color: Colors.black,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 20.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),

                        ],
                      )),
                  SizedBox(
                      height: 20.0,
                      child: Text('$name',
                        style: TextStyle(fontSize: 20,
                            color: Colors.white),)
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: new Stack(fit: StackFit.loose, children: <Widget>[
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            width: 140.0,
                            height: 140.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                image: new NetworkImage(widget.url),
                                fit: BoxFit.cover,
                              ),
                            ),

                          ),
                          SizedBox(
                            height: 190.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        child: new Stack(fit: StackFit.loose,
                            children: <Widget>[
                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 90.0, right: 100.0),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  )
                              ),
                            ]
                        ),
                      )
                    ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 50.0,
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: FaIcon(
                                                FontAwesomeIcons.user,
                                                size: 24,),
                                            ),

                                            TextSpan(
                                              text: " Name: $name",
                                              style: TextStyle(fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          ),

                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: FaIcon(
                                                FontAwesomeIcons.envelope,
                                                size: 24,),
                                            ),
                                            TextSpan(
                                              text: " Email: $email",
                                              style: TextStyle(fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: FaIcon(
                                                  FontAwesomeIcons.phoneAlt,
                                                  size: 24),
                                            ),
                                            TextSpan(
                                              text: " Phone: $number",
                                              style: TextStyle(fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                          _submitButton()
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),

        )

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
        id=user['id'];
        name = user['name'];
        email = user['email'];
        number = user['phone'].toString();
      });

    }
  }

}