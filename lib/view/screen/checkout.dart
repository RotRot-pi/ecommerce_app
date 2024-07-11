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
        title: Text('checkout'.tr),
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: MaterialButton(
            color: AppColors.secondaryColor,
            textColor: Colors.white,
            onPressed: () => controller.checkout(),
            child: Text('checkout'.tr,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          )),
      body: GetBuilder<CheckoutController>(
          builder: (controller) => HandelingDataView(
              requestStatus: controller.statusRequest,
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      Text(
                        "choose_payment_method".tr,
                        style: const TextStyle(
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
                            title: "cash_on_delivery".tr,
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
                            title: "payment_cards".tr,
                            isActive:
                                controller.paymentMethod == 1 ? true : false),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "choose_delivery_type".tr,
                        style: const TextStyle(
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
                                title: "delivery".tr,
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
                                title: "receive".tr,
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
                            Text(
                              "shipping_address".tr,
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
                                    Text(
                                      "no_shipping_address".tr,
                                      style: const TextStyle(
                                          color: AppColors.greyTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.goToAddress();
                                      },
                                      child: Text("add_shipping_address".tr),
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
