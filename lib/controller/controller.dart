import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/model.dart';

import '../services/api_services.dart';

class ShoppingController extends GetxController {
  var isLoading = true.obs;
  List<Shopping>? shopping;
  List<Shopping> addToCartList = [];
  var cartCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    shoppingProducts();
  }

  shoppingProducts() async {
    isLoading.value = true;
    http.Response response = await fetchProducts();

    int responseStatusCode = response.statusCode;
    var responseBody = jsonDecode(response.body);

    print("user profile details response is ap::::::${responseBody}");

    if (responseStatusCode == 200) {
      shopping = shoppingFromJson(response.body);
      isLoading.value = false;
    } else if (responseStatusCode == 200 && responseBody["status"] == 0) {
      // showSnackbar("", responseBody["msg"].toString());
    } else if (responseStatusCode == 500) {
      // showSnackbar("Error", "Server Error");
    }
  }

  cartLength() {
    cartCount.value = addToCartList.length;
  }
}
