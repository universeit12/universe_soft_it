import 'package:flutter/material.dart';

class CourseSearch extends StatelessWidget {
  const CourseSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      decoration: InputDecoration(
        hintText: "Search for courses",
        hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: const Padding(
          padding:  EdgeInsets.only(left: 10),
          child: Icon(Icons.search,size: 20,),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        filled: true,
        fillColor: Colors.white
      ),
    );
  }
}
