

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:universe_soft_it/widget/all_blog.dart';
import 'package:universe_soft_it/widget/custom_text_button.dart';
import 'package:universe_soft_it/widget/custom_text_filed.dart';


import '../../../component/bottom_app_bar.dart';

import '../../blog/model/blog_model.dart';

class BlogDetails extends StatefulWidget {
   const BlogDetails(blogs, {super.key,required this.blog});

  final BlogModel blog;

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final commentController = TextEditingController();


    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(8.0.r),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AllBlog()));
                        },

                          child: Icon(Icons.arrow_back,color: Colors.grey.shade800,)),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.all(8.0.r),
                          child: Icon(Icons.share,color: Colors.grey.shade800,),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(8.0.r),
                          child: Icon(Icons.shopping_cart,color: Colors.grey.shade800,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.h),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        child: Image.network(widget.blog.blogImageUrl.toString())),
          
                  ],
                ),
              ),
               SizedBox(height: 20.h,),
              Container(
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r)
                    ),
                  ),
          
                  child: Padding(
                    padding:  EdgeInsets.only(top: 20.h,left: 20.h,right: 20.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              color:Colors.red,
                    
                                child: Text(widget.blog.date.toString(),style: const TextStyle(color: Colors.white),)),
                            Text(widget.blog.title.toString(),style:  TextStyle(fontSize: 15.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),),
                          ],
                        ),
                    
                    
                   
                        SizedBox(height: 40.h,),
                        Text("Blog details",style: TextStyle(fontSize: 19.sp,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10.h,),
                        Html(data:widget.blog.description.toString(),
                        ),




                        SizedBox(height: 30.h,),
                        Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Leave a comment",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
                            SizedBox(height: 20.h,),
                            CustomTextField(controller: nameController,
                                hintext: "Name", bordercolor: Colors.black,
                              sufixIcon: const Icon(Icons.person),
                            keyboardtype: TextInputType.name,),
                            SizedBox(height: 10.h,),
                            CustomTextField(controller: commentController, hintext: "Leave a comment",
                                bordercolor: Colors.black, sufixIcon: const Icon(Icons.email_outlined),),

                            SizedBox(height: 10.h,),
                            CustomTextButton(text: "Submit", onTap: (){

                            }),
                          ],
                        ),
                    
                    
                    
                    
                    
                      ],
                    ),
                  )),
            ],
          ),
        ),
        bottomNavigationBar: const BottomApp(selectedItem: 1,),
      ),

    );
  }

}
