class SportRecordsModel {
  SportRecordsModel({
    num? id,
    String? type,
    num? fk,
    num? group,
    dynamic title,
    String? description,
    num? amount,
    String? unit,
    dynamic portionId,
    num? portions,
    dynamic steps,
    num? calories,
    dynamic jsonNutrients,
    num? user,
    dynamic clientId,
    String? datetime,
    num? protein,
    num? fat,
    num? carbohydrate,
    String? date,
    num? category,
    String? time,
  }) {
    _id = id;
    _type = type;
    _fk = fk;
    _group = group;
    _title = title;
    _description = description;
    _amount = amount;
    _unit = unit;
    _portionId = portionId;
    _portions = portions;
    _steps = steps;
    _calories = calories;
    _jsonNutrients = jsonNutrients;
    _user = user;
    _clientId = clientId;
    _datetime = datetime;
    _protein = protein;
    _fat = fat;
    _carbohydrate = carbohydrate;
    _date = date;
    _category = category;
    _time = time;
  }

  SportRecordsModel.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _fk = json['fk'];
    _group = json['group'];
    _title = json['title'];
    _description = json['description'];
    _amount = json['amount'];
    _unit = json['unit'];
    _portionId = json['portion_id'];
    _portions = json['portions'];
    _steps = json['steps'];
    _calories = json['calories'];
    _jsonNutrients = json['json_nutrients'];
    _user = json['user'];
    _clientId = json['client_id'];
    _datetime = json['datetime'];
    _protein = json['protein'];
    _fat = json['fat'];
    _carbohydrate = json['carbohydrate'];
    _date = json['date'];
    _category = json['category'];
    _time = json['time'];
  }
  num? _id;
  String? _type;
  num? _fk;
  num? _group;
  dynamic _title;
  String? _description;
  num? _amount;
  String? _unit;
  dynamic _portionId;
  num? _portions;
  dynamic _steps;
  num? _calories;
  dynamic _jsonNutrients;
  num? _user;
  dynamic _clientId;
  String? _datetime;
  num? _protein;
  num? _fat;
  num? _carbohydrate;
  String? _date;
  num? _category;
  String? _time;
  SportRecordsModel copyWith({
    num? id,
    String? type,
    num? fk,
    num? group,
    dynamic title,
    String? description,
    num? amount,
    String? unit,
    dynamic portionId,
    num? portions,
    dynamic steps,
    num? calories,
    dynamic jsonNutrients,
    num? user,
    dynamic clientId,
    String? datetime,
    num? protein,
    num? fat,
    num? carbohydrate,
    String? date,
    num? category,
    String? time,
  }) =>
      SportRecordsModel(
        id: id ?? _id,
        type: type ?? _type,
        fk: fk ?? _fk,
        group: group ?? _group,
        title: title ?? _title,
        description: description ?? _description,
        amount: amount ?? _amount,
        unit: unit ?? _unit,
        portionId: portionId ?? _portionId,
        portions: portions ?? _portions,
        steps: steps ?? _steps,
        calories: calories ?? _calories,
        jsonNutrients: jsonNutrients ?? _jsonNutrients,
        user: user ?? _user,
        clientId: clientId ?? _clientId,
        datetime: datetime ?? _datetime,
        protein: protein ?? _protein,
        fat: fat ?? _fat,
        carbohydrate: carbohydrate ?? _carbohydrate,
        date: date ?? _date,
        category: category ?? _category,
        time: time ?? _time,
      );
  num? get id => _id;
  String? get type => _type;
  num? get fk => _fk;
  num? get group => _group;
  dynamic get title => _title;
  String? get description => _description;
  num? get amount => _amount;
  String? get unit => _unit;
  dynamic get portionId => _portionId;
  num? get portions => _portions;
  dynamic get steps => _steps;
  num? get calories => _calories;
  dynamic get jsonNutrients => _jsonNutrients;
  num? get user => _user;
  dynamic get clientId => _clientId;
  String? get datetime => _datetime;
  num? get protein => _protein;
  num? get fat => _fat;
  num? get carbohydrate => _carbohydrate;
  String? get date => _date;
  num? get category => _category;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['fk'] = _fk;
    map['group'] = _group;
    map['title'] = _title;
    map['description'] = _description;
    map['amount'] = _amount;
    map['unit'] = _unit;
    map['portion_id'] = _portionId;
    map['portions'] = _portions;
    map['steps'] = _steps;
    map['calories'] = _calories;
    map['json_nutrients'] = _jsonNutrients;
    map['user'] = _user;
    map['client_id'] = _clientId;
    map['datetime'] = _datetime;
    map['protein'] = _protein;
    map['fat'] = _fat;
    map['carbohydrate'] = _carbohydrate;
    map['date'] = _date;
    map['category'] = _category;
    map['time'] = _time;
    return map;
  }
}
