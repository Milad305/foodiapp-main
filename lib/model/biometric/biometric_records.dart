class BiometricRecordsModel {
  BiometricRecordsModel({
    this.id,
    this.type,
    this.fk,
    this.group,
    this.title,
    this.description,
    this.amount,
    this.unit,
    this.portionId,
    this.portions,
    this.steps,
    this.calories,
    this.jsonNutrients,
    this.user,
    this.clientId,
    this.datetime,
    this.protein,
    this.fat,
    this.carbohydrate,
    this.date,
    this.category,
    this.time,
  });

  BiometricRecordsModel.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    fk = json['fk'];
    group = json['group'];
    title = json['title'];
    description = json['description'];
    amount = json['amount'];
    unit = json['unit'];
    portionId = json['portion_id'];
    portions = json['portions'];
    steps = json['steps'];
    calories = json['calories'];
    jsonNutrients = json['json_nutrients'];
    user = json['user'];
    clientId = json['client_id'];
    datetime = json['datetime'];
    protein = json['protein'];
    fat = json['fat'];
    carbohydrate = json['carbohydrate'];
    date = json['date'];
    category = json['category'];
    time = json['time'];
  }
  int? id;
  String? type;
  int? fk;
  int? group;
  dynamic? title;
  String? description;
  int? amount;
  String? unit;
  dynamic? portionId;
  int? portions;
  dynamic? steps;
  dynamic? calories;
  dynamic? jsonNutrients;
  int? user;
  dynamic? clientId;
  String? datetime;
  int? protein;
  int? fat;
  int? carbohydrate;
  String? date;
  int? category;
  String? time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['fk'] = fk;
    map['group'] = group;
    map['title'] = title;
    map['description'] = description;
    map['amount'] = amount;
    map['unit'] = unit;
    map['portion_id'] = portionId;
    map['portions'] = portions;
    map['steps'] = steps;
    map['calories'] = calories;
    map['json_nutrients'] = jsonNutrients;
    map['user'] = user;
    map['client_id'] = clientId;
    map['datetime'] = datetime;
    map['protein'] = protein;
    map['fat'] = fat;
    map['carbohydrate'] = carbohydrate;
    map['date'] = date;
    map['category'] = category;
    map['time'] = time;
    return map;
  }
}
