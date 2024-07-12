// ignore_for_file: prefer_const_constructors
import 'package:ecommercecourse/controller/cart_controller.dart';
import 'package:ecommercecourse/core/constants/api_link.dart';
import 'package:ecommercecourse/view/widgets/cart/appbarcart.dart';
import 'package:ecommercecourse/view/widgets/cart/custom_bottom_navgationbar_cart.dart';
import 'package:ecommercecourse/view/widgets/cart/customitemscartlist.dart';
import 'package:ecommercecourse/view/widgets/cart/topcardcart.dart';
import 'package:ecommercecourse/view/widgets/handeling_data_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    return Scaffold(
        appBar: AppBar(
          title: Text("my_cart".tr),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: GetBuilder<CartController>(
            builder: (controller) => BottomNavgationBarCart(
                  controllercoupon: controller.couponController,
                  onApplyCoupon: () => controller.checkCoupon(),
                  onPressedOrder: () => controller.goToCheckout(),
                  price: controller.ordersPrice.toStringAsFixed(2),
                  discount: "${controller.discountCoupon}",
                  totalprice: controller.ordersPrice.toStringAsFixed(2),
                )),
        body: GetBuilder<CartController>(
            builder: (controller) => HandelingDataView(
                requestStatus: controller.requestStatus,
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    TopCardCart(
                        message:
                            "${"you_have".tr} ${controller.totalcountitems} ${"items_in_your_list".tr}"),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ...List.generate(
                            controller.data.length,
                            (index) => GetBuilder<CartController>(
                                builder: (controller) {
                              return CustomItemsCartList(
                                  onAdd: () async {
                                    await controller
                                        .add(controller.data[index].itemsId!);
                                    //cartController.refreshPage();
                                  },
                                  onRemove: () async {
                                    await controller.delete(
                                        controller.data[index].itemsId!);
                                    //cartController.refreshPage();
                                  },
                                  imageName:
                                      "${ApiLink.itemsImageFolder}${controller.data[index].itemsImage}",
                                  name: "${controller.data[index].itemsName}",
                                  price:
                                      "${controller.data[index].itemsPrice} \$",
                                  count:
                                      "${controller.data[index].cartItemCount}");
                            }),
                          )
                        ],
                      ),
                    )
                  ],
                ))));
  }
}
