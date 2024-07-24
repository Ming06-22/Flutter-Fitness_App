import 'package:intl/intl.dart';
class Account{
  String email;
  String password;

  Account(this.email, this.password){
    print('email is $email');
    print('pwd is $password');
  }

}

class Userinfo{
  static String email = Account('', '').email;
  static String password = Account('', '').password;
  final String name;
  final String? sex;
  final double height;
  final double weight;
  final double targetWeight;
  final double targetProtein;
  final double targetCarbon;
  final double targetFat;
  final int age;
  final String activity;
  final int id;
  final int level;
  final int money;
  final int theory;
  final bool authorize;
  final double targetWater;
  final double targetCalorie;
  final double targetBurn;
  final String photo;
  final int exp;

  const Userinfo({
    required this.name,
    required this.sex,
    required this.height,
    required this.weight,
    required this.targetWeight,
    required this.age,
    required this.activity,
    required this.id,
    required this.level,
    required this.money,
    required this.theory,
    required this.authorize,
    required this.targetWater,
    required this.targetCalorie,
    required this.targetBurn,
    required this.targetCarbon,
    required this.targetFat,
    required this.targetProtein,
    required this.photo,
    required this.exp,
  });

  factory Userinfo.fromJson(Map<String, dynamic> json){
    double h = double.parse(json['height'].toString());
    double w = double.parse(json['weight'].toString());
    double tw = double.parse(json['target_weight'].toString());
    return Userinfo(
      name: json['name'],
      sex: json['sex'],
      height: h,
      weight: w,
      targetWeight: tw,
      age: json['age'],
      activity: json['activity'],
      id: json['id'],
      level: json['level'],
      money: json['money'],
      theory: json['theory'],
      authorize: json['authorize'],
      targetWater: json['target_water'],
      targetCalorie: json['target_calorie'],
      targetBurn: json['target_burn'],
      targetCarbon: json['target_carbon'],
      targetFat: json['target_fat'],
      targetProtein: json['target_protein'],
      photo: json['photo'],
      exp: json['exp'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sex': sex,
      'height': height,
      'weight': weight,
      'target_weight': targetWeight,
      'activity': activity,
      'age': age,
      'level': level,
      'money': money,
      'theory': theory,
      'target_water': targetWater,
      'target_calorie': targetCalorie,
      'target_burn': targetBurn,
      'target_carbon': targetCarbon,
      'target_fat': targetFat,
      'target_protein': targetProtein,
      'photo': photo,
      'exp': exp,
    };
  }
}

class Illness {
  final int ill1;
  final int ill2;
  final int ill3;

  const Illness({
    required this.ill1,
    required this.ill2,
    required this.ill3,
  });
  factory Illness.fromJson(Map<String, dynamic> json) {
    return Illness(
      ill1: json['1'],
      ill2: json['2'],
      ill3: json['3'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'ill1': ill1,
      'ill2': ill2,
      'ill3': ill3,
    };
  }
}
class FoodRecord{
  final String date;
  final Food foodObj;

  const FoodRecord({
    required this.date,
    required this.foodObj
  });

  factory FoodRecord.fromJson(dynamic json) {
    return FoodRecord(
      date: json['input_time'],
      foodObj: Food.fromJson(json['foodobj']),
    );
  }
  Map<String, dynamic> toMap() {
    return{
      'input_time': date,
      'food': foodObj.name,
      'num': foodObj.num,
      'meal': foodObj.category,
      'calorie': foodObj.calories,
      'carbon': foodObj.carbon,
      'protein': foodObj.protein,
      'fat': foodObj.fat,
      'saturated_fat': foodObj.saturatedFat,
      'unsaturated_fat': foodObj.unsaturatedFat,
      'sugar': foodObj.sugar,
      'na': foodObj.na,
      'ca': foodObj.ca,
      'k': foodObj.k,
      'unit': foodObj.unit,
    };
  }

}
class Food {
  final String name;
  final double calories;
  final double carbon;
  final double protein;
  final double fat;
  final double saturatedFat;
  final double unsaturatedFat;
  final double sugar;
  final double na;
  final double ca;
  final double k;
  final double num;
  final String unit;
  final int category;

  const Food({
    this.name = "",
    this.calories = 0.0,
    this.carbon = 0.0,
    this.protein = 0.0,
    this.fat = 0.0,
    this.saturatedFat = 0.0,
    this.unsaturatedFat = 0.0,
    this.sugar = 0.0,
    this.na = 0.0,
    this.ca = 0.0,
    this.k = 0.0,
    this.num = 0.0,
    this.unit = "份",
    this.category = 0
  });

  factory Food.fromJson(dynamic json) {
    return Food(
      name: json['name'],
      calories: json['calorie'],
      carbon: json['carbon'],
      protein: json['protein'],
      fat: json['fat'],
      saturatedFat: json['saturated_fat'],
      unsaturatedFat: json['unsaturated_fat'],
      sugar: json['sugar'],
      na: json['na'],
      ca: json['ca'],
      k: json['k'],
      num: json['num'],
      unit: json['unit'],
      category: json['category'],
    );
  }
  Map<String, dynamic> toMap() {
    return{
      'name':name,
      'num':num,
      'calorie': calories,
      'carbon': carbon,
      'protein': protein,
      'fat':fat,
      'saturated_fat': saturatedFat,
      'unsaturated_fat': unsaturatedFat,
      'sugar': sugar,
      'Na': na,
      'Ca': ca,
      'K': k,
      'unit': unit,
      'category': category,
    };
  }
}
class ProductRecord {
  final int pid;
  final int have;

  const ProductRecord({
    required this.pid,
    this.have = 0,
  });
  factory ProductRecord.fromJson(dynamic json){
    return ProductRecord(
      pid: json['pid'],
      have: json['have'],
    );
  }
  Map<String, dynamic> toMap() {
    return{
      'pid':pid,
      'have':have,
    };
  }
}
class SportRecord {
  final double time;
  final double calories;
  final String name;
  final String? input_time;
  final int? id;
  //final List<Map<String, String>> allData;

  const SportRecord({
    ///修改過
    this.time=0.0,
    this.calories=0.0,
    this.name="",
    this.input_time="",
    this.id,
    //required this.allData,
  });

  factory SportRecord.fromJson(Map<String, dynamic> json) {
    return SportRecord(
      ///修改過
      time: double.parse(json['time'] ?? '0.0'),
      calories: double.parse(json['cal'] ?? '0.0'),
      name: json['name'] ?? '',
      input_time: json['input_time'] ?? '',
      // id: json['id'],
      // allData: json['all']
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'sport_time': time,
      'sport_cal': calories,
      'sport_name': name,
      'input_time':input_time,
      'id': id,
    };
  }
  factory SportRecord.fromMap(Map<String, dynamic> map) {
    return SportRecord(
      time: map['sport_time'],
      calories: map['sport_cal'],
      name: map['sport_name'],
      input_time: map['input_time'],
      id: map['id'],
    );
  }

}