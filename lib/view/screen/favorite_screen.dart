import 'package:ecommercecourse/controller/favorite_controller.dart';
import 'package:ecommercecourse/data/model/favorite.dart';
import 'package:ecommercecourse/view/widgets/customappbar.dart';
import 'package:ecommercecourse/view/widgets/favorite/customfavoritewidget.dart';
import 'package:ecommercecourse/view/widgets/handeling_data_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoriteControllerImpl());
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(titleappbar: "favorite".tr),
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
                          return Card(
                            child: CustomFavoriteWidget(favorite: favorite),
                          );
                        },
                      ),
                    ),
                  ))
        ],
      ),
    );
  }
}
