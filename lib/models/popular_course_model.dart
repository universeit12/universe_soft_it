class PopularCourseModel {
  String? sId;
  String? title;
  String? subtitle;
  String? videoUrl;
  List<String>? bannerImages;
  List<SubVideos>? subVideos;
  String? notice;
  String? bangla;
  String? admissionNotice;
  String? courseFee;
  String? description;

  PopularCourseModel(
      {this.sId,
        this.title,
        this.subtitle,
        this.videoUrl,
        this.bannerImages,
        this.subVideos,
        this.notice,
        this.bangla,
        this.admissionNotice,
        this.courseFee,
      this.description, required List data});

  PopularCourseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    subtitle = json['subtitle'];
    videoUrl = json['videoUrl'];
    bannerImages = json['bannerImages'].cast<String>();
    if (json['subVideos'] != null) {
      subVideos = <SubVideos>[];
      json['subVideos'].forEach((v) {
        subVideos!.add(SubVideos.fromJson(v));
      });
    }
    notice = json['notice'];
    bangla = json['bangla'];
    admissionNotice = json['admissionNotice'];
    courseFee = json['courseFee'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['videoUrl'] = videoUrl;
    data['bannerImages'] = bannerImages;
    if (subVideos != null) {
      data['subVideos'] = subVideos!.map((v) => v.toJson()).toList();
    }
    data['notice'] = notice;
    data['bangla'] = bangla;
    data['admissionNotice'] = admissionNotice;
    data['courseFee'] = courseFee;
    data['description'] = description;
    return data;
  }
}

class SubVideos {
  int? id;
  String? title;
  String? url;

  SubVideos({this.id, this.title, this.url});

  SubVideos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    return data;
  }
}