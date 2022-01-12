import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network{
  //final String _url = 'http://localhost:8000/api';
  final String _url = 'http://192.168.1.59:8000/api';
  //final String _url = 'http://172.30.69.41:8000/api';
  //if you are using android studio emulator, change localhost to 10.0.2.2
  String token1,token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token')).toString();
    print("Token is : " +token);
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token',
    'X-Requested-With': 'XMLHttpRequest'
  };

  authData(data, apiUrl) async {
    var fullUrl = Uri.parse(_url + '/v1'+apiUrl);
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  getData(apiUrl) async {
    var fullUrl = Uri.parse(_url + '/v1' + apiUrl);
    await _getToken();
    return await http.get(
        fullUrl,
        headers: _setHeaders()
    );
  }


  authData1(data, apiUrl) async {
    var fullUrl = Uri.parse(_url + '/password'+apiUrl);
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  getData1(apiUrl) async {
    var fullUrl =  Uri.parse(_url+'/password'+ apiUrl);
    await _getToken();
    return await http.get(
        fullUrl,
        headers: _setHeaders()
    );
  }

  getData2(apiUrl) async {
    var fullUrl =  Uri.parse(_url + apiUrl);
    await _getToken();
    return await http.get(
        fullUrl,
        headers: _setHeaders()
    );
  }

  authData2(data,apiUrl) async {
    var fullUrl=Uri.parse(_url+apiUrl);
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }

  


}