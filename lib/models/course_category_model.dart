class CourseCategoryModel {
  String? sId;
  String? name;
  String? qualification;
  String? courseFee;
  String? durationDetails;
  String? executiveBatch;
  String? regularBatch;
  String? totalClass;
  String? duration;
  String? courseId;
  String? type;

  CourseCategoryModel(
      {this.sId,
        this.name,
        this.qualification,
        this.courseFee,
        this.durationDetails,
        this.executiveBatch,
        this.regularBatch,
        this.totalClass,
        this.duration,
        this.courseId,
        this.type});

  CourseCategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    qualification = json['qualification'];
    courseFee = json['courseFee'];
    durationDetails = json['durationDetails'];
    executiveBatch = json['executiveBatch'];
    regularBatch = json['regularBatch'];
    totalClass = json['totalClass'];
    duration = json['duration'];
    courseId = json['courseId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['qualification'] = qualification;
    data['courseFee'] = courseFee;
    data['durationDetails'] = durationDetails;
    data['executiveBatch'] = executiveBatch;
    data['regularBatch'] = regularBatch;
    data['totalClass'] = totalClass;
    data['duration'] = duration;
    data['courseId'] = courseId;
    data['type'] = type;
    return data;
  }
}