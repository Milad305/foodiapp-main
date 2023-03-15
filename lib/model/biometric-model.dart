class BiometricModel {
  int? id;
  String? title;
  String? unit;
  String? unitFa;

  BiometricModel({this.id, this.title, this.unit, this.unitFa});

  BiometricModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    unit = json['unit'];
    unitFa = json['unit_fa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['unit'] = this.unit;
    data['unit_fa'] = this.unitFa;
    return data;
  }
}
