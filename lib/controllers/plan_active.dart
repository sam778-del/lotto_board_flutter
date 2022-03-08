import 'dart:convert';
import 'package:lotto_board/controllers/value.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Strings strings = Strings();

class PlanActiveService {
  static var client = http.Client();
  static Future<dynamic> activePlanData() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.get("token");
      var response = await client.get(Uri.parse(strings.activePlan),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }
      );
      if(response.statusCode == 200){
        return json.decode(response.body);
      }else if (response.statusCode == 500){
        await prefs.remove(token);
      }
      return null;
    } catch(e){
      Exception(e);
      return null;
    }
  }
}