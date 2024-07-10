import 'package:ecommercecourse/core/classes/request_status.dart';
import 'package:ecommercecourse/core/constants/routes_name.dart';
import 'package:ecommercecourse/core/functions/handing_data.dart';
import 'package:ecommercecourse/core/services/services.dart';
import 'package:ecommercecourse/data/datasource/remote/order/details.dart';
import 'package:ecommercecourse/data/model/cart.dart';
import 'package:ecommercecourse/data/model/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class OrdersDetailsController extends GetxController {
  final AppServices _appServices = Get.find();
  final OrderDetailsData orderDetailsData = OrderDetailsData(crud: Get.find());
  late MapController mapController;
  late MapCamera mapCamera;
  late Position position;
  late OrderDetails orderDetails;
  double zoom = 10;

  List<Marker> markers = [];
  double lat = 0;
  double lng = 0;

  List data = [];
  late RequestStatus requestStatus;
  getData() async {
    requestStatus = RequestStatus.loading;
    print("status1:$requestStatus");
    print("ORDER ID:${orderDetails.orderId}");
    var response =
        await orderDetailsData.getData(orderDetails.orderId.toString());
    requestStatus = handelingData(response);
    print("status2:$requestStatus");
    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
      print("response:$response ");

      for (var item in response['data']) {
        data.add(CartModel.fromMap(item));
        print("Cart Status 3:${requestStatus}");
      }
      update();
    } else {
      requestStatus = RequestStatus.failure;
    }
    update();
  }

  setMarker(LatLng latLng) {
    if (orderDetails.orderType == 0) {
      markers.clear();
      markers.add(
        Marker(
          point: latLng,
          child: const Icon(Icons.location_on),
        ),
      );

      lat = orderDetails.addressLat ?? latLng.latitude;
      lng = orderDetails.addressLong ?? latLng.longitude;
    }
    update();
  }

  zoomIn() {
    if (zoom < 150) {
      zoom += 0.5;

      print("Zoom: $zoom");
    }
    update();
  }

  zoomOut() {
    if (zoom > 1) {
      zoom -= 0.5;

      print("Zoom: $zoom");
    }
    update();
  }

  goToOrderTracking(OrderDetails order) {
    Get.toNamed(AppRoutes.orderTracking, arguments: {"order": order});
  }

  @override
  void onInit() {
    orderDetails = Get.arguments['order'];
    mapController = MapController();
    position = _appServices.position;
    getData();
    super.onInit();
  }
}
