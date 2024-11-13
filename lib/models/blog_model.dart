class BlogModel {
  String? sId;
  String? title;
  String? blogImageUrl;
  String? date;
  String? metaWord;
  String? author;
  String? description;
  String? videoUrl;

  BlogModel(
      {this.sId,
        this.title,
        this.blogImageUrl,
        this.date,
        this.metaWord,
        this.author,
        this.description,
        this.videoUrl});

  BlogModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    blogImageUrl = json['blogImageUrl'];
    date = json['date'];
    metaWord = json['meta_word'];
    author = json['author'];
    description = json['description'];
    videoUrl = json['videoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['blogImageUrl'] = blogImageUrl;
    data['date'] = date;
    data['meta_word'] = metaWord;
    data['author'] = author;
    data['description'] = description;
    data['videoUrl'] = videoUrl;
    return data;
  }
}