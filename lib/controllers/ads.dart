import 'package:lotto_board/controllers/value.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Strings strings = Strings();

class DashboardService {
  static var client = http.Client();
  static Future<dynamic> fetchCarouselData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get("token");
    try{
      var response = await client.get(Uri.parse(strings.checkAds += "?token=${token}"),
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
      return null;
    }
  }
}