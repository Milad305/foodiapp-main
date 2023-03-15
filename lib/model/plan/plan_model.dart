class PlansModel {
  int? id;
  String? title;
  String? description;
  double? price;
  String? img;
  String? features;
  String? webPrivileges;
  String? appPrivileges;
  int? enabled;

  PlansModel(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.img,
      this.features,
      this.webPrivileges,
      this.appPrivileges,
      this.enabled});

  PlansModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = double.parse(json['price'].toString());
    img = json['img'];
    features = json['features'];
    webPrivileges =
        json['web_privileges'] != null ? json['web_privileges'].toString() : "";
    appPrivileges =
        json['app_privileges'] != null ? json['app_privileges'] : "";
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['img'] = this.img;
    data['features'] = this.features;
    data['web_privileges'] = this.webPrivileges;
    data['app_privileges'] = this.appPrivileges;
    data['enabled'] = this.enabled;
    return data;
  }
}
