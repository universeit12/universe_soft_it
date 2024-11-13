import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../models/blog_model.dart';
import '../resource/constant_string.dart';

class NotificationController extends GetxController {
  var newBlogs = <BlogModel>[].obs; // List of new blogs
  var notificationCount = 0.obs; // Notification counter
  var readStatus = <bool>[].obs; // Read status for each blog (false = unread)
  final box = GetStorage(); // Initialize GetStorage

  @override
  void onInit() {
    super.onInit();
    fetchBlogs(); // Fetch blogs when the controller is initialized
  }

  // Fetch blogs from API
  Future<void> fetchBlogs() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/blog'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        var blogs = data.map((blog) => BlogModel.fromJson(blog)).toList();

        newBlogs.value = blogs;

        // Load read statuses from GetStorage or initialize as false
        readStatus.value = List<bool>.generate(
          blogs.length,
              (index) => box.read('blog_${blogs[index].sId}_read') ?? false,
        );

        // Calculate unread blogs count for the notification
        notificationCount.value = readStatus.where((read) => !read).length;
      }
    } catch (e) {
      debugPrint('Error fetching blogs: $e');
    }
  }

  // Mark a blog as read and persist the state
  void markBlogAsRead(int index) {
    if (!readStatus[index]) { // If the blog is unread
      readStatus[index] = true; // Mark as read
      box.write('blog_${newBlogs[index].sId}_read', true); // Persist in GetStorage
      notificationCount.value--; // Decrease notification count
    }
  }
}
