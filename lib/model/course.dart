

import 'package:universe_soft_it/model/section.dart';

import 'course_category.dart';

class Course {
  final String _id;

  final String _title;

  final String _thumbnailUrl;

  final String _description;

  final String _createdBy;

  final String _createdDate;

  final double _rate;



  final double _price;

  final CourseCategory _courseCategory;

  final String _duration;

  final int _lessonNo;

  final List<Section> _sections;

  Course(
      this._id,
      this._title,
      this._thumbnailUrl,
      this._description,
      this._createdBy,
      this._createdDate,
      this._rate,

      this._courseCategory,
      this._price,
      this._duration,
      this._lessonNo,
      this._sections);




  double get rate => _rate;

  String get createdDate => _createdDate;

  String get createdBy => _createdBy;

  String get description => _description;

  String get thumbnailUrl => _thumbnailUrl;

  String get title => _title;

  String get id => _id;

  CourseCategory get courseCategory => _courseCategory;

  double get price => _price;

  String get duration => _duration;

  int get lessonNo => _lessonNo;

  List<Section> get sections => _sections;
}
