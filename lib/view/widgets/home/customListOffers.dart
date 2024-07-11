import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommercecourse/controller/favorite_items_controller.dart';
import 'package:ecommercecourse/controller/items_controller.dart';
import 'package:ecommercecourse/controller/offers_controller.dart';
import 'package:ecommercecourse/core/constants/api_link.dart';
import 'package:ecommercecourse/core/constants/colors.dart';
import 'package:ecommercecourse/core/constants/image_assets.dart';
import 'package:ecommercecourse/core/constants/spaces.dart';
import 'package:ecommercecourse/core/functions/translate_data.dart';

import 'package:ecommercecourse/data/model/items.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomListOffers extends GetView<OffersController> {
  final Item item;
  const CustomListOffers({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => controller.goToProductDetails(item),
        child: Card(
          child: Stack(
            children: [
              Padding(
                padding: AppSpacing.addEdgeInsetsAll(p12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: "${item.itemsId}",
                        child: CachedNetworkImage(
                          imageUrl:
                              "${ApiLink.itemsImageFolder}/${item.itemsImage}",
                          height: h100,
                          fit: BoxFit.fill,
                          fadeInDuration: const Duration(milliseconds: 400),
                          fadeOutDuration: const Duration(milliseconds: 400),
                        ),
                      ),
                      AppSpacing.addHeigh(h10),
                      Text(translateData(item.itemsNameAr, item.itemsName),
                          style: const TextStyle(
                              color: AppColors.black,
                              fontSize: s16,
                              fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${"rating".tr} 3.5",
                              textAlign: TextAlign.center),
                          Container(
                            alignment: Alignment.bottomCenter,
                            height: h24,
                            child: Row(
                              children: [
                                ...List.generate(
                                    5,
                                    (index) => const Icon(
                                          Icons.star,
                                          size: s16,
                                        ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${item.itemsPriceAfterDiscount} \$",
                              style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: s16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "sans")),
                          GetBuilder<FavoriteItemsControllerImpl>(
                              builder: (controller) {
                            return IconButton(
                              onPressed: () {
                                controller.changeFavorite(item);
                              },
                              icon: controller.favoriteItems
                                      .contains(item.itemsId)
                                  ? const Icon(
                                      Icons.favorite,
                                      color: AppColors.primaryColor,
                                    )
                                  : const Icon(Icons.favorite_border_outlined),
                            );
                          })
                        ],
                      )
                    ]),
              ),
              if (item.itemsDiscount != 0)
                Positioned(
                    child: ColorFiltered(
                  colorFilter: ColorFilter.matrix(colorFilterMatrix),
                  child: Image.asset(
                    AppImageAssets.sales,
                    height: h64,
                    width: w64,
                    fit: BoxFit.fill,
                  ),
                ))
            ],
          ),
        ));
  }

  final List<double> colorFilterMatrix = const <double>[
    0.5126,
    1.0,
    0.7722,
    0,
    1,
    0.2126,
    1.2152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    1,
    1,
    1,
    0,
    1,
    0
  ];
}
