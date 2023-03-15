import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/service/base.dart';

class SaveFood extends BaseService {
  SaveMyFood({food, portions, nutrients}) async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "food/saveCustomFood",
        body: {
          "token": token,
          "food": food,
          "portions": portions,
          "nutrients": nutrients
        },
        loading: false,
        hasToken: true,
        hasHeader: true);
  }

  SaveRecipes(
      {ingredients,
      portions,
      weight_based,
      recipe_name,
      recipe_category}) async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "food/saveRecipe",
        body: {
          "token": token,
          "ingredients": ingredients,
          "portions": portions,
          "weight_based": weight_based,
          "recipe_name": recipe_name,
          "recipe_category": recipe_category,
        },
        loading: false,
        hasToken: true,
        hasHeader: true);
  }
}
