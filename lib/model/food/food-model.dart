class FoodModel {
  final String title, shortTitle, img, description, dataType, source;
  final int category, id;
  final double energy, protein, fat, carbohydrate;
  final List portions;
  final String portionTitle;
  final String portionAmount;
  final bool favorite;

  FoodModel({
    required this.id,
    required this.title,
    required this.shortTitle,
    required this.description,
    required this.dataType,
    required this.source,
    required this.img,
    required this.category,
    required this.energy,
    required this.protein,
    required this.fat,
    required this.carbohydrate,
    required this.portions,
    required this.portionTitle,
    required this.portionAmount,
    required this.favorite,
  });

  factory FoodModel.fromJson(json) {
    return FoodModel(
      id: json['id'],
      title: json['title'] ?? '',
      shortTitle: json['short_title'] ?? '',
      description: json['description'] ?? '',
      dataType: json['dataType'] ?? '',
      source: json['source'] ?? '',
      img: json['img'] ?? "",
      category: int.parse((json['category'] ?? 0).toString()),
      energy: double.parse((json['energy'] ?? 0.0).toString()),
      protein: double.parse((json['protein'] ?? 0.0).toString()),
      fat: double.parse((json['fat'] ?? 0.0).toString()),
      favorite: (json['favorite'] ?? false),
      carbohydrate: double.parse((json['carbohydrate'] ?? 0.0).toString()),
      portions: (json['portions'] ?? []).map((e) => e ?? '').toList(),
      portionTitle:
          json['portion'] == null ? '' : json['portion']['modifier'].toString(),
      portionAmount:
          json['portion'] == null ? '' : json['portion']['amount'].toString(),
    );
  }

 Map<String, dynamic> toMap() {
    return {
    'id': id,
    'data_type' : dataType,
    'source' : source,
    'title' : title,
    'description' : description,
    'img' : img,
    'category' : category,
    'energy' : energy,
    'portion' : protein,

    'fat' : fat,
    'favorite' : favorite,
    'carbohydrate' : carbohydrate,
    };
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data_type'] = this.dataType;
    data['source'] = this.source;
    data['title'] = this.title;
    data['description'] = this.description;
    data['img'] = this.img;
    data['category'] = this.category;
    data['energy'] = this.energy;
    data['protein'] = this.protein;
    data['fat'] = this.fat;
    data['favorite'] = this.favorite;
    data['carbohydrate'] = this.carbohydrate;
    return data;
  }


  @override
  String toString() {
    //return '{ title: ${title},}';
    return """{'id': $id,
      'data_type' : $dataType,
    'source' : $source,
    'title' : $title,
    'description' : $description,
    'img' : $img,
    'category' : $category,
    'energy' : $energy,
    'protein' : $protein,
    'fat' : $carbohydrate,
    'favorite' : $favorite,
    'carbohydrate' : $carbohydrate,}'
  }""";
}
}
