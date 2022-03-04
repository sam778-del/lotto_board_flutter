import 'dart:convert';
import 'package:lotto_board/controllers/value.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Strings strings = Strings();

class SubmitOrderService {
  late String id;
  late String user;
  late String card_number;
  late String card_exp_month;
  late String card_exp_year;
  late String status;

  static var client = http.Client();
  Future<dynamic> submitOrderData() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Object? token = prefs.get("token");
      var response = await client.post(Uri.parse(strings.submitOrder += "?id=${id}"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
        body: {
          "id": this.id,
          "user": this.user,
          "card_number": this.card_number,
          "card_exp_month": this.card_exp_month,
          "card_exp_year": this.card_exp_year,
          "status": this.status
        }
      );
      print(response.body);
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