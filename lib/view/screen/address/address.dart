import 'package:ecommercecourse/data/model/address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/address/address_controller.dart';
import '../../../core/constants/spaces.dart';
import '../../widgets/handeling_data_view.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressControllerImpl());

    return Scaffold(
        appBar: AppBar(
          title: const Text("Address"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => controller.goToAddAddress(),
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        body: Padding(
            padding: AppSpacing.addEdgeInsetsAll(p12),
            child: GetBuilder<AddressControllerImpl>(builder: (controller) {
              return HandelingDataView(
                  requestStatus: controller.requestStatus,
                  child: ListView.builder(
                      itemCount: controller.addressList.length,
                      itemBuilder: (context, index) {
                        Address address = controller.addressList[index];
                        return AddressCard(
                            address: address, controller: controller);
                        // return ListTile(
                        //     title: Text(address.addressName!),
                        //     subtitle:
                        //         Text(address.addressStreet!),
                        //     trailing: IconButton(
                        //       onPressed: () {},
                        //       icon: const Icon(Icons.delete),
                        //     ));
                      }));
            })));
  }
}

//create address cart widget
class AddressCard extends StatelessWidget {
  final Address address;
  final AddressControllerImpl controller;
  const AddressCard(
      {super.key, required this.address, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    address.addressName!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              address.addressStreet!,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    // TODO: Implement edit functionality
                  },
                  icon: const Icon(Icons.edit, color: Colors.blue),
                ),
                IconButton(
                  onPressed: () {
                    controller.deleteAddress(address.addressId!);
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
