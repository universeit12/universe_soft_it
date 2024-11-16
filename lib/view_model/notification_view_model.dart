import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/blog_model.dart';
import '../repository/notification_repository.dart';

class NotificationViewModel extends GetxController {
  var newBlogs = <BlogModel>[].obs; // List of new blogs
  var notificationCount = 0.obs; // Notification counter
  var readStatus = <bool>[].obs; // Read status for each blog (false = unread)
  final box = GetStorage(); // Initialize GetStorage

  @override
  void onInit() {
    super.onInit();
    fetchBlogs(); // Fetch blogs when the controller is initialized
  }

  @override
  void onReady() {
    super.onReady();
    refreshBlogs(); // Re-check blogs when the user navigates back
  }

  Future<void> fetchBlogs() async {
    try {
      final response = await NotificationRepository.getNotification();

      if (response.isSuccess) {
        List<dynamic> data = response.responseData as List<dynamic>;
        var blogs = data.map((blog) => BlogModel.fromJson(blog)).toList();

        newBlogs.value = blogs;

        // Load read statuses from GetStorage or initialize as false
        readStatus.value = List<bool>.generate(
          blogs.length,
              (index) => box.read('blog_${blogs[index].sId}_read') ?? false,
        );

        // Calculate unread blogs count for the notification
        notificationCount.value = readStatus.where((read) => !read).length;
      } else {
        debugPrint('Error: ${response.errorMessage}');
      }
    } catch (e) {
      debugPrint('Error fetching blogs: $e');
    }
  }

  void refreshBlogs() {
    // Refresh read statuses from GetStorage
    readStatus.value = List<bool>.generate(
      newBlogs.length,
          (index) => box.read('blog_${newBlogs[index].sId}_read') ?? false,
    );

    // Recalculate unread blogs count
    notificationCount.value = readStatus.where((read) => !read).length;
  }

  void markBlogAsRead(int index) {
    if (!readStatus[index]) {
      readStatus[index] = true;
      box.write('blog_${newBlogs[index].sId}_read', true);
      notificationCount.value--;
    }
  }
}
