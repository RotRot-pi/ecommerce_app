import 'dart:io';

import 'package:ecommercecourse/core/constants/routes_name.dart';
import 'package:get/get.dart';

abstract class SuccessPasswordResetController extends GetxController {
  goToLogin();
}

class SuccessPasswordResetControllerImpl
    extends SuccessPasswordResetController {
  @override
  goToLogin() {
    Get.toNamed(AppRoutes.login);
  }

  showPopingDialog() async {
    await Get.defaultDialog(
      title: 'are_you_sure_you_want_to_exit_the_app'.tr,
      onConfirm: () => exit(0),
      onCancel: () => Get.back(),
      textConfirm: 'yes'.tr,
      textCancel: 'no'.tr,
    );
  }
}
