class FoodCategoryModel {
  int? id;
  String? title;
  String? description;
  String? type;
  String? img;
  String? content;
  int? code;
  String? titleEn;
  int? status;

  FoodCategoryModel(
      {this.id,
      this.title,
      this.description,
      this.type,
      this.img,
      this.content,
      this.code,
      this.titleEn,
      this.status});

  FoodCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'] == null ? "" : json['description'];
    type = json['type'];
    img = json['img'];
    content = json['content'] == null ? "" : json['content'];
    code = json['code'];
    titleEn = json['title_en'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['img'] = this.img;
    data['content'] = this.content;
    data['code'] = this.code;
    data['title_en'] = this.titleEn;
    data['status'] = this.status;
    return data;
  }
}
