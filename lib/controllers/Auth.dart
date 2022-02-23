import 'dart:convert';
import 'package:lotto_board/controllers/User.dart';
import 'package:lotto_board/controllers/value.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Strings strings = Strings();

class Auth {

  late String email;
  late String password;
  var statusCode;
  var body;
  var response;
  Future<dynamic> auth () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse(strings.authUrl),
      headers: {
        "Accept": "application/json",
      },
      body: {
        "email": this.email,
        "password": this.password,
      }
    );

    this.statusCode = response.statusCode;
    this.body = json.decode(response.body);
    return null;
  }

  Future<User> me () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get("token");
    response = await http.get(Uri.parse(strings.meUrl),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
    );
    this.statusCode = response.statusCode;
    this.body = json.decode(response.body);
    Map<String, dynamic> data = json.decode(response.body);
    User user = User();
    user.first_name = data["first_name"];
    user.last_name = data["last_name"];
    user.email = data["email"];
    user.id = data["id"];
    return user;
  }

  Future<dynamic> logout () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get("token");
    response = await http.post(Uri.parse(strings.logoutUrl),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    this.statusCode = response.statusCode;
    this.body = json.decode(response.body);
    if(this.statusCode == 200){
      prefs.remove("token");
    }else{
      throw Exception("Server Error");
    }
  }
}