class SeminarModel {
  String? sId;
  String? topic;
  String? date;
  String? time;

  SeminarModel({this.sId, this.topic, this.date, this.time});

  SeminarModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    topic = json['topic'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['topic'] = topic;
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}