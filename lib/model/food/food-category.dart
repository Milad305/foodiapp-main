import 'food-model.dart';

class FoodCategoryModel {

  int? id;
  String? title;
  Null? description;
  String? type;
  String? img;
  Null? content;
  int? code;
  String? titleEn;
  int? status;
  List<FoodModel>? foods;

  FoodCategoryModel(
      {this.id,
      this.title,
      this.description,
      this.type,
      this.img,
      this.content,
      this.code,
      this.titleEn,
      this.status,
      this.foods}
      );
 @override
  String toString() {
    //return '{ title: ${title},}';
    return """{'id': $id,
     }'
  }""";
}
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'img': img,
      'content': content,
      'code': code,
      'titleEn': titleEn,
      'status': status,
    };
  }

  FoodCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    title = json['title'] ?? "";
    description = json['description'] ?? null;
    type = json['type'] ?? "";
    img = json['img'] ?? "";
    content = json['content'] ?? null;
    code = json['code'] ?? 0;
    titleEn = json['title_en'] ?? "";
    status = json['status'] ?? 1;
    if (json['foods'] != null) {
      foods = <FoodModel>[];
      json['foods'].forEach((v) {
        foods!.add(new FoodModel.fromJson(v));
      });
    }
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
    if (this.foods != null) {
      data['foods'] = this.foods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
