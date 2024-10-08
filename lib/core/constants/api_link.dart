class ApiLink {
  static const String stripePublishableKey =
      "pk_test_51Q5uITRxA46rh2n2gHFNhh4Y162HcrFlZiuxd21s86dqs751IVhhFOG7Xf2XCyj9TsQzFFUjtRbFJc2zwuRjsmJI00rnin5Lj4";
  static String server = "http://10.0.2.2/ecommerce_from_host";
  static String categoriesImageFolder = "$server/upload/categories/";
  static String itemsImageFolder = "$server/upload/items/";

  // ====================== Test ======================== //
  static String test = "$server/test.php";

  // ====================== Auth ===================== //
  static String signUp = "$server/auth/signup.php";
  static String login = "$server/auth/login.php";
  static String verifySignUpCode = "$server/auth/verifycode.php";
  static String resentVerifyCode = "$server/auth/resentverifycode.php";

  // ====================== Forget Password ===================== //
  static String checkemail = "$server/auth/forget_password/checkemail.php";
  static String resetPassword =
      "$server/auth/forget_password/reset_password.php";
  static String verifyCode = "$server/auth/forget_password/verifycode.php";

  // ====================== Home ======================== //
  static String home = "$server/home.php";
  static String search = "$server/search.php";

  static String items = "$server/items/items.php";

  // ====================== Favorite ======================= //
  static String addFavorite = "$server/favorite/addtofavorite.php";
  static String removeFavorite = "$server/favorite/removefromfavorite.php";
  static String deleteFavorite = "$server/favorite/deletefavorite.php";
  static String favoriteView = "$server/favorite/view.php";

  // ====================== Cart ======================= //
  static String cartView = "$server/cart/view.php";
  static String addCart = "$server/cart/add.php";
  static String deleteCart = "$server/cart/delete.php";
  static String getCountCart = "$server/cart/getcountitems.php";

  // ====================== Address ======================= //
  static String addressView = "$server/address/view.php";
  static String addAddress = "$server/address/add.php";
  static String deleteAddress = "$server/address/delete.php";
  static String updateAddress = "$server/address/update.php";

  // ====================== Coupon ======================= //
  static String checkCoupon = "$server/coupon/checkCoupon.php";

  // ====================== Order ======================= //
  static String checkoutOrder = "$server/order/checkout.php";
  static String pendingOrder = "$server/order/pending.php";
  static String archiveOrder = "$server/order/archive.php";
  static String orderDetails = "$server/order/details.php";
  static String deleteOrder = "$server/order/delete.php";
  static String orderRating = "$server/order/rating.php";

  // ====================== Notification ======================= //
  static String notificationView = "$server/notification/view.php";

  // ====================== Offers ======================= //

  static String offers = "$server/offers.php";
}
