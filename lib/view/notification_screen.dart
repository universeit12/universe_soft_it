import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../models/blog_model.dart';
import 'blog_details_screen.dart';
import '../repository/notification_controller.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class NotificationScreen extends StatelessWidget {
  final NotificationController notificationController = Get.find();

  NotificationScreen({super.key});

  // Helper function to get time difference
  String timeAgo(DateTime date) {
    DateTime.now().difference(date);

      return DateFormat('MMM dd, yyyy').format(date);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Obx(() {
        if (notificationController.newBlogs.isEmpty) {
          return const Center(child: Text("No new blogs"));
        } else {
          return ListView.builder(
            itemCount: notificationController.newBlogs.length,
            itemBuilder: (context, index) {
              // Access the blogs in reverse order
              BlogModel blog = notificationController.newBlogs.reversed.toList()[index];
              bool isUnread = !notificationController.readStatus.reversed.toList()[index];

              // Parse the date string into a DateTime object
              DateTime blogDate = DateTime.parse(blog.date ?? DateTime.now().toString());

              return ListTile(
                leading: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Image.network(
                    blog.blogImageUrl.toString(),
                    height: 50.h,
                    width: 50.w,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(blog.title ?? ''),
                subtitle: Text(timeAgo(blogDate)), // Use the timeAgo function
                trailing: isUnread
                    ? Icon(Icons.fiber_manual_record, color: Colors.red, size: 12.sp)
                    : null,
                onTap: () {
                  // Mark the blog as read and navigate to BlogDetails screen
                  int reversedIndex = notificationController.newBlogs.length - 1 - index;
                  notificationController.markBlogAsRead(reversedIndex);
                  Get.to(() => BlogDetails(blog: blog));  // Pass the selected blog to the details screen
                },
              );
            },
          );
        }
      }),
    );
  }

}
