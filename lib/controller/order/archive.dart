import 'package:ecommercecourse/core/classes/request_status.dart';
import 'package:ecommercecourse/core/functions/handing_data.dart';
import 'package:ecommercecourse/data/datasource/remote/order/archive.dart';
import 'package:ecommercecourse/data/model/order_details.dart';
import 'package:ecommercecourse/view/widgets/auth/logoauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../core/services/services.dart';

class ArchivingOrderController extends GetxController {
  ArchiveOrderData archiveOrderData = ArchiveOrderData(crud: Get.find());
  final AppServices _appServices = Get.find();
  List data = [];
  late RequestStatus requestStatus;
  getArchivedOrders() async {
    requestStatus = RequestStatus.loading;
    update();
    print("status1:$requestStatus");
    var response = await archiveOrderData
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

  postRating(var orderId, var rating, var comment) async {
    var response = await archiveOrderData.postRating(
        orderId.toString(), rating.toString(), comment.toString());
    if (response['status'] == 'success') {
      data.clear();
      getArchivedOrders();
    } else {
      Get.snackbar("Error", "Rating not added");
    }
  }
  // deleteOrder(var orderId) async {
  //   print("status1:$requestStatus");
  //   try {
  //     var response = await archiveOrderData.deleteData(orderId.toString());
  //     if (response['status'] == 'success') {
  //       data.clear();
  //       getArchivedOrders();
  //       Get.snackbar("Success", "order deleted");
  //       update();
  //     } else {
  //       Get.snackbar("Error", "order not deleted");
  //       update();
  //     }
  //   } catch (e) {
  //     print("error in deleting order: $e");
  //   }

  //   print("status2:$requestStatus");
  // }

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
    getArchivedOrders();
  }

  ratingDialog(var orderId) {
    final _dialog = RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: Text(
        'Rate Your Order',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        'Tap a star to set your rating. Add more description here if you want.',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      // your app's logo?
      image: const LogoAuth(),
      submitButtonText: 'Submit',
      commentHint: 'Set your custom comment hint',
      onCancelled: () {},
      onSubmitted: (response) async {
        await postRating(orderId, response.rating, response.comment);
      },
    );

    return Get.dialog(_dialog, barrierDismissible: true);
  }

  @override
  void onInit() {
    getArchivedOrders();
    super.onInit();
  }
}
