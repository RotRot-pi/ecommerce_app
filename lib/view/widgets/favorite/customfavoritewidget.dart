import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommercecourse/controller/favorite_controller.dart';
import 'package:ecommercecourse/core/constants/api_link.dart';
import 'package:ecommercecourse/core/constants/colors.dart';
import 'package:ecommercecourse/core/constants/spaces.dart';
import 'package:ecommercecourse/core/functions/translate_data.dart';
import 'package:ecommercecourse/data/model/favorite.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFavoriteWidget extends GetView<FavoriteControllerImpl> {
  final Favorite favorite;
  const CustomFavoriteWidget({
    super.key,
    required this.favorite,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        //onTap: () => controller.goToProductDetails(Favorite),
        child: Card(
      child: Padding(
        padding: AppSpacing.addEdgeInsetsAll(p12),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: "${favorite.itemsId}",
                child: CachedNetworkImage(
                  imageUrl:
                      "${ApiLink.itemsImageFolder}/${favorite.itemsImage}",
                  height: h100,
                  fit: BoxFit.fill,
                  fadeInDuration: const Duration(milliseconds: 400),
                  fadeOutDuration: const Duration(milliseconds: 400),
                ),
              ),
              AppSpacing.addHeigh(h10),
              Text(translateData(favorite.itemsNameAr, favorite.itemsName),
                  style: const TextStyle(
                      color: AppColors.black,
                      fontSize: s16,
                      fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${"rating".tr} 3.5", textAlign: TextAlign.center),
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
                  Text("${favorite.itemsPrice} \$",
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: s16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "sans")),
                  GetBuilder<FavoriteControllerImpl>(builder: (controller) {
                    return IconButton(
                      onPressed: () {
                        controller.deleteData(favorite.favoriteId);
                      },
                      icon: const Icon(Icons.delete_outline_outlined),
                    );
                  })
                ],
              )
            ]),
      ),
    ));
  }
}
