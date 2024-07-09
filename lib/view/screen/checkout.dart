import 'package:ecommercecourse/controller/checkout_controller.dart';
import 'package:ecommercecourse/core/constants/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/colors.dart';
import '../widgets/checkout/carddeliveerytype.dart';
import '../widgets/checkout/cardpaymentmethod.dart';
import '../widgets/checkout/cardshippingaddress.dart';
import '../widgets/handeling_data_view.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CheckoutController controller = Get.put(CheckoutController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: MaterialButton(
            color: AppColors.secondaryColor,
            textColor: Colors.white,
            onPressed: () => controller.checkout(),
            child: const Text("Checkout",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          )),
      body: GetBuilder<CheckoutController>(
          builder: (controller) => HandelingDataView(
              requestStatus: controller.statusRequest,
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      const Text(
                        "Choose Payment Method",
                        style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          //0=>cash ;1=>card
                          controller.choosePaymentMethod(0);
                        },
                        child: CardPaymentMethodCheckout(
                            title: "Cash On Delivery",
                            isActive:
                                controller.paymentMethod == 0 ? true : false),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          //0=>cash ;1=>card
                          controller.choosePaymentMethod(1);
                        },
                        child: CardPaymentMethodCheckout(
                            title: "Payment Cards",
                            isActive:
                                controller.paymentMethod == 1 ? true : false),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Choose Delivery Type",
                        style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              //0=>delivery ;1=>receive
                              controller.chooseDeliveryType(0);
                            },
                            child: CardDeliveryTypeCheckout(
                                imagename: AppImageAssets.deliveryImage,
                                title: "Delivery",
                                active: controller.deliveryType == 0
                                    ? true
                                    : false),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              //0=>delivery ;1=>receive
                              controller.chooseDeliveryType(1);
                            },
                            child: CardDeliveryTypeCheckout(
                                imagename: AppImageAssets.drivethruImage,
                                title: "Revice",
                                active: controller.deliveryType == 1
                                    ? true
                                    : false),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      if (controller.deliveryType == 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Shipping Address",
                              style: TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            if (controller.dataaddress.isEmpty)
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "No Shipping Address",
                                      style: TextStyle(
                                          color: AppColors.greyTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.goToAddress();
                                      },
                                      child: const Text("Add Shipping Address"),
                                    ),
                                  ],
                                ),
                              ),
                            ...List.generate(
                              controller.dataaddress.length,
                              (index) => InkWell(
                                onTap: () {
                                  controller.chooseShippingAddress(
                                      controller.dataaddress[index].addressId!);
                                },
                                child: CardShppingAddressCheckout(
                                    title:
                                        "${controller.dataaddress[index].addressName}",
                                    body:
                                        "${controller.dataaddress[index].addressCity} ${controller.dataaddress[index].addressStreet}",
                                    isactive: controller.addressid ==
                                            controller
                                                .dataaddress[index].addressId
                                        ? true
                                        : false),
                              ),
                            )
                          ],
                        )
                    ],
                  )))),
    );
  }
}
