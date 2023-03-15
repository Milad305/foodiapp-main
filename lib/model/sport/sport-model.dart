class SportModel {
  int? id;
  double? met;
  String? title;
  String? description;
  int? steps;
  String? img;
  String? images;
  String? video;
  int? category;
  int? minutes;
  String? difficulty;
  int? uid;

  SportModel(
      {this.id,
      this.met,
      this.title,
      this.description,
      this.steps,
      this.img,
      this.images,
      this.video,
      this.category,
      this.minutes,
      this.difficulty,
      this.uid});

  SportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    met = json['met'] == null ? 0.0 : double.parse(json['met'].toString());
    title = json['title'] ?? "";
    img = json['img'] ?? "";
    images = json['images'] ?? "";
    description = json['description'] ?? "";
    minutes = json['minutes'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['met'] = this.met;
    data['title'] = this.title;
    data['description'] = this.description;
    data['steps'] = this.steps;
    data['img'] = this.img;
    data['images'] = this.images;
    data['video'] = this.video;
    data['category'] = this.category;
    data['minutes'] = this.minutes;
    data['difficulty'] = this.difficulty;
    data['uid'] = this.uid;
    return data;
  }
}
