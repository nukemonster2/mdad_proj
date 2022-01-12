import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/EmployeeDetails.dart';
import 'package:flutter_auth/network_utils/api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';



class EmployeeList extends StatefulWidget {
  const EmployeeList({Key key}) : super(key: key);
  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  String name;
  var list, details,pop,userData;
  final _formKey = GlobalKey<FormState>();
  Icon customIcon = const Icon(Icons.search,color: Colors.black,);
  Widget customSearchBar = const Text('Search Bar');
  var query;

  @override
  Widget build(BuildContext context) {
    if(userData!=null){
    if(userData['RoleID']==11){
    return Scaffold(
        appBar: AppBar(
          title: customSearchBar,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: [
            SizedBox(
                height: 20,
                width: 100,
                child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            style: const TextStyle(
                                color: Color(0xFF000000)),
                            cursorColor: const Color(0xff000000),
                            keyboardType: TextInputType.text,
                            validator: (queryValue) {
                              if (queryValue.isEmpty) {
                                return 'Please enter email';
                              }
                              setState(() {
                                query = queryValue;
                              });
                              return null;
                            },
                          ),
                        ])
                )),
            IconButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _searchEmployee(query);
                }
              },
              icon: customIcon,

            )
          ],
          centerTitle: true,
        ),
        body: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    flex: 3,
                    child: ClipRect(
                        child: Align(
                            alignment: Alignment.topCenter,
                            heightFactor: 0.5,
                            child: ListView.builder(
                            itemCount: 1,
                              itemBuilder: (context, pageNumber) {
                                return KeepAliveFutureBuilder (
                                  future: this._fetchPage(pageNumber, list?.length),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                      case ConnectionState.waiting:
                                      return SizedBox(
                                        height: MediaQuery.of(context).size.height * 2,
                                        child: Align(
                                            alignment: Alignment.topCenter,
                                            child: CircularProgressIndicator()
                                        ),
                                      );
                                      case ConnectionState.done:
                                        if (snapshot.hasError) {
                                          print(snapshot.error);
                                          return Text('');
                                        } else {

                                            var pageData = snapshot.data;
                                            return this._buildPage(pageData);
                                        }
                                    }
                                    return SizedBox();
                                  },
                                );
                              }
))))
              ]
          ),));}
    else {
      return ListTile(
        title: Text(userData['name']),
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => EmployeeDetails(name: userData['name'])
            ),
          );
        },
      );
    }
    }
    else{
      return SizedBox(
        height: MediaQuery.of(context).size.height * 2,
        child: Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator()
        ),
      );
    }
  }


   _fetchPage(int pageNumber, int pageSize) async {
    await Future.delayed(Duration(seconds: 1));
    return List.generate(pageSize, (index) {
      return {
        'name': list[index]['name'],
      };
    });
  }
 Widget _buildPage(List page) {
    return ListView(
        shrinkWrap: true,
        primary: false,
        children: page.map((productInfo) {

          return ListTile(
            title: Text(productInfo['name']),
            onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => EmployeeDetails(name:productInfo['name'])
                ),
              );
            },
          );
        }).toList()
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
        userData=user;
        name = user['name'];
      });
      print('UserData: $userData');
    }
    if (user['RoleID'] == 11) {
      var data = {
        'name': user['name'],
        // 'name' : 'John Henry',
      };
      var res = await Network().authData2(data, '/employees');
      var body = json.decode(res.body);
      //print(body);
      setState(() {
        list = body['list'];
      });
    }

  }
    void _searchEmployee(field) async {
      var data = {
        'name': field,
      };
      print(data);
      var res = await Network().authData2(data, '/search');
      var body = json.decode(res.body);
      print(body);
      setState(() {
        list = body['results'];
      });
      print(list);
      print(list[0]);
      print(list[0]['name']);
    }
  }



class KeepAliveFutureBuilder extends StatefulWidget {

  final Future future;
  final AsyncWidgetBuilder builder;

  KeepAliveFutureBuilder({
    this.future,
    this.builder
  });

  @override
  _KeepAliveFutureBuilderState createState() => _KeepAliveFutureBuilderState();
}

class _KeepAliveFutureBuilderState extends State<KeepAliveFutureBuilder> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: widget.builder,
    );
  }

  @override
  bool get wantKeepAlive => true;
}