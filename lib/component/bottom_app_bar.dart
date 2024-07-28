import 'package:flutter/material.dart';
import 'package:universe_soft_it/constant/constant.dart';
import 'package:universe_soft_it/routes/routes_name.dart';


class BottomApp extends StatelessWidget {
  const BottomApp({super.key, required this.selectedItem});

  final int selectedItem;

  @override
  Widget build(BuildContext context) {
    return   BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              openScreen(context, 1);

            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Icon(Icons.home,color: getSelectedColor(1),),
                  const SizedBox(height: 2,),
                  Text("Home",style: TextStyle(fontSize: 13,color: getSelectedColor(1),),),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              openScreen(context, 2);

            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Icon(Icons.play_circle_outline,color: getSelectedColor(2),),
                  const SizedBox(height: 2,),
                  Text("Course",style: TextStyle(fontSize: 13,color: getSelectedColor(2),),),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              openScreen(context, 3);

            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Icon(Icons.event_available_outlined,color: getSelectedColor(3),),
                  const SizedBox(height: 2,),
                  Text("Seminar",style: TextStyle(fontSize: 13,color: getSelectedColor(3),),),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              openScreen(context, 4);

            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Icon(Icons.school,color: getSelectedColor(4),),
                  const SizedBox(height: 2,),
                  Text("Admission",style: TextStyle(fontSize: 13,color: getSelectedColor(4),),),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              openScreen(context, 5);

            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Icon(Icons.person,color: getSelectedColor(5),),
                  const SizedBox(height: 2,),
                  Text("Profile",style: TextStyle(fontSize: 13,color: getSelectedColor(4),),),
                ],
              ),
            ),
          ),
        ],
      ),

    );


  }
  Color getSelectedColor(int optionIndex){
    return (selectedItem == optionIndex)?kOrangeColor:kPrimaryColor;

  }

  void openScreen(BuildContext context, int selectedOptionNo ){
    String routeName = RouteName.courseHome;
    switch(selectedOptionNo){
      case 2:
        routeName = RouteName.allPopularCourse;
        break;

      case 3:
        routeName = RouteName.seminarScreen;
        break;

      case 4:
        routeName = RouteName.onlineAdmission;
        break;

      case 5:
        routeName = RouteName.profileScreen;
        break;

    }
    Navigator.pushReplacementNamed(context, routeName);
  }
}
