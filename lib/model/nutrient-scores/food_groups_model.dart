class FoodGroupsModel {
  double? foundations ;
  double? fruits ;
  double? vegetables ;
  double? highCallorie ;
  double? cereal ;
  double? meat ;
  double? fat ;

FoodGroupsModel({
  this.foundations,
  this.fruits,
  this.vegetables,
  this.highCallorie,
  this.cereal,
  this.meat,
  this.fat,
});

FoodGroupsModel.fromJson(Map<String,dynamic> element){
     foundations = element["گروه شیر و لبنیات"]+0.0 ;
     fruits =element["گروه میوه"]+0.0  ;
     vegetables =element["گروه سبزیجات"]+0.0 ;
     highCallorie =element["گروه پر کالری"]+0.0 ;
     cereal =element["گروه غلات"]+0.0 ;
     meat =element["گروه گوشت"]+0.0 ;
     fat =element["گروه چربی"]+0.0 ;

}


}
