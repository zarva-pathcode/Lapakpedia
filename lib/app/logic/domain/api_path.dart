import 'package:flutter_app/app/logic/config/app_module.dart';

class ApiPath {
  static Uri googleLogin = Uri.parse(AppModule.BaseURL + "/google_login.php");
  static Uri manualLogin = Uri.parse(AppModule.BaseURL + "/manual_login.php");
  static Uri register = Uri.parse(AppModule.BaseURL + "/register.php");
  static Uri getAllData = Uri.parse(AppModule.BaseURL + "/get_all_product.php");
  static Uri createData = Uri.parse(AppModule.BaseURL + "/add_product.php");
  static Uri editData = Uri.parse(AppModule.BaseURL + "/edit_product.php");
  static Uri deleteData = Uri.parse(AppModule.BaseURL + "/delete_product.php");
  static Uri addToCart = Uri.parse(AppModule.BaseURL + "/add_cart_item.php");
  static Uri addTmpCart = Uri.parse(AppModule.BaseURL + "/add_tmp_cart.php");
  static Uri updateCartQty =
      Uri.parse(AppModule.BaseURL + "/update_cart_qty.php");
  static Uri cartCheckout = Uri.parse(AppModule.BaseURL + "/checkout.php");
  static Uri getProductCategory =
      Uri.parse(AppModule.BaseURL + "/get_product_category.php");
  static Uri addDeleteFavorite =
      Uri.parse(AppModule.BaseURL + "/add_no_login_favourite.php");
  static Uri getAllTmpCart(String uniqueId) =>
      Uri.parse(AppModule.BaseURL + "/get_all_tmp_cart.php?uniqueId=$uniqueId");
  static Uri getTotalCart(String uniqueId) =>
      Uri.parse(AppModule.BaseURL + "/get_total_cart.php?uniqueId=$uniqueId");
  static Uri getSumTotalCart(String uniqueId) => Uri.parse(
      AppModule.BaseURL + "/get_sum_total_cart.php?uniqueId=$uniqueId");
  static Uri getFavorite(String deviceId) => Uri.parse(
      AppModule.BaseURL + "/get_no_login_favourite.php?deviceInfo=$deviceId");
  static Uri getAllHistoty(String idUsers) =>
      Uri.parse(AppModule.BaseURL + "/get_all_history.php?idUsers=$idUsers");
}
