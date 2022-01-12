import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/UserPage.dart';
import 'package:flutter_auth/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  int id;
  String name,email,number;
  String new_name,new_id,new_email,new_number,new_userid;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //uniquely identifies the Form, and allows validation of the form in a later step.


  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Return to My Account',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration:BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Stack(
            children: <Widget>[
              Positioned(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Card(
                              elevation: 4.0,
                              color: Colors.white,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[

                                      TextFormField(
                                        initialValue: name,
                                        style: TextStyle(color: Color(0xFF000000)),
                                        cursorColor: Color(0xFF9b9b9b),
                                        keyboardType: TextInputType.text,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: "Name:",
                                          labelStyle: TextStyle(
                                              color: Color(0xFF9b9b9b),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        validator: (nameValue) {
                                          new_name = nameValue;
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        initialValue: email,
                                        style: TextStyle(color: Color(0xFF000000)),
                                        cursorColor: Color(0xFF9b9b9b),
                                        keyboardType: TextInputType.text,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: "Email:",
                                          labelStyle: TextStyle(
                                              color: Color(0xFF9b9b9b),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        validator: (emailValue) {
                                          if (emailValue.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          new_email = emailValue;
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        initialValue: number,
                                        style: TextStyle(color: Color(0xFF000000)),
                                        cursorColor: Color(0xFF9b9b9b),
                                        keyboardType: TextInputType.text,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Contact Number:',
                                          labelStyle: TextStyle(
                                              color: Color(0xFF9b9b9b),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        validator: (numberValue) {
                                          new_number = numberValue;
                                          return null;
                                        },
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: FlatButton(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 8, bottom: 8, left: 10, right: 10),
                                            child: Text(
                                              _isLoading? 'Proccessing...' : 'Submit',
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          color: Colors.blue,
                                          disabledColor: Colors.grey,
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(20.0)),
                                          onPressed: () {
                                            if (_formKey.currentState.validate()) {
                                              _editUserDetail();
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]
                      )
                  )
              )
            ]
        )
    );
  }




  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    // Build a Form widget using the _formKey created above.
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
                            icon:Icon(Icons.arrow_back_ios),
                            color: Colors.white,
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      )),
                  SizedBox(
                      height:20.0,
                      child:Text('Edit Screen',
                        style: TextStyle(fontSize:20,
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
                                image: new ExactAssetImage(
                                    'assets/images/download.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),

                          ),
                          SizedBox(
                            height:190.0,
                          ),
                        ],
                      ),
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

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  void initState(){
    _loadUserData();
    super.initState();
  }
  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    if(user != null) {
      setState(() {
        name = user['name'];
        id=user['id'];
        email=user['email'];
        number=user['contact_number'];
      });
    }
  }

  void _editUserDetail()async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'id': id,
      'name': new_name,
      'contact_number': new_number,
      'UserID': new_userid,
      'email': new_email,
    };
    print('Data: $data');
    //http://localhost:8000/api/change

    var res = await Network().authData2(data, '/change');
    var body = json.decode(res.body);
    print('Body: $body');
    if(body['status']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var user=localStorage.setString('user', json.encode(body['user']));
      print(localStorage);
      print(user);
      print("works");
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => UserPage()
        ),
      );
    }
    else{
      _showMsg(body['message']);
    }
    setState(() {
      _isLoading = false;
    });

  }
}