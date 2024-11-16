import 'package:get/get.dart';
import 'package:universe_soft_it/repository/faculty_repository.dart';

import '../models/faculty_model.dart';


class FacultyViewModel extends GetxController {
  final RxBool _inProgress = false.obs;
  final RxBool _isSuccess = false.obs;
  final RxString _errorMessage = ''.obs;

   final RxList <FacultyMemberModel> _allFacultyList = <FacultyMemberModel>[].obs;
   final RxList <FacultyMemberModel> _showingFacultyList = <FacultyMemberModel>[].obs;

  // Public getters
  bool get inProgress => _inProgress.value;
  bool get isSuccess => _isSuccess.value;
  String get errorMessage => _errorMessage.value;
  List<FacultyMemberModel> get allFacultyList => _allFacultyList;
  List<FacultyMemberModel> get showingFacultyList => _showingFacultyList;


  @override
  void onInit() {
    super.onInit();
    getFacultyMember();
    _showingFacultyList.assignAll(_allFacultyList);  // Initially show all courses
  }

  Future<bool> getFacultyMember() async {
    _allFacultyList.clear();
    _inProgress.value = true;
    update();

    final dynamic response = await FacultyRepository.getFaculty();

    if (response.isSuccess) {
      final List<dynamic> data = response.responseData;

      _allFacultyList.addAll(
          data.map((item) => FacultyMemberModel.fromJson(item)).toList()
      );
      _showingFacultyList.assignAll(_allFacultyList);  // Update showingProduct
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
      _showingFacultyList.assignAll(_allFacultyList);  // Reset to show all courses
    } else {
      _showingFacultyList.assignAll(
        _allFacultyList.where((faculty) =>
        faculty.name?.toLowerCase().contains(query.toLowerCase()) ?? false
        ).toList(),
      );
    }
  }
}
