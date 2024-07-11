import 'package:ecommercecourse/controller/settings_controller.dart';
import 'package:ecommercecourse/core/constants/colors.dart';
import 'package:ecommercecourse/core/constants/image_assets.dart';
import 'package:ecommercecourse/core/constants/spaces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsControllerImpl());
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: h200,
                decoration: const BoxDecoration(color: AppColors.primaryColor),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                // color: Colors.black,
                height: h240,
                child: Container(
                  height: h96,
                  width: w96,
                  padding: AppSpacing.addEdgeInsetsAll(p4),
                  decoration: const BoxDecoration(
                      color: AppColors.whiteTextColor, shape: BoxShape.circle),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage(AppImageAssets.avatar),
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.addHeigh(h80),
          GetBuilder<SettingsControllerImpl>(
            builder: (controller) => Expanded(
              // color: Colors.blue,
              //padding: AppSpacing.addEdgeInsetsSymmetric(horizontal: p16),

              //height: h200,
              child: ListView(
                  padding: AppSpacing.addEdgeInsetsSymmetric(horizontal: p16),
                  children: [
                    ListTile(
                      // onTap: () {},
                      trailing: Switch(
                          onChanged: (val) {
                            controller.enableNotification(val);
                          },
                          value: controller.isNotificationEnabled),
                      title: const Text("Disable Notificatios"),
                    ),
                    ListTile(
                      onTap: () => controller.goToAddress(),
                      trailing: const Icon(Icons.location_on_outlined),
                      title: const Text("Address"),
                    ),
                    ListTile(
                      onTap: () => controller.goToOrders(),
                      trailing: const Icon(Icons.delivery_dining),
                      title: const Text("Orders"),
                    ),
                    ListTile(
                      onTap: () => controller.goToArchive(),
                      trailing: const Icon(Icons.archive_outlined),
                      title: const Text("Archive"),
                    ),
                    ListTile(
                      onTap: () {},
                      trailing: const Icon(Icons.help_outline_rounded),
                      title: const Text("About us"),
                    ),
                    ListTile(
                      onTap: () async {
                        await launchUrl(Uri.parse("tel:+201096632333"));
                      },
                      trailing: const Icon(Icons.phone_callback_outlined),
                      title: const Text("Contact us"),
                    ),
                    ListTile(
                      onTap: () {
                        controller.logout();
                      },
                      title: const Text("Logout"),
                      trailing: const Icon(Icons.exit_to_app),
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
