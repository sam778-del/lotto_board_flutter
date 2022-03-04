import 'package:lotto_board/controllers/plan_active.dart';
import 'package:get/get.dart';

class PlanActiveController extends GetxController{
  var isLoading = true.obs;
  var PlanName = '';
  var PlanExpiryDate = '';
  

  @override
  void onInit() {
    fetchPricing();
    super.onInit();
  }

  Future<dynamic> fetchPricing() async {
    try{
      isLoading(true);
      var _data = await PlanActiveService.activePlanData();
      if(_data != null){
        PlanName = _data["plan_name"]["name"];
        PlanExpiryDate = _data["plan_expiry_date"];
      }
    }finally{
      Future.delayed(Duration(seconds: 0), () {
        isLoading(false);
      });
      print(PlanExpiryDate);
    }
  }
}