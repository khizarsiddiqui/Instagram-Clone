import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/image_model.dart';

class ImageController extends GetxController {
  var isLoading = false.obs;
  final RxList<ImageModel> imageModel = <ImageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchImages();
  }

  Future<void> fetchImages() async {
    isLoading.value = true;
    try {
      var response = await http.get(
        Uri.parse('https://api.escuelajs.co/api/v1/categories'),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List<dynamic>;
        imageModel.value =
            jsonData.map((item) => ImageModel.fromJson(item)).toList();
        print("Image response: $imageModel");
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
