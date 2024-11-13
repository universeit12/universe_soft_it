
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:universe_soft_it/resource/constant.dart';
import 'package:universe_soft_it/repository/blog_controller.dart';
import 'package:universe_soft_it/view/blog_details_screen.dart';
import 'package:universe_soft_it/youtube_player/youtube_player.dart';

import '../resource/common_widget/loading_widget.dart';
import '../resource/constant_string.dart';



class BlogScreen extends StatefulWidget {
   const BlogScreen({super.key});



  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  // Create sample data


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BlogController());



    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(blog,style: TextStyle(fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,fontFamily: "FontMain2",letterSpacing: 0.5
            )),


            TextButton(onPressed: (){
              
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const AllBlog(),));
              Get.toNamed('/allBlogScreen');

            }, child:  Text(seeAll,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,fontFamily: "FontMain2",letterSpacing: 0.5),))


          ],
        ),
        SizedBox(height: 10.h,),

        //
        //
        // Show our popular course

        SizedBox(
          height: 255.h,

          child: FutureBuilder(
            future: controller.getData(),
            builder: (context,snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.blogList.length>20?
                  20:controller.blogList.length,
                  itemBuilder: (context, index) {
                    final blogs = controller.blogList[index];

                    return SizedBox(
                      width: 250.w,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),

                        ),
                        child: InkWell(
                          onTap: (){

                            // Here we will open details our page
                            
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetails( blog: blogs),));




                          },
                          child: Column(


                            children: [
                              blogs.videoUrl == null || blogs.videoUrl!.isEmpty
                                  ?Image.network(controller.blogList[index].blogImageUrl.toString(),height: 120.h,width: 350.w,fit: BoxFit.fill,)
                                  : ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                    child: NetworkVideoPlayer(videoUrl: blogs.videoUrl.toString(),autoplay: false,
                                                                    isIconButton: false,
                                                                    height: 120.h,width: 350.w,fit: BoxFit.fill,
                                                                  ),
                                  ),
                              SizedBox(height: 5.h,),

                              Expanded(
                                child: Center(
                                  child: Text(controller.blogList[index].title.toString(),style: TextStyle(fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800,fontFamily: "FontMain2",letterSpacing: 0.5
                                  ),),
                                ),
                              ),


                              Expanded(
                                child: Html(data: controller.blogList[index].description,
                                  style: {
                                    "*": Style(
                                      maxLines: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                      color: Colors.grey.shade800,

                                      fontSize: FontSize(12.0.sp),
                                        fontFamily: "FontMain4",letterSpacing: 0.5,
                                      fontWeight: FontWeight.bold


                                    ),
                                  },
                                ),
                              ),



                              SizedBox(height: 5.h,),



                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 30.h,width: 95.w,
                                    decoration: BoxDecoration(
                                      color: kOrangeColor,
                                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                    ),

                                    child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetails( blog: blogs)));

                                        },
                                        child:  Center(
                                          child: Text(readMore,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                                          fontSize: 14.sp),),
                                        ),
                                    ),
                                  ),

                                  Container(
                                      height: 25.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                        color: kOrangeColor,
                                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                      ),
                                      child: Center(child: Text(controller.blogList[index].date.toString(),style:  TextStyle(fontSize: 12.sp,color: Colors.white),))),
                                ],
                              ),
                              SizedBox(height: 10.h,),


                            ],
                          ),
                        ),
                      ),
                    );

                  },
                );

              }
              else{
                return const CustomLoadingWidget();
              }

            }
          ),
        ),


      ],
    );
  }


}