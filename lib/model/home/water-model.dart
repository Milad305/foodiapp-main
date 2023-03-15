class WaterModel {
  int? cups;
  int? cupsInGrams;
  double? totalGrams;
  int? totalCups;
  int? target;

  WaterModel(
      {this.cups,
      this.cupsInGrams,
      this.totalGrams,
      this.totalCups,
      this.target});

  WaterModel.fromJson(Map<String, dynamic> json) {
    cups = json['cups'];
    cupsInGrams = json['cups_in_grams'];
    totalGrams = json['total_grams'];
    totalCups = json['total_cups'];
    target = json['target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cups'] = this.cups;
    data['cups_in_grams'] = this.cupsInGrams;
    data['total_grams'] = this.totalGrams;
    data['total_cups'] = this.totalCups;
    data['target'] = this.target;
    return data;
  }
}
