import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:universe_soft_it/utils/routes/route.dart';
import 'package:universe_soft_it/utils/routes/route_name.dart';

import 'bindings/controller_binding.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState> ();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String? screen;
    OneSignal.Notifications.addClickListener((event) {
      final data = event.notification.additionalData;
      screen = data?['screen'];
      if(screen != null){
        navigatorKey.currentState?.pushNamed(screen!);
      }

    });

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        initialRoute: (screen != null)?screen :RouteName.splashScreen,
        onGenerateRoute: Routes.generateRoute,
        initialBinding: ControllerBinders(),




      ),
    );
  }
}