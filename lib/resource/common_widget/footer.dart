

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import 'call_now_widget.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SizedBox(
            width: 30.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/offer/BIFDT-logo.png",
                height: 100.h,
                width: 170.w,
              ),
              Row(
                children: [
                  CustomisedIconButton(imagePath: "assets/images/offer/twiter1.png",onTap: () async {
                    _launchFacebookPage('https://www.instagram.com/sharifahmedseraji/');

                  },),
                  SizedBox(
                    width: 13.h,
                  ),
                  CustomisedIconButton(imagePath: "assets/images/offer/youtube1.jpg",height: 32,width: 30,onTap: (){
                    _launchFacebookPage('https://www.youtube.com/channel/UCiPQeQtjSuNTbSl13i0bxUw?view_as=subscriber');
                  },),
                  SizedBox(
                    width: 13.h,
                  ),
                  CustomisedIconButton(imagePath: "assets/images/offer/facebook.png",onTap: () async {
                    _launchFacebookPage('https://www.facebook.com/bifdt.info/');
                  },),

                  SizedBox(
                    width: 13.h,
                  ),
                  CustomisedIconButton(imagePath: "assets/images/offer/linkedin.png",height: 30,width: 30,onTap: (){
                    _launchFacebookPage('https://www.linkedin.com/in/bifdt-edu-a4b851152/');
                  },),

                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "House # 3/GA,Shyamoli,Road # 1. ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Dhaka-1207.",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Email: info@bifdt.info",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            width: 30.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 35.h,
              ),
              Text(
                "Contact Number",
                style: TextStyle(
                    fontSize: 14.sp, color: Colors.white),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomCallButton(
                number: "016-29-17-17-17",
                onTap: () {
                  CallNow.makePhoneCall("+8801629171717");
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomCallButton(
                number: "016-29-18-18-18",
                onTap: () {
                  CallNow.makePhoneCall("+8801629181818");
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomCallButton(
                number: "015-52-64-44-79",
                onTap: () {
                  CallNow.makePhoneCall("+8801552644479");
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomCallButton(
                number: "019-15-67-05-40",
                onTap: () {
                  CallNow.makePhoneCall("+8801915670540");
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomCallButton(
                number: "019-79-79-93-93",
                onTap: () {
                  CallNow.makePhoneCall("+88001979799393");
                },
              ),


              SizedBox(
                height: 5.h,
              ),
              CustomCallButton(
                number: "019-79-79-94-94",
                onTap: () {
                  CallNow.makePhoneCall("+8801979799494");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomisedIconButton extends StatelessWidget {
  const CustomisedIconButton({
    super.key,
    required this.imagePath,
    this.height = 25,
    this.width = 25, this.onTap,
  });
  final String imagePath;
  final double height, width;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Image.asset(
          imagePath,
          height: height.h,
          width:width.w,
        ));
  }
}

class CustomCallButton extends StatelessWidget {
  const CustomCallButton({
    super.key,
    required this.number,
    this.onTap,
  });

  final String number;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            Icons.call,
            size: 11.sp,
            color: Colors.white,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            number,
            style: TextStyle(fontSize: 11.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

void _launchFacebookPage(url) async {
  final Uri facebookUrl = Uri.parse(url);
  if (await canLaunchUrl(facebookUrl)) {
    await launchUrl(facebookUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $facebookUrl';
  }
}