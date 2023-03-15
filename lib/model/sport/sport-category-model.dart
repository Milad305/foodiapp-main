class SportCategorysModel {
  int? id;
  String? title;
  String? img;
  int? status;

  SportCategorysModel({this.id, this.title, this.img, this.status});

  SportCategorysModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    img = json['img'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['img'] = this.img;
    data['status'] = this.status;
    return data;
  }
}
