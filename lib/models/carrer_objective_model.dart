class CarrerObjectiveModel {
  String? sId;
  List<ObjectiveFAQ>? objectiveFAQ;
  String? courseId;

  CarrerObjectiveModel({this.sId, this.objectiveFAQ, this.courseId});

  CarrerObjectiveModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['objectiveFAQ'] != null) {
      objectiveFAQ = <ObjectiveFAQ>[];
      json['objectiveFAQ'].forEach((v) {
        objectiveFAQ!.add(ObjectiveFAQ.fromJson(v));
      });
    }
    courseId = json['courseId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (objectiveFAQ != null) {
      data['objectiveFAQ'] = objectiveFAQ!.map((v) => v.toJson()).toList();
    }
    data['courseId'] = courseId;
    return data;
  }
}

class ObjectiveFAQ {
  String? question;
  String? answer;
  int? faqId;

  ObjectiveFAQ({this.question, this.answer, this.faqId});

  ObjectiveFAQ.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
    faqId = json['faqId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['answer'] = answer;
    data['faqId'] = faqId;
    return data;
  }
}