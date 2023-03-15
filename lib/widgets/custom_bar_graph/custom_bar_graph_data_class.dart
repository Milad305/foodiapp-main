class CustomBarGraphData {
  String? date;
  String? value;
  double? percentage;
  CustomBarGraphData({required date, required value, required percentage}) {
    this.date = date;
    this.value = value.toString();
    this.percentage = double.parse(percentage.toString());
  }
}
