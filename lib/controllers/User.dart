import 'dart:convert';

import 'package:lotto_board/controllers/value.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Strings strings = Strings();

class User {
  late int id;
  late String first_name;
  late String last_name;
  late String email;
  late String phone_number;
  late String password;

  var body;
  var statusCode;
  var response;

  Future<dynamic>createUser () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? token = prefs.get("token");
    var url = Uri.parse(strings.createUserUrl);
    response = await http.post(url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      },
      body: {
        "first_name": this.first_name,
        "last_name": this.last_name,
        "email": this.email,
        "phone_number": this.phone_number,
        "password": this.password
      }
    );
    this.statusCode = response.statusCode;
    this.body = json.decode(response.body);
    return null;
  }

  Future<dynamic>updateUser (int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? token = prefs.get("token");
    var url = Uri.parse("${strings.updateUserUrl}/$id");
    response = await http.put(url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
        body: {
          "first_name": this.first_name,
          "last_name": this.last_name,
          "email": this.email
        }
    );

    this.statusCode = response.statusCode;
    this.body = json.decode(response.body);
    return null;
  }

  Future<dynamic>deleteUser (int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? token = prefs.get("token");
    response = await http.delete(Uri.parse("${strings.createUserUrl}/$id"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
    );

    this.statusCode = response.statusCode;
    this.body = json.decode(response.body);
    return null;
  }
}