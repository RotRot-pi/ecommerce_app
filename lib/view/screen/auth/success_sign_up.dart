import 'dart:io';

import 'package:ecommercecourse/controller/auth/forget%20password/success_password_reset_controller.dart';
import 'package:ecommercecourse/core/constants/colors.dart';
import 'package:ecommercecourse/core/constants/spaces.dart';
import 'package:ecommercecourse/view/widgets/auth/custombuttonauth.dart';
import 'package:ecommercecourse/view/widgets/auth/customtexttitleauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessSignUp extends StatelessWidget {
  const SuccessSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    SuccessPasswordResetControllerImpl controller =
        Get.put(SuccessPasswordResetControllerImpl());
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: AppColors.whiteTextColor,
      //   elevation: 0.0,
      //   title: Text('success'.tr,
      //       style: Theme.of(context)
      //           .textTheme
      //           .displayLarge!
      //           .copyWith(color: AppColors.greyColor)),
      // ),

      body: PopScope(
        onPopInvoked: (didPop) {
          if (didPop) {
            //TODO: Show poping dialog
            //TODO: Make sure it worked
            print('popped');
            controller.showPopingDialog();
          }
        },
        canPop: true,
        child: Container(
          padding:
              AppSpacing.addEdgeInsetsSymmetric(vertical: p16, horizontal: p32),
          child: Column(children: [
            AppSpacing.addHeigh(h24),
            CustomTextTitleAuth(text: 'account_creation_success'.tr),
            AppSpacing.addSpace(),
            const Center(
              child: Icon(
                Icons.check_circle_outline_outlined,
                color: AppColors.primaryColor,
                size: s192,
              ),
            ),
            AppSpacing.addSpace(),
            SizedBox(
              width: double.infinity,
              child: CustomButtomAuth(
                  text: "go_to_login".tr,
                  onPressed: () {
                    controller.goToLogin();
                  }),
            ),
            AppSpacing.addHeigh(h32),
          ]),
        ),
      ),
    );
  }
}
