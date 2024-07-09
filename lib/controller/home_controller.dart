import 'package:ecommercecourse/core/classes/request_status.dart';
import 'package:ecommercecourse/core/constants/routes_name.dart';
import 'package:ecommercecourse/core/functions/handing_data.dart';
import 'package:ecommercecourse/core/services/services.dart';
import 'package:ecommercecourse/data/datasource/remote/home_data.dart';
import 'package:ecommercecourse/data/model/categories.dart';
import 'package:ecommercecourse/data/model/items.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeController extends SearchControllerMix {
  getData();
  initialData();
  goToItems(List categories, int categoryIndex, var categoryId);
  goToProductDetails(Item item);
}

class HomeControllerImpl extends HomeController {
  final AppServices _appServices = Get.find();
  HomeData homeData = HomeData(crud: Get.find());
  RequestStatus requestStatus = RequestStatus.notInitialized;
  late String username;
  late int id;
  late String language;
  String titleHomeCard = "";
  String descriptionHomeCard = "";
  String deliveryTime = "";

  List<Category> categories = [];
  List<Item> items = [];
  List homeCartSettings = [];

  @override
  getData() async {
    requestStatus = RequestStatus.loading;
    print("status1:$requestStatus");
    var response = await homeData.getData();
    requestStatus = handelingData(response);
    print("status2:$requestStatus");
    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
      print("response:$response ");

      for (var element in response['categories']) {
        categories.add(Category.fromMap(element));
      }

      for (var element in response['itemsTopSellingView']) {
        items.add(Item.fromMap(element));
      }

      for (var element in response['home_cart_settings']) {
        homeCartSettings.add(element as Map);
      }
      titleHomeCard = homeCartSettings[0]['home_cart_settings_title'];
      descriptionHomeCard = homeCartSettings[0]['home_cart_settings_body'];
      deliveryTime = homeCartSettings[0]['delivery_time'].toString();
      //deliveryTime: You can add it to shared preferences or wherever you want to save it
      _appServices.sharedPreferences.setString("deliveryTime", deliveryTime);
      print("homeCartSettings:${homeCartSettings}");
      print("categories:${categories}");
      print("items:${items}");
    } else {
      requestStatus = RequestStatus.failure;
    }

    update();
  }

  @override
  initialData() {
    id = _appServices.sharedPreferences.getInt("id")!;
    username = _appServices.sharedPreferences.getString("username")!;
    language = _appServices.sharedPreferences.getString("lang")!;

    print("Controller lang:$language");
  }

  @override
  goToItems(List categories, int categoryIndex, var categoryId) {
    Get.toNamed(AppRoutes.items, arguments: {
      'categories': categories,
      'categoryIndex': categoryIndex,
      'categoryId': categoryId
    });
  }

  @override
  goToProductDetails(Item item) {
    Get.toNamed(AppRoutes.productDetails, arguments: {'item': item});
  }

  @override
  void onInit() {
    searchController = TextEditingController();
    initialData();
    getData();
    super.onInit();
  }
}

class SearchControllerMix extends GetxController {
  HomeData homeData = HomeData(crud: Get.find());
  late TextEditingController searchController;
  RequestStatus requestStatus = RequestStatus.notInitialized;
  bool isSeaching = false;
  List searchedItems = [];

  isSearching(String value) {
    print("Value:$value");
    if (value.isEmpty || value == "") {
      requestStatus = RequestStatus.notInitialized;
      isSeaching = false;
    }
    update();
  }

  onItemsSearch() {
    isSeaching = true;
    update();
    searchItems();
    update();
  }

  searchItems() async {
    searchedItems.clear();
    if (searchController.text.isEmpty) {
      return;
    }
    requestStatus = RequestStatus.loading;
    print("status1:$requestStatus");
    var response = await homeData.searchData(searchController.text);

    requestStatus = handelingData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        response['data'].forEach((element) {
          searchedItems.add(Item.fromMap(element));
        });

        print("searchedItems:${searchedItems}");
      } else {
        requestStatus = RequestStatus.failure;
      }
    }
    update();
  }

  goToProductDetails(Item item) {
    Get.toNamed(AppRoutes.productDetails, arguments: {'item': item});
  }

  @override
  void onInit() {
    super.onInit();
  }
}
