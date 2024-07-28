import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:universe_soft_it/constant/constant.dart';
import 'package:universe_soft_it/presentation/home/view/home_screen.dart';
import '../custom_widget/loading_widget.dart';
import '../presentation/blog_details/view/blog_details_screen.dart';
import '../presentation/blog/model/blog_model.dart';

class Notification1 extends StatefulWidget {
  const Notification1({super.key});


  @override
  State<Notification1> createState() => _NotificationState();
}

class _NotificationState extends State<Notification1> {
  List<BlogModel>  blogList= [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:  Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child:  SingleChildScrollView(
            child: Column(
              children: [
            
                Container(
                  height: 90,
                  width: double.infinity,
                  color: kOrangeColor,
                  child: Row(
                    children: [
                      const SizedBox(width: 10,),
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
            
                      }, icon: const Icon(Icons.arrow_back,size: 30,color: Colors.white,)),
                      const SizedBox(width: 90,),
                      const Center(child: Text("Notification",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,
                      color: Colors.white),)),
            
                    ],
                  ),
                ),
                
            
            
                SizedBox(
                  height: 698,
            
                  child: FutureBuilder(
                      future: getData(),
                      builder: (context,snapshot) {
                        if(snapshot.hasData){
                          return ListView.separated(
                            reverse: true,
                            scrollDirection: Axis.vertical,
                            itemCount: blogList.length,
                            separatorBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Divider(
                                  thickness: 4,
                                ),
                              );
                            },
                            itemBuilder: (context, index) {
                              final blogs = blogList[index];
            
                              return SizedBox(
                                height: 90,
                                width: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    onTap: (){
            
                                      // blog details page
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetails(blogs, blog: blogs),));
            
                                    },
            
                                    leading: Card(
            
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
            
                                      ),
                                      child: Image.network(blogs.blogImageUrl.toString(),height: 50,width: 50,fit: BoxFit.cover,),
                                    ),
                                    subtitle: Text(blogs.author.toString()),
                                    title: Text(blogs.title.toString()),
                                    trailing: Text(blogs.date.toString(),style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(.5),
                                    ),),
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
            ),
          ),
        )
    );
  }
  Future <List<BlogModel>> getData()async{

    final response = await http.get(Uri.parse("https://bifdt-server-ashikur.vercel.app/blog"));

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map<String, dynamic> index in data){
        blogList.add(BlogModel.fromJson(index));
      }
      return blogList;
    }
    else{
      return blogList;
    }


  }
}
