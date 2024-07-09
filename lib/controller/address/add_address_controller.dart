import 'package:ecommercecourse/core/classes/request_status.dart';
import 'package:ecommercecourse/core/constants/routes_name.dart';
import 'package:ecommercecourse/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

abstract class AddAddAddressController extends GetxController {
  getMapData();
  setMarker(LatLng latLng);
  addAddress();
}

class AddAddressControllerImpl extends AddAddAddressController {
  late MapController mapController;
  final AppServices _appServices = Get.find();
  late Position position = _appServices.position;
  RequestStatus requestStatus = RequestStatus.notInitialized;
  List<Marker> markers = [];
  double lat = 0;
  double lng = 0;
  @override
  void onInit() {
    getMapData();
    mapController = MapController();

    super.onInit();
  }

  @override
  getMapData() async {
    requestStatus = RequestStatus.loading;

    requestStatus = RequestStatus.success;
    update();
  }

  @override
  setMarker(LatLng latLng) {
    markers.clear();
    markers.add(
      Marker(
        point: latLng,
        child: const Icon(Icons.location_on),
      ),
    );

    lat = latLng.latitude;
    lng = latLng.longitude;
    update();
  }

  @override
  addAddress() {
    print('lat $lat lng $lng');
    Get.offNamed(AppRoutes.addAddressDetails,
        arguments: {'lat': lat, 'lng': lng});
  }
}
