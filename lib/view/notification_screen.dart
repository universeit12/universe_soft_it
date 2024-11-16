import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_soft_it/view_model/notification_view_model.dart';
import 'blog_details_screen.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
class NotificationScreen extends StatelessWidget {


  const NotificationScreen({super.key});

  // Helper function to get time difference
  String timeAgo(DateTime date) {
    DateTime.now().difference(date);

      return DateFormat('MMM dd, yyyy').format(date);

  }

  @override
  Widget build(BuildContext context) {
    final  controller = Get.find<NotificationViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Obx(() {
        if (controller.newBlogs.isEmpty) {
          return const Center(child: Text("No new blogs"));
        } else {
          return ListView.builder(
            itemCount: controller.newBlogs.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(controller.newBlogs[index].blogImageUrl.toString()),),
                title: Text(controller.newBlogs[index].title??""),
                subtitle: Text(controller.newBlogs[index].date??""),
                trailing: Icon(
                  controller.readStatus[index] ? Icons.check : Icons.notifications,
                  color: controller.readStatus[index] ? Colors.green : Colors.red,
                ),
                onTap: () {
                  controller.markBlogAsRead(index);
                  Get.to(() =>BlogDetails(blog: controller.newBlogs[index]));
                },
              );
            },);


        }
      }),
    );
  }

}
