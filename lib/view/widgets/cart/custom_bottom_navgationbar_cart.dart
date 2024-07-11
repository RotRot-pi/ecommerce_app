// ignore_for_file: prefer_const_constructors

import 'package:ecommercecourse/controller/cart_controller.dart';
import 'package:ecommercecourse/core/constants/colors.dart';
import 'package:ecommercecourse/core/constants/spaces.dart';
import 'package:ecommercecourse/view/widgets/cart/buttoncart.dart';
import 'package:ecommercecourse/view/widgets/cart/custom_coupon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomNavgationBarCart extends StatelessWidget {
  final String? price;
  final String? discount;
  final String? totalprice;
  final TextEditingController? controllercoupon;
  final VoidCallback? onApplyCoupon;
  final VoidCallback? onPressedOrder;
  const BottomNavgationBarCart({
    super.key,
    required this.price,
    required this.discount,
    required this.totalprice,
    this.onApplyCoupon,
    this.controllercoupon,
    this.onPressedOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: AppSpacing.addEdgeInsetsSymmetric(horizontal: p4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<CartController>(builder: (controller) {
              return controller.couponName == null
                  ? Container(
                      height: h40,
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: controllercoupon,
                            textAlignVertical: TextAlignVertical.center,
                            cursorHeight: h24,
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: "coupon_code".tr,
                                hintStyle:
                                    TextStyle(color: Colors.grey, height: h4),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: CustomButtonCoupon(
                            textButton: "apply".tr,
                            onPressed: onApplyCoupon,
                          ),
                        ),
                      ]))
                  : Container(
                      alignment: Alignment.center,
                      child: Text.rich(
                          TextSpan(text: "${"coupon_code".tr}:", children: [
                            TextSpan(
                                text: controller.couponName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black))
                          ]),
                          style: TextStyle(
                              color: AppColors.primaryColor, fontSize: 16.sp)),
                    );
            }),
            Container(
              margin: AppSpacing.addEdgeInsetsSymmetric(
                  horizontal: m16, vertical: m8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child:
                              Text("price".tr, style: TextStyle(fontSize: 16))),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child:
                              Text("$price \$", style: TextStyle(fontSize: 16)))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text("discount".tr,
                              style: TextStyle(fontSize: 16))),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text("$discount \%",
                              style: TextStyle(fontSize: 16)))
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text("total_price".tr,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor))),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text("$totalprice \$",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor)))
                    ],
                  ),
                  SizedBox(height: 10),
                  CustomButtonCart(
                    textbutton: "place_order".tr,
                    onPressed: onPressedOrder,
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ],
        ));
  }
}
