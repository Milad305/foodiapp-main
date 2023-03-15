class PostByCategoryModel {
  PostByCategoryModel({
    num? id,
    String? title,
    num? parent,
    List<Articles>? articles,
  }) {
    _id = id;
    _title = title;
    _parent = parent;
    _articles = articles;
  }

  PostByCategoryModel.fromJson(dynamic json) {
    _id = json['term_id'];
    _title = json['name'];
    _parent = json['parent'];
    if (json['posts'] != null) {
      _articles = [];
      json['posts'].forEach((v) {
        _articles?.add(Articles.fromJson(v));
      });
    }
  }
  num? _id;
  String? _title;
  num? _parent;
  List<Articles>? _articles;
  PostByCategoryModel copyWith({
    num? id,
    String? title,
    num? parent,
    List<Articles>? articles,
  }) =>
      PostByCategoryModel(
        id: id ?? _id,
        title: title ?? _title,
        parent: parent ?? _parent,
        articles: articles ?? _articles,
      );
  num? get id => _id;
  String? get title => _title;
  num? get parent => _parent;
  List<Articles>? get articles => _articles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['parent'] = _parent;
    if (_articles != null) {
      map['articles'] = _articles?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Articles {
  Articles({
    num? id,
    String? title,
    String? preview,
    String? content,
    String? abstract,
    String? publishedAt,
  }) {
    _id = id;
    _title = title;
    _preview = preview;
    _publishedAt = publishedAt;
  }

  Articles.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _preview = json['preview'] == null || json['preview'] == false
        ? ''
        : json['preview'];
    _publishedAt = json['published_at'];
  }
  num? _id;
  String? _title;
  String? _preview;
  String? _publishedAt;
  Articles copyWith({
    num? id,
    String? title,
    String? preview,
    String? publishedAt,
  }) =>
      Articles(
        id: id ?? _id,
        title: title ?? _title,
        preview: preview == null || preview == false ? '' : _preview,
        publishedAt: publishedAt ?? _publishedAt,
      );
  num? get id => _id;
  String? get title => _title;
  String? get preview => _preview;
  String? get publishedAt => _publishedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['preview'] = _preview;
    map['published_at'] = _publishedAt;
    return map;
  }
}
