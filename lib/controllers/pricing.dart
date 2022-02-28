import 'package:lotto_board/controllers/value.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Strings strings = Strings();

class PricingService {
  static var client = http.Client();
  static Future<dynamic> fetchPricingData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? token = prefs.get("token");
    try{
      var response = await client.get(Uri.parse(strings.getPlan += "?token=${token}"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      print(json.decode(response.body));
      if(response.statusCode == 200){
        return json.decode(response.body);
      }
      return null;
    } catch(e){
      return null;
    }
  }
}