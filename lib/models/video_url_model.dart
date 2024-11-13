class VideoUrlModel {
  String? sId;
  String? videoUrl;
  String? notice;
  String? imageUrl;
  String? description;
  String? guarantee;
  String? instructor;
  String? rating;
  String? ratio;
  String? since;
  String? student;
  String? videoSectionVideo;
  List<CourseImages>? courseImages;
  String? parallaxImg;
  String? visitor;

  VideoUrlModel(
      {this.sId,
        this.videoUrl,
        this.notice,
        this.imageUrl,
        this.description,
        this.guarantee,
        this.instructor,
        this.rating,
        this.ratio,
        this.since,
        this.student,
        this.videoSectionVideo,
        this.courseImages,
        this.parallaxImg,
        this.visitor});

  VideoUrlModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    videoUrl = json['video_url'];
    notice = json['notice'];
    imageUrl = json['imageUrl'];
    description = json['description'];
    guarantee = json['guarantee'];
    instructor = json['instructor'];
    rating = json['rating'];
    ratio = json['ratio'];
    since = json['since'];
    student = json['student'];
    videoSectionVideo = json['video_section_video'];
    if (json['courseImages'] != null) {
      courseImages = <CourseImages>[];
      json['courseImages'].forEach((v) {
        courseImages!.add(CourseImages.fromJson(v));
      });
    }
    parallaxImg = json['parallaxImg'];
    visitor = json['visitor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['video_url'] = videoUrl;
    data['notice'] = notice;
    data['imageUrl'] = imageUrl;
    data['description'] = description;
    data['guarantee'] = guarantee;
    data['instructor'] = instructor;
    data['rating'] = rating;
    data['ratio'] = ratio;
    data['since'] = since;
    data['student'] = student;
    data['video_section_video'] = videoSectionVideo;
    if (courseImages != null) {
      data['courseImages'] = courseImages!.map((v) => v.toJson()).toList();
    }
    data['parallaxImg'] = parallaxImg;
    data['visitor'] = visitor;
    return data;
  }
}

class CourseImages {
  String? image;
  int? id;

  CourseImages({this.image, this.id});

  CourseImages.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['id'] = id;
    return data;
  }
}