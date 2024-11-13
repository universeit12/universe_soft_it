
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class CallNow{

  static Uri whatsapp = Uri.parse("https://wa.me/+8801629171717");


  static showDialog(){

    Get.defaultDialog(
      backgroundColor: Colors.black38,
      titleStyle: const TextStyle(color: Colors.white),
      title:"Call Now!",
      content: const Text("Need Instant Support!",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500),),
      actions: [
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white
          ),
          onPressed: (){
            launchUrl(whatsapp);
          }, label: const Text("Whatsapp"),icon: const Icon(Icons.call),),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white
          ),
          onPressed: (){
            makePhoneCallWithPermission();

          }, label: const Text("Phone",),icon: const Icon(Icons.call),),



      ],
    );
  }

  static void makePhoneCallWithPermission() async {
    var status = await Permission.phone.status;
    if (status.isGranted) {
      final Uri callUrl = Uri(scheme: 'tel', path: '+8801629171717');
      if (await canLaunchUrl(callUrl)) {
        await launchUrl(callUrl);
      } else {
        debugPrint('Could not launch $callUrl');
      }
    } else if (status.isDenied) {
      // Request permission
      if (await Permission.phone.request().isGranted) {
        // Make the call after permission is granted
        makePhoneCallWithPermission();
      }
    }
  }


  static Future<void> makePhoneCall(number) async {
    var status = await Permission.phone.status;
    if (status.isGranted) {
      final Uri callUrl = Uri(scheme: 'tel', path: number);
      if (await canLaunchUrl(callUrl)) {
        await launchUrl(callUrl);
      } else {
        debugPrint('Could not launch $callUrl');
      }
    } else if (status.isDenied) {
      // Request permission
      if (await Permission.phone.request().isGranted) {
        // Make the call after permission is granted
        makePhoneCallWithPermission();
      }
    }

  }




}