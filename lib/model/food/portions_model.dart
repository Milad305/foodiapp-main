class PortionsModel {
  int? id;
  int? fdcId;
  String? amount;
  String? modifier;
  String? gramWeight;

  PortionsModel(
      {this.id, this.fdcId, this.amount, this.modifier, this.gramWeight});

  PortionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fdcId = json['fdc_id'];
    amount = json['amount'];
    modifier = json['modifier'];
    gramWeight = json['gram_weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fdc_id'] = this.fdcId;
    data['amount'] = this.amount;
    data['modifier'] = this.modifier;
    data['gram_weight'] = this.gramWeight;
    return data;
  }
}