import 'dart:io';

import 'package:ecommercecourse/controller/home_screen_controller.dart';
import 'package:ecommercecourse/view/widgets/home/cutombottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //TODO: Test this widget with and without ScreenUtil
    //TODO: Test Text size with and without sp
    //TODO: Test Text with and without FittedBox widget

    Get.put(HomeScreenControllerImpl());
    return GetBuilder<HomeScreenControllerImpl>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () => controller.goToCart(),
          shape: const CircleBorder(),
          backgroundColor: AppColors.secondaryColor,
          child:
              const Icon(Icons.shopping_basket_outlined, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomNavigationAppBar(),
        body: PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            if (didPop) {
              return;
            }
            final bool shouldPop =
                await controller.showBackDialog(context) ?? false;
            if (shouldPop) {
              exit(0);
            }
          },
          child: controller.pages[controller.currentPageIndex],
        ),
      );
    });
  }
}
