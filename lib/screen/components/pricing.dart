import 'package:lotto_board/controllers/pricing.dart';
import 'package:get/get.dart';

class PricingController extends GetxController{
  var isLoading = true.obs;
  var PricingData = [];

  @override
  void onInit() {
    fetchPricing();
    super.onInit();
  }

  Future<dynamic> fetchPricing() async {
    try{
      isLoading(true);
      var _data = await PricingService.fetchPricingData();
      if(_data != null){
        PricingData = _data;
      }
    }finally{
      Future.delayed(Duration(seconds: 1), () {
        isLoading(false);
      });
    }
  }
}