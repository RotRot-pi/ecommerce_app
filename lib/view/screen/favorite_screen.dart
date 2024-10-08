import 'package:zingoshop/controller/favorite_controller.dart';
import 'package:zingoshop/core/constants/routes_name.dart';
import 'package:zingoshop/core/constants/spaces.dart';
import 'package:zingoshop/data/model/favorite.dart';
import 'package:zingoshop/view/widgets/customappbar.dart';
import 'package:zingoshop/view/widgets/favorite/customfavoritewidget.dart';
import 'package:zingoshop/view/widgets/handeling_data_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoriteControllerImpl());
    return Scaffold(
      body: Padding(
        padding: AppSpacing.addEdgeInsetsAll(p24),
        child: Column(
          children: [
            CustomAppBar(
              searchHintText: "favorite".tr,
              goBack: true,
            ),
            GetBuilder<FavoriteControllerImpl>(
                builder: (conroller) => HandelingDataView(
                      requestStatus: conroller.requestStatus,
                      child: Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.65),
                          itemCount: conroller.data.length,
                          itemBuilder: (context, index) {
                            Favorite favorite = conroller.data[index];
                            return CustomFavoriteWidget(favorite: favorite);
                          },
                        ),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
