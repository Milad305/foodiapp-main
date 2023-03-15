class CacloriesModel {
  double? protein;
  double? fat;
  double? carbohydrate;
  double? energy;
  double? exercise;
  double? activity;
  double? bmr;
  double? burned;

  CacloriesModel(
      {this.protein,
        this.fat,
        this.carbohydrate,
        this.energy,
        this.exercise,
        this.activity,
        this.bmr,
        this.burned});

  CacloriesModel.fromJson(Map<String, dynamic> json) {
    protein = json['protein'];
    fat = json['fat'];
    carbohydrate = json['carbohydrate'];
    energy = json['energy'];
    exercise = json['exercise'];
    activity = json['activity'];
    bmr = json['bmr'];
    burned = json['burned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['protein'] = this.protein;
    data['fat'] = this.fat;
    data['carbohydrate'] = this.carbohydrate;
    data['energy'] = this.energy;
    data['exercise'] = this.exercise;
    data['activity'] = this.activity;
    data['bmr'] = this.bmr;
    data['burned'] = this.burned;
    return data;
  }
}