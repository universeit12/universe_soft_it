

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:universe_soft_it/view/all_blog_screen.dart';
import 'package:universe_soft_it/view/all_faculty_screen.dart';
import 'package:universe_soft_it/view/login_screen1.dart';
import 'package:universe_soft_it/view/notification_screen.dart';

import 'package:universe_soft_it/view/home_screen.dart';
import 'package:universe_soft_it/view/splash_screen.dart';
import 'package:universe_soft_it/view/all_course_screen.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'view/free_seminar_screen.dart';

import 'view/online_admission_screen.dart';
import 'view/seminar_screen.dart';

Future<void> main() async {
  // Initialization for get storage
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("b172ee95-97e6-45b8-a6a7-a0d6011a84ff");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
  await GetStorage.init();
  runApp(const MyApp());

}






