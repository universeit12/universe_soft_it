class FacultyMemberModel {
  String? sId;
  String? name;
  String? email;
  String? contact;
  String? facebook;
  String? twitter;
  String? whatsapp;
  String? designation;
  String? image;

  FacultyMemberModel(
      {this.sId,
        this.name,
        this.email,
        this.contact,
        this.facebook,
        this.twitter,
        this.whatsapp,
        this.designation,
        this.image});

  FacultyMemberModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    whatsapp = json['whatsapp'];
    designation = json['designation'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['contact'] = contact;
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['whatsapp'] = whatsapp;
    data['designation'] = designation;
    data['image'] = image;
    return data;
  }
}