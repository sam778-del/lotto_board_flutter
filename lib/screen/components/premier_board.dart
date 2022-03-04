import 'package:lotto_board/controllers/premier_board.dart';
import 'package:get/get.dart';

class PremierController extends GetxController{
  var isLoading = true.obs;
  var PremierBoardData = [];

  @override
  void onInit() {
    fetchPremierData();
    super.onInit();
  }

  Future<dynamic> fetchPremierData() async {
    try{
      isLoading(true);
      var _data = await PremierBoardService.fetchPremierBoardData();
      if(_data != null){
        PremierBoardData = _data;
      }
    }finally{
      Future.delayed(Duration(seconds: 3), () {
        isLoading(false);
      });
      print('data fetch done');
    }
  }
}