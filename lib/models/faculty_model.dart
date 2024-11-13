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
  String? backgroundOfStudy;
  String? jobExperience;

  FacultyMemberModel(
      {this.sId,
        this.name,
        this.email,
        this.contact,
        this.facebook,
        this.twitter,
        this.whatsapp,
        this.designation,
        this.image,
        this.backgroundOfStudy,
        this.jobExperience});

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
    backgroundOfStudy = json['background_of_study'];
    jobExperience = json['job_experience'];
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
    data['background_of_study'] = backgroundOfStudy;
    data['job_experience'] = jobExperience;
    return data;
  }
}