import 'package:get/get.dart';
import 'package:salamatiman/model/nutrient-scores/food_groups_model.dart';
import 'package:salamatiman/service/dio_service.dart';
import 'package:salamatiman/utils/get-date.dart';

import '../../utils/constants.dart';

class FoodGroupsController extends GetxController {
 Rx<FoodGroupsModel> oneWeeksLater = FoodGroupsModel().obs;
 Rx<FoodGroupsModel> byDay = FoodGroupsModel().obs;

 int id = Constants.userInfo["id"];
 RxInt week= 1.obs;

  RxBool loading = false.obs;
  RxBool loading2 = false.obs;

  RxString date = GetDate.todayOnlyDate().toString().obs;

 @override
 onInit(){
  super.onInit();
  getFoodGroups();
 } 



 getFoodGroups() async{
  oneWeeksLater.value = FoodGroupsModel(cereal: 0,fat: 0,foundations: 0,fruits: 0,highCallorie: 0,meat: 0,vegetables: 0);
  var response = await DioService().getMethod("https://salamatiman.ir/api/pub/calculate/getRecordsGroups?user_id=${id}&period=${week}");
  if(response.statusCode == 200){

    
   oneWeeksLater.value = FoodGroupsModel.fromJson(response.data['groups']);
      
 
  }
  loading.value = true;
 }

 getFoodGroups2() async{
  byDay.value = FoodGroupsModel(cereal: 0,fat: 0,foundations: 0,fruits: 0,highCallorie: 0,meat: 0,vegetables: 0);
  var response = await DioService().getMethod("https://salamatiman.ir/api/pub/calculate/getDateGroups?user_id=${id}&date=${date}");
  if(response.statusCode == 200){
    print(response);
   byDay.value = FoodGroupsModel.fromJson(response.data['groups']);
  }
  loading2.value = true;
 }
}