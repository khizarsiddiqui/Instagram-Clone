import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/home_model.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  final Rx<HomeModel> homeModel = HomeModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchPosts() async {
    isLoading.value = true;
    try {
      var response = await http.get(Uri.parse('https://dummyjson.com/posts'));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as Map<String, dynamic>;
        homeModel.value = HomeModel.fromJson(jsonData);
        print(jsonData);
        // isLoading.value = false;
      } else {
        // Handle the error
        print('Error: ${response.statusCode}');
        // Get.showSnackbar(gradientSnackbar("failure".tr, "Something went wrong!",
        // Colors.orange, Icons.warning_rounded));
      }
    } catch (e) {
      print('Error: $e');
      // Get.showSnackbar(
      //     gradientSnackbar("failure".tr, "$e", Colors.red, Icons.warning_rounded));
      // isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
