import 'dart:convert';
import 'package:lotto_board/controllers/User.dart';
import 'package:lotto_board/controllers/value.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Strings strings = Strings();

class Logout {
  var statusCode;
  var body;
  var response;
  var token;

    Future<dynamic> logoutUser () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? token = prefs.get("token");
    final response = await http.get(Uri.parse(strings.Logout += "?token=${token}"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    this.statusCode = response.statusCode;
    return null;
  }

}