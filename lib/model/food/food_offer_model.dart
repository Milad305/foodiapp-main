//  "title": "گرمک",
//                         "img": "https://cdn.salamatiman.ir/images/foods/474.jpg",
//                         "portion": "گرم",
//                         "amount": "1"

class FoodOfferModel{
 String? title;
 String? img;
 String? portion;
 String? amount;


FoodOfferModel({
   this.title,
   this.img,
   this.portion,
   this.amount,
  
  
  });

  FoodOfferModel.fromJson(Map<String,dynamic> element){

    title = element["title"];
    img = element["img"];
    portion = element["portion"];
    amount = element["amount"];
    
  }


}