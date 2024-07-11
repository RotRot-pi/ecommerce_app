import 'package:ecommercecourse/controller/favorite_items_controller.dart';
import 'package:ecommercecourse/controller/items_controller.dart';
import 'package:ecommercecourse/core/constants/routes_name.dart';
import 'package:ecommercecourse/core/constants/spaces.dart';
import 'package:ecommercecourse/view/screen/home_page.dart';
import 'package:ecommercecourse/view/widgets/customappbar.dart';
import 'package:ecommercecourse/view/widgets/handeling_data_view.dart';
import 'package:ecommercecourse/view/widgets/items/customitemslist.dart';
import 'package:ecommercecourse/view/widgets/items/listitemscategories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ItemsControllerImpl());
    var favoriteController = Get.put(FavoriteItemsControllerImpl());
    return Scaffold(
        appBar: AppBar(
          title: Text("products".tr),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.offNamed(AppRoutes.home),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
            padding: AppSpacing.addEdgeInsetsAll(p16),
            child: ListView(
              children: [
                CustomAppBar(
                  titleappbar: "find_product".tr,
                  searchController: controller.searchController,
                  onPressedIcon: () {},
                  onPressedFavorite: () => Get.toNamed(AppRoutes.favorite),
                  onPressedSearch: () => controller.onItemsSearch(),
                  onChanged: (value) => controller.isSearching(value),
                ),
                AppSpacing.addHeigh(h16),
                const ListItemsCategories(),
                GetBuilder<ItemsControllerImpl>(builder: (controller) {
                  return HandelingDataView(
                    requestStatus: controller.requestStatus,
                    child: !controller.isSeaching
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.items.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 0.65),
                            itemBuilder: (BuildContext context, index) {
                              favoriteController
                                  .addItemToFavorite(controller.items[index]);
                              return CustomListItems(
                                  item: controller.items[index]);
                            })
                        : SearchedItemsList(
                            listdatamodel: controller.searchedItems,
                          ),
                  );
                })
              ],
            )
            // Column(
            //     children: [
            //       CustomAppBar(
            //           titleappbar: "find_product".tr,
            //           onPressedIcon: () {},
            //           onPressedFavorite: () =>
            //               Get.toNamed(AppRoutes.favorite),
            //           onPressedSearch: () => controller.searchItems()),
            //       Expanded(
            //           child: ),
            //     ],
            //   );

            ));
  }
}
