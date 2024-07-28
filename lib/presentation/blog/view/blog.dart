import 'dart:convert';



import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:universe_soft_it/constant/constant.dart';
import 'package:universe_soft_it/presentation/blog/controller/blog_controller.dart';

import 'package:universe_soft_it/presentation/blog_details/view/blog_details_screen.dart';




import 'package:universe_soft_it/widget/all_blog.dart';


import '../../../constant/constant_string.dart';
import '../../../custom_widget/loading_widget.dart';
import '../model/blog_model.dart';


class BlogScreen extends StatefulWidget {
   BlogScreen({super.key});



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
            Text(blog,style: TextStyle(fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800
            )),


            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AllBlog(),));

            }, child:  Text(seeAll,style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold),))


          ],
        ),
        SizedBox(height: 10.h,),

        //
        //
        // Show our popular course

        SizedBox(
          height: 300.h,

          child: FutureBuilder(
            future: controller.getData(),
            builder: (context,snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.blogList.length,
                  itemBuilder: (context, index) {
                    final blogs = controller.blogList[index];

                    return SizedBox(
                      width: 275.w,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: InkWell(
                          onTap: (){

                            // Here we will open details our page
                            
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetails(blogs, blog: blogs),));



                          },
                          child: Column(


                            children: [
                              Image.network(controller.blogList[index].blogImageUrl.toString(),height: 150.h,width: 350.w,fit: BoxFit.fill,),
                              SizedBox(height: 5.h,),

                              Center(
                                child: Text(controller.blogList[index].title.toString(),style: TextStyle(fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800
                                ),),
                              ),


                              Html(data: controller.blogList[index].description,
                                style: {
                                  "*": Style(
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                    color: Colors.grey.shade800,
                                    fontSize: FontSize(12.0.sp),


                                  ),
                                },
                              ),



                              SizedBox(height: 10.h,),



                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 120.w,
                                    color: kOrangeColor,

                                    child: TextButton(



                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetails(blogs, blog: blogs)));

                                        },
                                        child:  Text("Read More",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                                        fontSize: 16.sp),),
                                    ),
                                  ),

                                  Container(
                                      height: 25.h,
                                      width: 70.w,
                                      color: Colors.red,
                                      child: Center(child: Text(controller.blogList[index].date.toString(),style:  TextStyle(fontSize: 12.sp,color: Colors.white),))),
                                ],
                              )


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