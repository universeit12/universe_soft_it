

import '../model/course.dart';
import '../model/course_category.dart';
import '../model/faculty_member.dart';
import '../model/lecture.dart';
import '../model/section.dart';


class CourseDataProvider {
  //Here I have already created courses & section list which we will we using hence forth

  //Section List
  static List<Section> sectionList = [
    Section("Introduction", [
      Lecture("Introduction", "01:48 mins"),
      Lecture("What is Flutter", "05:54 mins"),
      Lecture("Understanding Flutter Architecture", "04:45 mins"),
      Lecture("Flutter Alternatives", "06:10 mins"),
    ]),
    Section("Flutter Basics", [
      Lecture("Module Introduction", "02:25 mins"),
      Lecture("Creating New Project", "05:17 mins"),
      Lecture("Dart Basics", "17:20 mins"),
      Lecture("Dart Fundamentals", "11:10 mins"),
      Lecture("Flutter App Basic", "07:40 mins"),
    ]),
    Section("Layouts", [
      Lecture("Module Introduction", "02:25 mins"),
      Lecture("Creating New Project", "05:17 mins"),
      Lecture("Flutter App Basic", "07:40 mins"),
    ]),
    Section("Responsive & Adaptive UI", [
      Lecture("Module Introduction", "02:25 mins"),
      Lecture("Dart Basics", "17:20 mins"),
      Lecture("Dart Fundamentals", "11:10 mins"),
      Lecture("Flutter App Basic", "07:40 mins"),
    ]),
    Section("Builing Real App", [
      Lecture("Module Introduction", "02:25 mins"),
      Lecture("Creating New Project", "05:17 mins"),
      Lecture("Flutter App Basic", "07:40 mins"),
    ]),
    Section("Responsive & Adaptive UI", [
      Lecture("Module Introduction", "02:25 mins"),
      Lecture("Dart Basics", "17:20 mins"),
      Lecture("Dart Fundamentals", "11:10 mins"),
      Lecture("Flutter App Basic", "07:40 mins"),
    ]),
  ];

  //Course List
  static List<Course> courseList = [
    Course(
        "1",
        "Flutter Master class",
        "assets/images/course/programming1.png",
        "This complete flutter development course from beginner to expert. Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.",
        "Wali Ullah Ripon",
        "01-Jan-2022",
        4.2,

        CourseCategory.programming,
        100,
        '2.5 Hours',
        15,
        sectionList),
    Course(
        "2",
        "Flutter with Firebase",
        "assets/images/course/programming4.png",
        "Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.",
        "Wali Ullah Ripon",
        "01-Apr-2022",
        4.5,

        CourseCategory.programming,
        50,
        '3 Hours',
        10,
        sectionList),
    Course(
        "3",
        "Complete Web 3.0",
        "assets/images/course/programming2.png",
        "Welcome to Become a Blockchain Developer with Ethereum and Solidity! This course is a complete introduction to decentralized application (Dapp) development.",
        "Perfect Academy",
        "01-Mar-2022",
        5,

        CourseCategory.programming,
        75,
        '2.7 Hours',
        15,
        sectionList),
    Course(
        "4",
        "Learn Programming Trick",
        "assets/images/course/programming3.png",
        "One of the common and basic questions among students or someone who wants to learn code is “How can I learn to code fast and make a career as a programmer?”. Whether you are a student, fresher or experienced person trying to switch your job in programming you will definitely try to find tips and tricks to learn programming quickly and effectively",
        "Effortless Code Learning",
        "01-Jan-2022",
        4,

        CourseCategory.programming,
        40,
        '5 Hours',
        30,
        sectionList),
    Course(
        "5",
        "Complete React Course",
        "assets/images/course/programming5.png",
        "This course is fully up-to-date with React 18 (the latest version of React)!\nIt was completely updated and re-recorded from the ground up - it teaches the very latest version of React with all the core, modern features you need to know!",
        "Effortless Code Learning",
        "01-Jan-2022",
        4.5,

        CourseCategory.programming,
        120,
        '4.3 Hours',
        25,
        sectionList),
    Course(
        "6",
        "Learn Marketing",
        "assets/images/course/marketing1.png",
        "This is complete marketing master class. In this course, you will learn how to increase sales, approach new clients.",
        "ECL",
        "01-MAR-2022",
        4.2,

        CourseCategory.marketing,
        150,
        '4 Hours',
        20,
        sectionList),
    Course(
        "7",
        "Marketing MasterClass",
        "assets/images/course/marketing2.png",
        "You're looking for a complete digital marketing course to teach you everything you need to become a digital marketing expert, right?",
        "Effortless Code Learning",
        "01-Jan-2022",
        4.7,

        CourseCategory.marketing,
        80,
        '4.2 Hours',
        21,
        sectionList),
    Course(
        "8",
        "How to Increase Sales",
        "assets/images/course/marketing3.png",
        "You're looking for a complete digital marketing course to teach you everything you need to become a digital marketing expert, right?",
        "Effortless Code Learning",
        "01-Apr-2022",
        4.3,

        CourseCategory.marketing,
        100,
        '4.5 Hours',
        20,
        sectionList),
    Course(
        "9",
        "Marketing Strategy",
        "assets/images/course/marketing4.png",
        "In this course, you will learn various marketing strategy",
        "Effortless Code Learning",
        "01-June-2022",
        5,

        CourseCategory.marketing,
        120,
        '3.5 Hours',
        32,
        sectionList),
    Course(
        "10",
        "Invest Money Wisely",
        "assets/images/course/finance1.png",
        "In this course, you will learn invest money wisely in various categories. Learn basic of capital market, other debt options.",
        "Effortless Code Learning",
        "15-Feb-2022",
        5,

        CourseCategory.finance,
        100,
        '6 Hours',
        35,
        sectionList),
    Course(
        "11",
        "Crypto Technical Analysis",
        "assets/images/course/finance2.png",
        "In this course, you will learn thorough crypto technical analysis. It will covers basic understanding on various crypto currencies. Volatility in crypto market.",
        "Effortless Code Learning",
        "15-Feb-2022",
        4.6,

        CourseCategory.finance,
        90,
        '3 Hours',
        22,
        sectionList),
    Course(
        "12",
        "All about Crypto",
        "assets/images/course/finance3.png",
        "In this course, you will learn thorough crypto technical analysis. It will covers basic understanding on various crypto currencies. Volatility in crypto market.",
        "Effortless Code Learning",
        "20-Mar-2022",
        4.8,

        CourseCategory.finance,
        75,
        '3.5 Hours',
        28,
        sectionList),
  ];

  //Course List
  static List<FacultyMember> facultyMemberList = [
    FacultyMember(
        "1",
        "assets/images/course/programming1.png",
        "Abdul Karim",
        "abdulkarim@gmail.com",
    ),
    FacultyMember(
      "2",
      "assets/images/course/programming1.png",
      "Mr Salam Molla",
      "salammolla@gmail.com",
    ),
    FacultyMember(
      "3",
      "assets/images/course/programming1.png",
      "Mr. Rahim Uddin",
      "rahimuddin@gmail.com",
    ),


  ];
}
