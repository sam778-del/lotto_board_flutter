import 'package:lotto_board/controllers/ghana_board.dart';
import 'package:get/get.dart';

class GhanaController extends GetxController{
  var isLoading = true.obs;
  var GhanaBoardData = [];
  var totalCount = 0;

  @override
  void onInit() {
    fetchCarousel();
    super.onInit();
  }

  Future<dynamic> fetchCarousel() async {
    try{
      isLoading(true);
      var _data = await GhanaBoardService.fetchGhanaBoardData();
      if(_data != null){
        GhanaBoardData = _data;
      }
    }finally{
      Future.delayed(Duration(seconds: 3), () {
        totalCount = GhanaBoardData.length + 1;
        isLoading(false);
        print('data fetch done');
      });
    }
  }
}