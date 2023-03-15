import 'package:salamatiman/model/food/portions_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import '../model/food/food-category.dart';
import '../model/food/food-model.dart';

class SQLHelper {
  static List<FoodModel> foods = [];
  static List<FoodCategoryModel> foodCategory = [];
  static List<PortionsModel> portions = [];
  

  static Future<void> createTableFood(sql.Database database) async {
    await database.execute("""CREATE TABLE foods(
      id INTEGER PRIMARY KEY,
      data_type TEXT DEFAULT NULL,
      title TEXT DEFAULT NULL,
      description TEXT DEFAULT NULL,
      portion REAL DEFAULT 0.0,
      img TEXT DEFAULT NULL,
      category INTEGER NOT NULL DEFAULT 1,   
      energy REAL DEFAULT 0.0,
      fat REAL DEFAULT NULL,
      favorite TEXT DEFAULT false,
      carbohydrate REAL DEFAULT 0.0,
      shortTitle TEXT DEFALUT NULL,
      source TEXT DEFAULT NULL,
      portionTitle TEXT DEFAULT NULL,
      portionAmount TEXT DEFAULT NULL,
      FOREIGN KEY (category) REFERENCES CATEGORY (id)
    )
""");
  }

  static Future<void> createCategoryTable(sql.Database database) async {
    await database.execute("""CREATE TABLE category (
        id			   INTEGER PRIMARY KEY,
        title  TEXT    NOT NULL,
        description      TEXT NOT NULL,
        img				TEXT NULL,
        content			TEXT NULL,
  	    code			INTEGER NULL,
  	    color			TEXT NULL,
  	    title_en		TEXT NULL,
        common			INTEGER DEFAULT 0,
        status			INTEGER DEFAULT 1
        )""");
  }

  static Future<void> createTablePortion(sql.Database database) async {
    await database.execute("""CREATE TABLE portion (
            id			   INTEGER PRIMARY KEY,
            fdc_id  INTEGER    NOT NULL,
            amount      TEXT NOT NULL,
            modifier				TEXT NULL,
            gram_weight			TEXT NULL,
            FOREIGN KEY (fdc_id) REFERENCES FOODS (id)
            )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('test4.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      print('....creating tables ....');
      await createTableFood(database);
      await createCategoryTable(database);
      await createTablePortion(database);
    });
  }

  static Future<void> addFood(List<FoodModel> foods) async {
    final db = await SQLHelper.db();
    Batch batch = db.batch();

    foods.forEach((element) {
      final data = element.toMap();
      batch.insert('foods', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    });
    batch.commit();
    //final data={'title':'title','data_type':'data_type','description':'description','portion':10.0};
  }

  static Future<void> addCategory(List<FoodCategoryModel> category) async {
    final db = await SQLHelper.db();
    Batch batch = db.batch();
    category.forEach((element) {
      final data = element.toMap();
      batch.insert('category', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    });
    batch.commit();
    //final data={'title':'title','data_type':'data_type','description':'description','portion':10.0};
  }

  static Future getPortion() async {
    List<PortionsModel> list = [];
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> items = await db.query('foods');

    SQLHelper.portions = List.generate(items.length, (i) {
      return PortionsModel(
        id: items[i]['id'],
        amount: items[i]['amount'],
        fdcId: items[i]['fdcId'],
        gramWeight: items[i]['gramWeight'],
        modifier: items[i]['modifier'],
      );
    });
    return SQLHelper.portions;
  }

  static Future getFoods() async {
    List<FoodModel> list = [];
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> items = await db.query('foods');
    SQLHelper.foods = List.generate(items.length, (i) {
      List<PortionsModel> portion = SQLHelper.portions
          .where(
            (element) => element.fdcId == items[i]['id'],
          )
          .toList();
      return FoodModel(
        id: items[i]['id'],
        title: items[i]['title'],
        img: items[i]['img'],
        portionAmount: items[i]['portionAmount'],
        description: items[i]['description'],
        fat: items[i]['fat'],
        dataType: items[i]['dataType'],
        portions: portion,
        protein: items[i]['portions'],
        shortTitle: items[i]['shortTitle'],
        category: items[i]['category'],
        carbohydrate: items[i]['carbohydrate'],
        energy: items[i]['energy'],
        portionTitle: items[i]['portionTitle'],
        favorite: items[i]['favorite'],
        source: items[i]['source'],
      );
    });
    return SQLHelper.foods;
  }

  static Future getCategorys() async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> items = await db.query('foods');

    SQLHelper.foodCategory = List.generate(items.length, (i) {
      List<FoodModel> foods = SQLHelper.foods
          .where((element) => element.category == items[i]['id'])
          .toList();
      return FoodCategoryModel(
        id: items[i]['id'],
        title: items[i]['title'],
        img: items[i]['img'],
        description: items[i]['description'],
        code: items[i]['code'],
        foods: foods,
        content: items[i]['content'],
        status: items[i]['status'],
        titleEn: items[i]['titleEn'],
        type: items[i]['type'],
      );
    });
    return SQLHelper.foodCategory;
  }
}
