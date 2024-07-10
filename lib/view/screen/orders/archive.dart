import 'package:ecommercecourse/controller/order/archive.dart';
import 'package:ecommercecourse/data/model/order_details.dart';
import 'package:ecommercecourse/view/widgets/order/pending.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/order.dart';
import '../../widgets/handeling_data_view.dart';

class ArchiveOrdersScreen extends StatelessWidget {
  const ArchiveOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ArchivingOrderController());
    return Scaffold(
        appBar: AppBar(
          title: const Text("Archive"),
        ),
        body: GetBuilder<ArchivingOrderController>(
            builder: (controller) => HandelingDataView(
                requestStatus: controller.requestStatus,
                child: ListView.builder(
                    itemCount: controller.data.length,
                    itemBuilder: (context, index) {
                      OrderDetails order = controller.data[index];
                      return OrderCard(order: order, controller: controller);
                    }))));
  }
}
