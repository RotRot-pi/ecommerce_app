import 'package:ecommercecourse/controller/order/tracking.dart';
import 'package:ecommercecourse/core/middleware/app_middle_ware.dart';
import 'package:ecommercecourse/view/screen/address/add_address.dart';
import 'package:ecommercecourse/view/screen/address/add_address_details.dart';
import 'package:ecommercecourse/view/screen/address/address.dart';
import 'package:ecommercecourse/view/screen/cart.dart';
import 'package:ecommercecourse/view/screen/checkout.dart';
import 'package:ecommercecourse/view/screen/favorite_screen.dart';
import 'package:ecommercecourse/view/screen/home_screen.dart';
import 'package:ecommercecourse/view/screen/items.dart';
import 'package:ecommercecourse/view/screen/notification.dart';
import 'package:ecommercecourse/view/screen/offers.dart';
import 'package:ecommercecourse/view/screen/orders/archive.dart';
import 'package:ecommercecourse/view/screen/orders/details.dart';
import 'package:ecommercecourse/view/screen/orders/pending.dart';
import 'package:ecommercecourse/view/screen/product_details.dart';
import 'package:get/get.dart';

import 'package:ecommercecourse/core/constants/routes_name.dart';
import 'package:ecommercecourse/view/screen/screen_barrel.dart';

List<GetPage> getPages = [
  // GetPage(
  //   name: '/',
  //   page: () => Test(),
  // )

  // ========================= Auth ========================= //
  GetPage(
      name: AppRoutes.language,
      page: () => const LanguageScreen(),
      middlewares: [AppMiddleWare()]),
  GetPage(
    name: AppRoutes.onboarding,
    page: () => const OnBoardingScreen(),
  ),
  GetPage(
    name: AppRoutes.login,
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: AppRoutes.signup,
    page: () => const SignUpScreen(),
  ),
  GetPage(
    name: AppRoutes.forgetPassword,
    page: () => const CheckEmailScreen(),
  ),
  GetPage(
    name: AppRoutes.resetPassword,
    page: () => const ResetPasswordScreen(),
  ),
  GetPage(
    name: AppRoutes.verifyCode,
    page: () => const VerifyCodeScreen(),
  ),
  GetPage(
    name: AppRoutes.successSignUp,
    page: () => const SuccessSignUp(),
  ),
  GetPage(
    name: AppRoutes.successPasswordReset,
    page: () => const SuccessPasswordReset(),
  ),
  GetPage(
    name: AppRoutes.verifySignUpCode,
    page: () => const VerifySignUpCode(),
  ),

  // ========================= Home ========================= //
  GetPage(
    name: AppRoutes.home,
    page: () => const HomeScreen(),
  ),

  GetPage(
    name: AppRoutes.items,
    page: () => const ItemsScreen(),
  ),

  GetPage(
    name: AppRoutes.productDetails,
    page: () => const ProductDetailsScreen(),
  ),
  GetPage(
    name: AppRoutes.favorite,
    page: () => const FavoriteScreen(),
  ),
  GetPage(
    name: AppRoutes.cart,
    page: () => const CartScreen(),
  ),
  GetPage(
    name: AppRoutes.address,
    page: () => const AddressScreen(),
  ),
  GetPage(
    name: AppRoutes.addAddress,
    page: () => const AddAddressScreen(),
  ),

  GetPage(
    name: AppRoutes.addAddressDetails,
    page: () => const AddAddressDetailsScreen(),
  ),

  GetPage(name: AppRoutes.checkout, page: () => const CheckoutScreen()),

  // ========================= Order ========================= //
  GetPage(
      name: AppRoutes.pendingOrders, page: () => const PendingOrdersScreen()),
  GetPage(
      name: AppRoutes.archiveOrders, page: () => const ArchiveOrdersScreen()),
  GetPage(
      name: AppRoutes.ordersDetails, page: () => const OrdersDetailsScreen()),
  GetPage(
      name: AppRoutes.orderTracking, page: () => const OrderTrackingScreen()),
  // ========================= Notification ========================= //
  GetPage(name: AppRoutes.notification, page: () => const NotificationScreen()),

  // ========================= Offers ========================= //
  GetPage(name: AppRoutes.offers, page: () => const OffersScreen()),
];
