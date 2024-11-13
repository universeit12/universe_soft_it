class PhotoGalaryImage {
  String? sId;
  String? category;
  String? image;

  PhotoGalaryImage({this.sId, this.category, this.image});

  PhotoGalaryImage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['category'] = category;
    data['image'] = image;
    return data;
  }
}