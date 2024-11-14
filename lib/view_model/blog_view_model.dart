import 'package:get/get.dart';
import 'package:universe_soft_it/models/blog_model.dart';
import 'package:universe_soft_it/repository/blog_repository.dart';

class BlogViewModel extends GetxController{



  final RxBool _inProgress = false.obs;
  final RxBool _isSuccess = false.obs;
  final RxString _errorMessage = ''.obs;
  final List<BlogModel>  _blogList= [];
  final List<BlogModel> _showBlogList = [];


  // Public getters
  bool get inProgress => _inProgress.value;
  bool get isSuccess => _isSuccess.value;
  String get errorMessage => _errorMessage.value;
  List<BlogModel> get blogList => _blogList;
  List<BlogModel> get showBlogList => _showBlogList;

  @override
  void onInit() {
    super.onInit();
    getBlog();
    _showBlogList.assignAll(_blogList);  // Initially show all courses
  }



  Future<bool> getBlog() async {
    _blogList.clear();
    _inProgress.value = true;
    update();

    final dynamic response = await BlogRepository.getBlog();

    if (response.isSuccess) {
      final List<dynamic> data = response.responseData;

      _blogList.addAll(
          data.map((item) => BlogModel.fromJson(item)).toList()
      );
      _showBlogList.assignAll(_blogList);  // Update showingProduct
      _isSuccess.value = true;
    } else {
      _errorMessage.value = response.errorMessage ?? 'Unknown error';
      _isSuccess.value = false;
    }
    _inProgress.value = false;
    update();
    return _isSuccess.value;
  }


  void filterCourses(String query) {
    if (query.isEmpty) {
      _showBlogList.assignAll(_blogList);  // Reset to show all courses
    } else {
      _showBlogList.assignAll(
        _blogList.where((course) =>
        course.title?.toLowerCase().contains(query.toLowerCase()) ?? false
        ).toList(),
      );
    }
  }

}