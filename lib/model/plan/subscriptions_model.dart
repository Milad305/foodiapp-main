class SubscriptionsModel {
  int? id;
  String? title;
  String? description;
  int? pid;
  int? uid;
  String? startedAt;
  int? duration;
  String? payinfo;
  String? createdAt;
  String? updatedAt;
  String? status;

  SubscriptionsModel(
      {this.id,
      this.title,
      this.description,
      this.pid,
      this.uid,
      this.startedAt,
      this.duration,
      this.payinfo,
      this.createdAt,
      this.updatedAt,
      this.status});

  SubscriptionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'] == null ? "" : json['description'];
    pid = json['pid'];
    uid = json['uid'];
    startedAt = json['started_at'];
    duration = json['duration'];
    payinfo = json['payinfo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['pid'] = this.pid;
    data['uid'] = this.uid;
    data['started_at'] = this.startedAt;
    data['duration'] = this.duration;
    data['payinfo'] = this.payinfo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}
