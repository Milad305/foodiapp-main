class CouponModel {
  int? id;
  String? code;
  int? percentage;
  String? amount;
  String? couponfor;
  String? createdAt;
  String? updatedAt;
  String? expire;

  CouponModel(
      {this.id,
      this.code,
      this.percentage,
      this.amount,
      this.couponfor,
      this.createdAt,
      this.updatedAt,
      this.expire});

  CouponModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    percentage = json['percentage'];
    amount = json['amount'] == null ? "" : json['amount'];
    couponfor = json['for'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    expire = json['expire'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['percentage'] = this.percentage;
    data['amount'] = this.amount;
    data['for'] = this.couponfor;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['expire'] = this.expire;
    return data;
  }
}
