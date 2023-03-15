class WeightChartInfoModel {
  String? date;
  String? value;

  WeightChartInfoModel({this.date, this.value});

  WeightChartInfoModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['value'] = this.value;
    return data;
  }
}
