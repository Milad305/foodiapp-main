class ConsultantsModel {
  int? id;
  String? title;
  int? clientId;
  int? expertId;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? payinfo;
  String? rating;

  ConsultantsModel(
      {this.id,
      this.title,
      this.clientId,
      this.expertId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.payinfo,
      this.rating});

  ConsultantsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] == null ? "" : json['title'].toString();
    clientId = json['client_uid'];
    expertId = json['expert_uid'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    payinfo = json['payinfo'] == null ? "" : json['payinfo'].toString();
    rating = json['rating'] == null ? "" : json['rating'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['client_id'] = this.clientId;
    data['expert_id'] = this.expertId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['payinfo'] = this.payinfo;
    data['rating'] = this.rating;
    return data;
  }
}
