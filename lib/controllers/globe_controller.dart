import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/globe_model.dart';

class GlobeController extends GetxController {
  var isLoading = false.obs;
  final RxList<GlobeModel> globeModel = <GlobeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeeds();
  }

  Future<void> fetchFeeds() async {
    isLoading.value = true;
    try {
      var response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List<dynamic>;
        globeModel.value = jsonData.map((item) => GlobeModel.fromJson(item)).toList();
        print(globeModel);
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
    } finally {
      isLoading.value = false;
    }
  }
}
