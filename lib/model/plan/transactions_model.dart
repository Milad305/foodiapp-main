class TransactionsModel {
  int? id;
  String? refId;
  String? amount;
  String? status;
  String? gateway;
  String? ip;
  int? uid;
  int? seen;
  String? createdAt;
  String? updatedAt;

  TransactionsModel(
      {this.id,
      this.refId,
      this.amount,
      this.status,
      this.gateway,
      this.ip,
      this.uid,
      this.seen,
      this.createdAt,
      this.updatedAt});

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refId = json['ref_id'];
    amount = json['amount'];
    status = json['status'];
    gateway = json['gateway'];
    ip = json['ip'];
    uid = json['uid'];
    seen = json['seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ref_id'] = this.refId;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['gateway'] = this.gateway;
    data['ip'] = this.ip;
    data['uid'] = this.uid;
    data['seen'] = this.seen;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
