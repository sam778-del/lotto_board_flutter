import 'dart:convert';
import 'package:lotto_board/controllers/value.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Strings strings = Strings();

class Password {
  late String email;
  var body;
  var statusCode;
  var response;

  Future<dynamic>changePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? token = prefs.get("token");
    response = await http.post(Uri.parse(strings.changePassword), 
    headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    },
    body: {
      "email": this.email
    }
    );
    this.statusCode = response.statusCode;
    this.body = json.decode(response.body);
    return null;
  }
}