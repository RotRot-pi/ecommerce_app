// lib/view/screen/language.dart
import 'package:ecommercecourse/core/constants/routes_name.dart';
import 'package:ecommercecourse/core/constants/spaces.dart';
import 'package:ecommercecourse/core/localization/change_local.dart';
import 'package:ecommercecourse/view/widgets/language/custom_language_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageScreen extends GetView<LocalizationController> {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'choose_language'.tr,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            AppSpacing.addHeigh(h32),
            LanguageButton(
              language: 'english'.tr,
              onPressed: () async {
                controller.changeLanguage('en');
                await Future.delayed(const Duration(milliseconds: 400), () {});
                Get.toNamed(AppRoutes.onboarding);
              },
            ),
            AppSpacing.addHeigh(h16),
            LanguageButton(
              language: 'arabic'.tr,
              onPressed: () async {
                controller.changeLanguage('ar');
                await Future.delayed(const Duration(milliseconds: 400), () {});
                Get.toNamed(AppRoutes.onboarding);
              },
            ),
            AppSpacing.addHeigh(h16),
            LanguageButton(
              language: 'french'.tr,
              onPressed: () async {
                controller.changeLanguage('fr');
                await Future.delayed(const Duration(milliseconds: 400), () {});
                Get.toNamed(AppRoutes.onboarding);
              },
            ),
          ],
        ),
      ),
    );
  }
}
