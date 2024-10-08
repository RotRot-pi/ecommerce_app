import 'package:flutter/material.dart';
import 'package:zingoshop/core/classes/request_status.dart';
import 'package:zingoshop/core/constants/routes_name.dart';
import 'package:zingoshop/core/functions/handing_data.dart';
import 'package:zingoshop/core/services/services.dart';
import 'package:zingoshop/data/datasource/remote/cart_item_data.dart';
import 'package:zingoshop/data/model/items.dart';

import 'package:get/get.dart';

abstract class ProductDetailsController extends GetxController {}

class ProductDetailsControllerImpl extends ProductDetailsController
    with GetTickerProviderStateMixin {
  late Item item;
  late AnimationController productAnimationController;
  late AnimationController productInfoWidgetAnimationController;
  CartData cartData = CartData(Get.find());

  late RequestStatus requestStatus;

  final AppServices _appServices = Get.find();

  int countitems = 0;

  intialData() async {
    requestStatus = RequestStatus.loading;
    item = Get.arguments['item'];
    countitems = 0;
    requestStatus = RequestStatus.success;
    update();
  }

  addItems(var itemsid) async {
    await cartData.addCart(
        _appServices.sharedPreferences.getInt("id"), itemsid, countitems);
    Get.offAllNamed(AppRoutes.home);
  }

  List subitems = [
    {"name": "red", "id": 1, "active": '0'},
    {"name": "yallow", "id": 2, "active": '0'},
    {"name": "black", "id": 3, "active": '1'}
  ];

  add() {
    countitems++;
    update();
  }

  remove() {
    if (countitems > 0) {
      countitems--;
      update();
    }
  }

  @override
  void onInit() {
    productInfoWidgetAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    productAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    productAnimationController.forward();
    productInfoWidgetAnimationController.forward();

    intialData();

    super.onInit();
  }
}
