import 'dart:convert';
import 'package:lotto_board/controllers/value.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Strings strings = Strings();

class GhanaBoardService {
  static var client = http.Client();
  static Future<dynamic> fetchGhanaBoardData() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.get("token");
      var response = await client.get(Uri.parse(strings.ghanaScreen += "?token=${token}"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if(response.statusCode == 200){
        return json.decode(response.body);
      }
      return null;
    } catch(e){
      Exception(e);
      return null;
    }
  }
}