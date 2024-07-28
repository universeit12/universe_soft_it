import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:universe_soft_it/presentation/blog_details/view/blog_details_screen.dart';



import 'package:http/http.dart' as http;


import '../component/bottom_app_bar.dart';
import '../custom_widget/loading_widget.dart';
import '../presentation/blog/model/blog_model.dart';


class AllBlog extends StatefulWidget {
  const AllBlog({super.key});

  @override
  State<AllBlog> createState() => _BlocState();
}

class _BlocState extends State<AllBlog> {
  // Create sample data
  List<BlogModel>  blogList= [];

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: const Text("All Blogs",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      body: Container(
        color: Colors.white70,
        child: Column(
          children: [



            //
            //
            // Show our popular course

            SizedBox(
              height: 652.3,

              child: FutureBuilder(
                  future: getData(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                          //gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: blogList.length,
                        itemBuilder: (context, index) {
                          final blogs = blogList[index];

                          return SizedBox(
                            height: 270,

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
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.network(blogList[index].blogImageUrl.toString(),fit:BoxFit.cover,height: 120,width: double.infinity,),


                                    Center(
                                      child: Text(blogList[index].title.toString(),style: TextStyle(fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade800
                                      ),),
                                    ),

                                    Html(data: blogList[index].description.toString(),
                                      style: {
                                        "*": Style(
                                          maxLines: 1,
                                          textOverflow: TextOverflow.ellipsis,
                                          color: Colors.grey.shade800,
                                          fontSize: FontSize(12.0),


                                        ),
                                      },
                                    ),



                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 120,
                                          color: Colors.grey,

                                          child: TextButton(


                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetails(blogs, blog: blogs),));

                                            },
                                            child: const Text("Read More",style: TextStyle(color: Colors.white),),
                                          ),
                                        ),

                                        Container(
                                          height: 20,
                                          width: 70,
                                          color: Colors.red,
                                            child: Center(child: Text(blogList[index].date.toString(),style: const TextStyle(fontSize: 10,color: Colors.white),))),
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
                      return const Center(child: CustomLoadingWidget());
                    }

                  }
              ),
            ),


          ],
        ),
      ),
      bottomNavigationBar: const BottomApp(selectedItem: 1,),
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