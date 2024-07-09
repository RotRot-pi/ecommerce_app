import 'package:ecommercecourse/core/functions/handing_data.dart';
import 'package:ecommercecourse/core/services/services.dart';
import 'package:ecommercecourse/data/datasource/remote/checkout.dart';
import 'package:ecommercecourse/data/model/address.dart';

import 'package:get/get.dart';

import '../core/classes/request_status.dart';
import '../core/constants/routes_name.dart';
import '../data/datasource/remote/address/address_data.dart';

class CheckoutController extends GetxController {
  AddressData addressData = Get.put(AddressData(Get.find()));
  CheckoutData checkoutData = Get.put(CheckoutData(Get.find()));
  AppServices myServices = Get.find();

  RequestStatus statusRequest = RequestStatus.notInitialized;

  int? couponId;
  int? couponDiscount = 0;
  dynamic ordersPrice;
  int? paymentMethod;
  int? deliveryType;
  int? addressid;

  List<Address> dataaddress = [];

  choosePaymentMethod(int val) {
    paymentMethod = val;
    update();
  }

  chooseDeliveryType(int val) {
    deliveryType = val;
    update();
  }

  chooseShippingAddress(int val) {
    addressid = val;
    update();
  }

  getShippingAddress() async {
    statusRequest = RequestStatus.loading;

    var response = await addressData
        .getAddress(myServices.sharedPreferences.getInt("id")!);

    print("=============================== Controller $response ");

    // Start backend
    if (response['status'] == "success") {
      List listdata = response['data'];
      dataaddress.addAll(listdata.map((e) => Address.fromJson(e)));
    }
    statusRequest = RequestStatus.success;
    update();
    // End
  }

  goToAddress() {
    Get.toNamed(AppRoutes.addAddress);
  }

  checkout() async {
    if (paymentMethod == null) {
      return Get.snackbar(
        "Error",
        "Please choose payment method",
      );
    }
    if (deliveryType == null) {
      return Get.snackbar(
        "Error",
        "Please choose delivery type",
      );
    }
    if (deliveryType == 0 && addressid == null) {
      return Get.snackbar(
        "Error",
        "Please choose shipping address",
      );
    }
    if (dataaddress.isEmpty) {
      return Get.snackbar(
        "Error",
        "Please add shipping address",
      );
    }
    addressid == null ? addressid = 0 : addressid = addressid;
    couponId == null ? couponId = 0 : couponId = couponId;
    print("=============================== Controller checkout ");
    var map = {
      "user_id": myServices.sharedPreferences.getInt("id")!.toString(),
      "address_id": addressid!.toString(),
      "order_type": deliveryType!.toString(),
      "coupon_id": couponId!.toString(),
      "delivery_price": "10",
      "order_price": ordersPrice.toString(),
      "coupon_discount": couponDiscount!.toString(),
      "payment_type": paymentMethod!.toString(),
    };
    print("Map:$map");
    var response = await checkoutData.checkout(map);
    statusRequest = handelingData(response);
    print("StatusRequest:$statusRequest");
    if (RequestStatus.success == statusRequest) {
      // Start backend

      Get.offAllNamed(AppRoutes.home);

      // End
    } else {
      Get.snackbar(
        "Error",
        "Something went wrong",
      );
    }
    update();
  }

  @override
  void onInit() {
    getShippingAddress();
    couponId = Get.arguments['couponId'] ?? 0;
    ordersPrice = Get.arguments['ordersPrice'];
    couponDiscount = Get.arguments['couponDiscount'];

    print('Discount: $couponDiscount');

    super.onInit();
  }
}
