class SpecialistsModel {
  int? id;
  int? uid;
  String? type;
  String? biography;
  String? credentials;
  String? img;
  String? specialties;
  String? name;

  SpecialistsModel(
      {this.id,
      this.uid,
      this.type,
      this.biography,
      this.credentials,
      this.img,
      this.specialties,
      this.name});

  SpecialistsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    type = json['type'];
    biography = json['biography'];
    credentials = json['credentials'];
    img = json['img'];
    specialties = json['specialties'] == null ? "" : json['specialties'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['type'] = this.type;
    data['biography'] = this.biography;
    data['credentials'] = this.credentials;
    data['img'] = this.img;
    data['specialties'] = this.specialties;
    data['name'] = this.name;
    return data;
  }
}
