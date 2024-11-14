
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:universe_soft_it/resource/constant.dart';
import 'package:universe_soft_it/utils/routes/route_name.dart';




class BottomAppBarNavigation extends StatefulWidget {
  const BottomAppBarNavigation({super.key, required this.selectedItem});
  final int selectedItem;

  @override
  State<BottomAppBarNavigation> createState() => _BottomAppBarNavigationState();
}

class _BottomAppBarNavigationState extends State<BottomAppBarNavigation> {
  final List<Widget> navigationItem = [
    const Icon(Icons.home,size: 26,color: Colors.white,),
    const Icon(Icons.play_circle_outline,size: 26,color: Colors.white,),
    const Icon(Icons.article,size: 26,color: Colors.white,),
    const Icon(Icons.event_available_outlined,size: 26,color: Colors.white,),
    const Icon(Icons.school,size: 26,color: Colors.white,),
    const Icon(Icons.logout,size: 26,color: Colors.white,),


  ];



  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      animationDuration: const Duration(milliseconds: 300),
      index: widget.selectedItem,
      buttonBackgroundColor: kOrangeColor,
      backgroundColor:Colors.transparent,
      height: 65,
      color: kOrangeColor,
      items: navigationItem,
      onTap: (index){
        if(index == 0){
          Navigator.pushReplacementNamed(context,RouteName.homeScreen);
        }
        else if(index == 1){
          Navigator.pushReplacementNamed(context, RouteName.allPopularCourse);

        }
        else if(index == 2){
          Navigator.pushReplacementNamed(context,RouteName.allBlogScreen);

        }
        else if(index == 3){
          Navigator.pushReplacementNamed(context, RouteName.seminarScreen);

        }
        else if(index == 4){
          Navigator.pushReplacementNamed(context,RouteName.onlineAdmission);

        }
        else if(index == 5){
          showLogoutDialog(context);

        }


      },
    );
  }


}
void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Do you really want to log out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final box = GetStorage();
              box.remove("login");
              SystemNavigator.pop();
              //Navigator.of(context).pop(); // Close the dialog
              //logout(context); // Call the logout function
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
}
