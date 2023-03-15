class NotesModel {
  int? id;
  String? type;
  int? fk;
  int? group;
  Null? title;
  String? description;
  Null? amount;
  Null? unit;
  Null? portionId;
  int? portions;
  Null? steps;
  int? calories;
  Null? jsonNutrients;
  int? user;
  Null? clientId;
  String? datetime;
  int? protein;
  int? fat;
  int? carbohydrate;
  String? date;
  int? category;
  String? time;
  Null? food;

  NotesModel(
      {this.id,
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
      this.food});

  NotesModel.fromJson(Map<String, dynamic> json) {
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
    food = json['food'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['fk'] = this.fk;
    data['group'] = this.group;
    data['title'] = this.title;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['unit'] = this.unit;
    data['portion_id'] = this.portionId;
    data['portions'] = this.portions;
    data['steps'] = this.steps;
    data['calories'] = this.calories;
    data['json_nutrients'] = this.jsonNutrients;
    data['user'] = this.user;
    data['client_id'] = this.clientId;
    data['datetime'] = this.datetime;
    data['protein'] = this.protein;
    data['fat'] = this.fat;
    data['carbohydrate'] = this.carbohydrate;
    data['date'] = this.date;
    data['category'] = this.category;
    data['time'] = this.time;
    data['food'] = this.food;
    return data;
  }
}
