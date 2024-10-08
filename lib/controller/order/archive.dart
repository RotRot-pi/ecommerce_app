import 'package:zingoshop/core/classes/request_status.dart';
import 'package:zingoshop/core/functions/handing_data.dart';
import 'package:zingoshop/data/datasource/remote/order/archive.dart';
import 'package:zingoshop/data/model/order_details.dart';
import 'package:zingoshop/view/widgets/auth/logoauth.dart';
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

    var response = await archiveOrderData
        .getData(_appServices.sharedPreferences.getInt('id')!.toString());
    requestStatus = handelingData(response);

    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
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
    final dialog = RatingDialog(
      initialRating: 1.0,
      title: const Text(
        'Rate Your Order',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      message: const Text(
        'Tap a star to set your rating. Add more description here if you want.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      image: const LogoAuth(),
      submitButtonText: 'Submit',
      commentHint: 'Set your custom comment hint',
      onCancelled: () {},
      onSubmitted: (response) async {
        await postRating(orderId, response.rating, response.comment);
      },
    );

    return Get.dialog(dialog, barrierDismissible: true);
  }

  @override
  void onInit() {
    getArchivedOrders();
    super.onInit();
  }
}
