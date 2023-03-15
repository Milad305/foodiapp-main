class ConsultantsMessagesModel {
  int? id;
  int? tid;
  String? content;
  int? from;
  int? to;
  int? seen;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? contentType;
  int? removerId;

  ConsultantsMessagesModel(
      {this.id,
      this.tid,
      this.content,
      this.from,
      this.to,
      this.seen,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.contentType,
      this.removerId});

  ConsultantsMessagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tid = json['tid'];
    content = json['content'];
    from = json['from'];
    to = json['to'];
    seen = json['seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'] == null ? "" : json['deleted_at'];
    contentType = json['content_type'];
    removerId = json['remover_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tid'] = this.tid;
    data['content'] = this.content;
    data['from'] = this.from;
    data['to'] = this.to;
    data['seen'] = this.seen;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['content_type'] = this.contentType;
    data['remover_id'] = this.removerId;
    return data;
  }
}
