import 'package:ecommercecourse/core/classes/request_status.dart';
import 'package:ecommercecourse/core/constants/routes_name.dart';
import 'package:ecommercecourse/core/functions/handing_data.dart';
import 'package:ecommercecourse/data/datasource/remote/order/pending.dart';
import 'package:ecommercecourse/data/model/order_details.dart';
import 'package:get/get.dart';

import '../../core/services/services.dart';

class PendingOrderController extends GetxController {
  PendingOrderData pendingOrderData = PendingOrderData(crud: Get.find());
  final AppServices _appServices = Get.find();
  List data = [];
  late RequestStatus requestStatus;
  getPendingData() async {
    requestStatus = RequestStatus.loading;
    update();
    print("status1:$requestStatus");
    var response = await pendingOrderData
        .getData(_appServices.sharedPreferences.getInt('id')!.toString());
    requestStatus = handelingData(response);
    print("status2:$requestStatus");
    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
      print("response:$response ");

      for (var i = 0; i < response['data'].length; i++) {
        data.add(OrderDetails.fromJson(response['data'][i]));
      }
    } else {
      requestStatus;
    }
    update();
  }

  deleteOrder(var orderId) async {
    print("status1:$requestStatus");
    try {
      var response = await pendingOrderData.deleteData(orderId.toString());
      if (response['status'] == 'success') {
        data.clear();
        getPendingData();
        Get.snackbar("Success", "order deleted");
        update();
      } else {
        Get.snackbar("Error", "order not deleted");
        update();
      }
    } catch (e) {
      print("error in deleting order: $e");
    }

    print("status2:$requestStatus");
  }

  goToOrderTracking(OrderDetails order) {
    Get.toNamed(AppRoutes.orderTracking, arguments: {"order": order});
  }

  printOrderType(var orderType) {
    if (orderType == 0) {
      return 'Delivery';
    } else {
      return 'Receive';
    }
  }

  printPaymentMethod(var paymentType) {
    if (paymentType == 0) {
      return 'Cash';
    } else if (paymentType == 1) {
      return 'Card';
    }
  }

  printOrderStatus(var orderStatus) {
    if (orderStatus == 0) {
      return 'Pending';
    } else if (orderStatus == 1) {
      return 'Accepted';
    } else if (orderStatus == 2) {
      return 'Rejected';
    } else if (orderStatus == 3) {
      return 'Delivered';
    } else {
      return "Archived";
    }
  }

  onNotificationRefresh() {
    getPendingData();
  }

  @override
  void onInit() {
    getPendingData();
    super.onInit();
  }
}
