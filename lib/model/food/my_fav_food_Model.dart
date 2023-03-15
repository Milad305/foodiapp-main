class MyFavFoodModel {
  int? id;
  String? shortTitle;
  String? img;
  int? fat;
  int? energy;
  int? protein;
  int? carbohydrate;
  String? metaDescription;
  String? grade;
  String? hash;
  String? strKeywords;
  int? totalTime;

  MyFavFoodModel({
    this.id,
    this.energy,
    this.protein,
    this.fat,
    this.carbohydrate,
    this.totalTime,
    this.img,
    this.shortTitle,
    this.metaDescription,
    this.hash,
    this.grade,
    this.strKeywords,
  });

  MyFavFoodModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    energy = element["energy"];
    protein = element["protein"];
    fat = element["fat"];
    carbohydrate = element["carbohydrate"];
    totalTime = element["total_time"];
    img = element["img"];
    shortTitle = element["short_title"];
    metaDescription = element["meta_description"];
    hash = element["hash"];
    strKeywords = element["str_keywords"];
    grade = element["grade"];
  }
}
