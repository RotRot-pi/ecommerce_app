import 'package:ecommercecourse/controller/tracking_controller.dart';
import 'package:ecommercecourse/core/constants/colors.dart';
import 'package:ecommercecourse/core/constants/spaces.dart';
import 'package:ecommercecourse/view/widgets/handeling_data_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(TrackingController());
    TrackingController trackingController = Get.put(TrackingController());
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Order Tracking",
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
        body: Container(
          padding: AppSpacing.addEdgeInsetsOnly(
            top: p16,
          ),
          child: GetBuilder<TrackingController>(builder: (controller) {
            return HandelingDataView(
              requestStatus: controller.requestStatus,
              child: Column(
                children: [
                  Expanded(
                    child: GetBuilder<TrackingController>(
                      builder: (controller) => Stack(
                        children: [
                          FlutterMap(
                            mapController: controller.mapController,
                            options: MapOptions(
                              onMapReady: () => controller.setMarker(LatLng(
                                  controller.orderDetails.addressLong!,
                                  controller.orderDetails.addressLat!)),
                              initialCenter: LatLng(
                                controller.orderDetails.addressLat ?? 0.0,
                                controller.orderDetails.addressLong ?? 0.0,
                              ),
                              initialZoom: controller.zoom,
                              minZoom: controller.zoom,
                              maxZoom: controller.zoom,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.app',
                              ),
                              MarkerLayer(markers: controller.markers),
                              RichAttributionWidget(
                                attributions: [
                                  TextSourceAttribution(
                                    'OpenStreetMap contributors',
                                    onTap: () => launchUrl(
                                        Uri.parse('https://openstreetmap.org')),
                                  ),
                                ],
                              ),
                              PolylineLayer(polylines: controller.polylines),
                            ],
                          ),
                          Positioned(
                              bottom: 10,
                              left: 10,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.zoomIn();
                                      },
                                      child: const Icon(Icons.add),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.zoomOut();
                                      },
                                      child: const Icon(Icons.remove),
                                    ),
                                  ]))
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //     height: h56,
                  //     width: w180,
                  //     padding: AppSpacing.addEdgeInsetsSymmetric(
                  //       vertical: p8,
                  //     ),
                  //     child: MaterialButton(
                  //       color: AppColors.primaryColor,
                  //       onPressed: () {
                  //         controller.deliveryDone();
                  //       },
                  //       child: const Text(
                  //         "Done Delivery",
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     ))
                ],
              ),
            );
          }),
        ));
  }
}
