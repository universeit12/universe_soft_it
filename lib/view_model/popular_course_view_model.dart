
import 'package:get/get.dart';
import 'package:universe_soft_it/repository/popular_course_repository.dart';
import '../models/popular_course_model.dart';

class PopularCourseViewModel extends GetxController {
  final RxBool _inProgress = false.obs;
  final RxBool _isSuccess = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxList<PopularCourseModel> _popularCourseList = <PopularCourseModel>[].obs;
  final RxList<PopularCourseModel> _showingProduct = <PopularCourseModel>[].obs;

  // Public getters
  bool get inProgress => _inProgress.value;
  bool get isSuccess => _isSuccess.value;
  String get errorMessage => _errorMessage.value;
  List<PopularCourseModel> get popularCourseList => _popularCourseList;
  List<PopularCourseModel> get showingProduct => _showingProduct;

  @override
  void onInit() {
    super.onInit();
    getPopularCourse();
    _showingProduct.assignAll(_popularCourseList);  // Initially show all courses
  }

  Future<bool> getPopularCourse() async {
    _popularCourseList.clear();
    _inProgress.value = true;
    update();

    final dynamic response = await PopularCourseRepository.getPopularCourse();

    if (response.isSuccess) {
      final List<dynamic> data = response.responseData;

      _popularCourseList.addAll(
          data.map((item) => PopularCourseModel.fromJson(item)).toList()
      );
      _showingProduct.assignAll(_popularCourseList);  // Update showingProduct
      _isSuccess.value = true;
    } else {
      _errorMessage.value = response.errorMessage ?? 'Unknown error';
      _isSuccess.value = false;
    }
    _inProgress.value = false;
    update();
    return _isSuccess.value;
  }

  // Filter function to search for courses
  void filterCourses(String query) {
    if (query.isEmpty) {
      _showingProduct.assignAll(_popularCourseList);  // Reset to show all courses
    } else {
      _showingProduct.assignAll(
        _popularCourseList.where((course) =>
        course.title?.toLowerCase().contains(query.toLowerCase()) ?? false
        ).toList(),
      );
    }
  }
}
