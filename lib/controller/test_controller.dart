import 'package:ecommercecourse/core/classes/request_status.dart';
import 'package:ecommercecourse/core/functions/handing_data.dart';
import 'package:ecommercecourse/data/datasource/remote/test_data.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  TestData testData = TestData(crud: Get.find());
  List data = [];
  late RequestStatus requestStatus;
  getData() async {
    requestStatus = RequestStatus.loading;
    
    var response = await testData.getData();
    requestStatus = handelingData(response);
    
    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
      

      data.addAll(response['data']);
    } else {
      requestStatus;
    }
    update();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
