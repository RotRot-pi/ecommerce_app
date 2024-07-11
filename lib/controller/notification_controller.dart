import 'package:ecommercecourse/core/classes/request_status.dart';
import 'package:ecommercecourse/core/functions/handing_data.dart';
import 'package:ecommercecourse/core/services/services.dart';
import 'package:ecommercecourse/data/datasource/remote/notification_data.dart';
import 'package:ecommercecourse/data/model/notification.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  NotificationData notificationData = NotificationData(crud: Get.find());
  final AppServices _appServices = Get.find();
  List data = [];
  late RequestStatus requestStatus;
  getData() async {
    requestStatus = RequestStatus.loading;
    update();
    print("status1:$requestStatus");
    var response = await notificationData
        .getData(_appServices.sharedPreferences.getInt('id'));
    requestStatus = handelingData(response);
    print("status2:$requestStatus");
    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
      print("response:$response ");
      for (var i = 0; i < response['data'].length; i++) {
        data.add(Notifications.fromMap(response['data'][i]));
      }
    } else {
      requestStatus;
    }
    update();
  }

  // isEnlish() {
  //   bool isEn =
  //       _appServices.sharedPreferences.getString('lang') == 'en' ? true : false;
  //   return isEn;
  // }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
