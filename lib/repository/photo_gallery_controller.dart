
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:universe_soft_it/models/photo_galary_model.dart';
import 'package:universe_soft_it/repository/photo_galary_sevices.dart';



class PhotoGalleryController extends GetxController {
  var isLoading = true.obs;
  var galleryImages = <PhotoGalaryImage>[].obs;
  var categories = <String>[].obs;
  var selectedCategory = ''.obs;

  @override
  void onInit() {
    fetchGalleryImages();
    super.onInit();
  }

  void fetchGalleryImages() async {
    try {
      isLoading(true);
      var images = await PhotoGalleryService().fetchGalleryImages();
      galleryImages.assignAll(images);
      categories.assignAll(images.map((e) => e.category!).toSet().toList());
      selectedCategory.value = categories.first; // Select the first category by default
        } catch (e) {
      debugPrint("Error fetching images: $e");
    } finally {
      isLoading(false);
    }
  }

  List<PhotoGalaryImage> getImagesByCategory() {
    if (selectedCategory.value.isEmpty) return galleryImages;
    return galleryImages.where((image) => image.category == selectedCategory.value).toList();
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }
}
