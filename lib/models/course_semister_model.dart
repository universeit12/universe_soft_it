class CourseSemesterModel {
  String? sId;
  String? courseId;
  String? mainCourseId;
  String? semesterTitle;
  List<Subjects>? subjects;

  CourseSemesterModel(
      {this.sId,
        this.courseId,
        this.mainCourseId,
        this.semesterTitle,
        this.subjects});

  CourseSemesterModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    courseId = json['courseId'];
    mainCourseId = json['mainCourseId'];
    semesterTitle = json['semesterTitle'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['courseId'] = courseId;
    data['mainCourseId'] = mainCourseId;
    data['semesterTitle'] = semesterTitle;
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  int? id;
  String? name;
  String? credit;

  Subjects({this.id, this.name, this.credit});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    credit = json['credit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['credit'] = credit;
    return data;
  }
}