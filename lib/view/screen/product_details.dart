import 'package:ecommercecourse/controller/product_details_controller.dart';
import 'package:ecommercecourse/core/constants/colors.dart';
import 'package:ecommercecourse/view/widgets/handeling_data_view.dart';
import 'package:ecommercecourse/view/widgets/product_details/priceandcount.dart';
import 'package:ecommercecourse/view/widgets/product_details/toppageproductdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductDetailsControllerImpl controller =
        Get.put(ProductDetailsControllerImpl());
    return Scaffold(
        appBar: AppBar(
          title: Text("product_details".tr),
          centerTitle: true,
          backgroundColor: AppColors.whiteTextColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
        ),
        bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 40,
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: AppColors.secondaryColor,
                onPressed: () {
                  controller.addItems(controller.item.itemsId);
                  //Get.toNamed(AppRoutes.cart);
                },
                child: Text(
                  "go_to_cart".tr,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))),
        body: GetBuilder<ProductDetailsControllerImpl>(
            builder: (controller) => HandelingDataView(
                requestStatus: controller.requestStatus,
                child: ListView(children: [
                  const TopProductPageDetails(),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controller.item.itemsName,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    color: AppColors.fifthColor,
                                  )),
                          const SizedBox(height: 10),
                          PriceAndCountItems(
                              onAdd: () {
                                controller.add();
                              },
                              onRemove: () {
                                controller.remove();
                              },
                              price: controller.item.itemsPriceAfterDiscount ==
                                      null
                                  ? "${controller.item.itemsPrice}"
                                  : "${controller.item.itemsPriceAfterDiscount}",
                              count: "${controller.countitems}"),
                          const SizedBox(height: 10),
                          Text(controller.item.itemsDescription,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.greyColor)),
                          const SizedBox(height: 10),
                          // Text("Color",
                          //     style: Theme.of(context).textTheme.headline1!.copyWith(
                          //           color: AppColors.fourthColor,
                          //         )),
                          // const SizedBox(height: 10),
                          // const SubitemsList()
                        ]),
                  )
                ]))));
  }
}
