import 'package:ecommercecourse/core/constants/routes_name.dart';
import 'package:ecommercecourse/core/services/services.dart';
import 'package:get/get.dart';

abstract class SettingsController extends GetxController {
  logout();
  goToAddress();
  goToOrders();
  goToArchive();
}

class SettingsControllerImpl extends SettingsController {
  final AppServices _appServices = Get.find();
  bool isNotificationEnabled = false;

  enableNotification(bool val) {
    //unsubscribe to notifications
    //or
    //subscribe to notifications
    isNotificationEnabled = val;
    update();
  }

  @override
  logout() {
    _appServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoutes.language);
  }

  @override
  goToAddress() {
    Get.toNamed(AppRoutes.address);
  }

  @override
  goToOrders() {
    Get.toNamed(AppRoutes.pendingOrders);
  }

  @override
  goToArchive() {
    Get.toNamed(AppRoutes.archiveOrders);
  }
}
