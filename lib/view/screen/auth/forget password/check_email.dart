import 'package:ecommercecourse/controller/auth/forget%20password/check_email_controller.dart';
import 'package:ecommercecourse/core/functions/validate_auth_inputs.dart';
import 'package:ecommercecourse/view/widgets/handeling_data_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ecommercecourse/core/constants/colors.dart';
import 'package:ecommercecourse/core/constants/spaces.dart';
import 'package:ecommercecourse/view/widgets/auth/custombuttonauth.dart';
import 'package:ecommercecourse/view/widgets/auth/customtextbodyauth.dart';
import 'package:ecommercecourse/view/widgets/auth/customtextformauth.dart';
import 'package:ecommercecourse/view/widgets/auth/customtexttitleauth.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CheckEmailControllerImpl());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.whiteTextColor,
        elevation: 0.0,
        title: Text('forget_password'.tr,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColors.greyColor)),
      ),
      body: GetBuilder<CheckEmailControllerImpl>(builder: (controller) {
        return HandelingDataView(
            requestStatus: controller.requestStatus,
            child: CheckEmailPage(controller: controller));
      }),
    );
  }
}

class CheckEmailPage extends StatelessWidget {
  const CheckEmailPage({
    super.key,
    required this.controller,
  });

  final CheckEmailControllerImpl controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          AppSpacing.addEdgeInsetsSymmetric(vertical: p16, horizontal: p32),
      child: ListView(children: [
        AppSpacing.addHeigh(h24),
        CustomTextTitleAuth(text: "check_email".tr),
        AppSpacing.addHeigh(h12),
        CustomTextBodyAuth(text: "email_verification_instructions".tr),
        AppSpacing.addHeigh(h24),
        CustonTextFormAuth(
          controller: controller.emailController,
          validator: (val) {
            return validateAuthInputs(val!, 25, 8, AuthInputType.email);
          },
          hinttext: "enter_email".tr,
          iconData: Icons.email_outlined,
          labeltext: "email".tr,
          // mycontroller: ,
        ),
        AppSpacing.addHeigh(h32),
        CustomButtomAuth(
            text: "check".tr,
            onPressed: () {
              controller.checkEmail();
            }),
        AppSpacing.addHeigh(h32),
      ]),
    );
  }
}
