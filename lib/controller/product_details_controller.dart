import 'package:ecommercecourse/core/classes/request_status.dart';
import 'package:ecommercecourse/core/constants/routes_name.dart';
import 'package:ecommercecourse/core/functions/handing_data.dart';
import 'package:ecommercecourse/core/services/services.dart';
import 'package:ecommercecourse/data/datasource/remote/cart_item_data.dart';
import 'package:ecommercecourse/data/model/items.dart';

import 'package:get/get.dart';

abstract class ProductDetailsController extends GetxController {}

class ProductDetailsControllerImpl extends ProductDetailsController {
  late Item item;

  CartData cartData = CartData(Get.find());

  late RequestStatus requestStatus;

  final AppServices _appServices = Get.find();

  int countitems = 0;

  intialData() async {
    requestStatus = RequestStatus.loading;
    item = Get.arguments['item'];
    print("Item:${item.itemsId}");
    print("Item Price:${item.itemsPrice}");
    print("Item Price at Discount:${item.itemsPriceAfterDiscount}");
    countitems = await getCountItems(item.itemsId) ?? 0;
    requestStatus = RequestStatus.success;
    update();
  }

  getCountItems(var itemsid) async {
    requestStatus = RequestStatus.loading;
    var response = await cartData.getCountCart(
        _appServices.sharedPreferences.getInt("id")!, itemsid);
    print("=============================== Controller $response ");
    requestStatus = handelingData(response);
    if (RequestStatus.success == requestStatus) {
      // Start backend
      if (response['status'] == "success") {
        countitems = int.parse(response['data']);
        print("==================================");
        print("$countitems");
        return countitems;
        // data.addAll(response['data']);
      } else {
        requestStatus = RequestStatus.failure;
      }
      update();
    }
  }

  addItems(var itemsid) async {
    requestStatus = RequestStatus.loading;
    update();
    var response = await cartData.addCart(
        _appServices.sharedPreferences.getInt("id"), itemsid, countitems);
    print("=============================== Controller $response ");
    requestStatus = handelingData(response);
    if (RequestStatus.success == requestStatus) {
      //Start backend
      if (response['status'] == "success") {
        Get.offAllNamed(AppRoutes.home);
        // Get.rawSnackbar(
        //     title: "اشعار",
        //     messageText: const Text("تم اضافة المنتج الى السلة "));
        // data.add(response['data']);
      }
    } else {
      requestStatus = RequestStatus.failure;
    }
    // End
  }
  // getCountCart(var usersid, var itemsid) async {
  //   var response = await cartData.getCountCart(
  //       _appServices.sharedPreferences.getInt("id")!, itemsid);
  //   // print("=============================== Controller $response ");
  //   // requestStatus = handelingData(response);
  //   if (RequestStatus.success == requestStatus) {
  //     // Start backend
  //     if (response['status'] == "success") {
  //
  //       countitems = int.parse(response['data']);
  //       print("==================================");
  //       print("$countitems");
  //
  //       // data.addAll(response['data']);
  //     } else {
  //       requestStatus = RequestStatus.failure;
  //     }
  //     update();
  //     // End
  //   }
  // }
  // deleteitems(var itemsid) async {
  //   // requestStatus = RequestStatus.loading;
  //   // update();
  //
  //   var response = await cartData.deleteCart(
  //       _appServices.sharedPreferences.getInt("id")!, itemsid);
  //   print("=============================== Controller $response ");
  //   // requestStatus = handelingData(response);
  //   // if (RequestStatus.success == requestStatus) {
  //   //   // Start backend
  //   //   if (response['status'] == "success") {
  //   //     Get.rawSnackbar(
  //   //         title: "اشعار",
  //   //         messageText: const Text("تم ازالة المنتج من السلة "));
  //   //     // data.addAll(response['data']);
  //   //   } else {
  //   //     requestStatus = RequestStatus.failure;
  //   //   }
  //     // End
  //   }

  List subitems = [
    {"name": "red", "id": 1, "active": '0'},
    {"name": "yallow", "id": 2, "active": '0'},
    {"name": "black", "id": 3, "active": '1'}
  ];

  add() {
    // addItems(item.itemsId);
    countitems++;
    update();
  }

  remove() {
    if (countitems > 0) {
      // deleteitems(item.itemsId);
      countitems--;
      update();
    }
  }

  @override
  void onInit() {
    intialData();

    super.onInit();
  }
}
