import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/EmployeeList.dart';
import 'package:flutter_auth/network_utils/api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmployeeDetails extends StatefulWidget {
  final String name;
  const EmployeeDetails({Key key, this.name}) : super(key: key);

  @override
  _EmployeeDetailsState createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  var results,url;

  @override
  Widget build(BuildContext context) {
    if(url!=null){
      return results == null ? SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height * 2,
        child: Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator()
        ),
      ) : Scaffold(
          body: Container(
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
                        child: Text(results['results']['name'],
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
                                  image: new NetworkImage(url),
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
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
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
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
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
                                                text: " Name: ${results['results']['name']}",
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
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
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
                                                text: " Email: ${results['results']['email']}",
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
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
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
                                                text: " Phone: ${results['results']['phone']}",
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

                            _deleteButton()
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
  else{
    return Text('');
    }
  }
  Widget _deleteButton() {
    if (results['results']['RoleID']==1) {
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
                      child: Align(
                          alignment: Alignment.center,
                          child: Text("Delete",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white)
                          )),
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
                        print('delete');
                        _deleteUser();
                      },
                    )
                )
              ],
            ),
          ],
        ),
      );
    }
    else {
      return SizedBox();
    }
  }

  @override
 void initState()  {
    _loadUserData();
    super.initState();
  }

  _loadUserData() async {
    var data = {
      'name' : widget.name,
    };
    var res = await Network().authData2(data,'/getDetails');
    var body = json.decode(res.body);
    setState(() {
      results=body;
    });
    var data1={
      'id':results['results']['id']
    };
    var res1 = await Network().authData2(data1, '/getimg');
    var body1 = json.decode(res1.body);
  print(body1);
    setState(() {
      url=body1['url'];
    });
    print(url);
  }

  void _deleteUser() async {
    var data = {
      'name': widget.name,
      'phone': results['results']['phone']
    };
    print(data);
    var res = await Network().authData2(data, '/delete');

    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => EmployeeList()
      ),
    );
  }
}
