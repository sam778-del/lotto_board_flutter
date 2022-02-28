import 'package:lotto_board/controllers/check-user.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController{
  static var UserName = '';
  static var UserEmail = '';
  static var UserPlan  = '';
  static var ProChat   = '';
  static var UserId = '';

  @override
  void onInit() {
    fetchDOData();
    super.onInit();
  }

  static Future<dynamic> fetchDOData() async {
    try{
      var _data = await checkUser.getUser();
      if(_data != null){
        UserName = _data["name"];
        UserEmail = _data["email"];
        UserPlan  = _data["plan_id"];
        ProChat   = _data["pro_chat"];
        UserId = _data["id"];
      }
    }finally{
      var _data = await checkUser.getUser();
      print(_data);
      print('data fetch done');
    }
  }
}