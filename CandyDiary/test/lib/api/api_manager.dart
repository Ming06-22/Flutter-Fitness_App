import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';
import 'package:test/flutter_flow/flutter_flow_util.dart';
import '../database/model.dart';
import 'package:sqflite/sqflite.dart';

var url = '1de3-60-250-225-148.ngrok-free.app';

Future<Userinfo> getUser(email, pwd) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.get(
      Uri.https(url, '/users', a),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});

  final signal = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (signal == "password wrong")
      return Userinfo.fromJson({"name": "-1", "sex": "f", "height": -1.0, "weight": -1.0, "age": -1, "id": -1,
        "target_weight": -1.0, "activity": "-1", "level": -1, "money": -1, "theory": -1, "authorize": false,
        "target_water": 0.0, "target_calorie": 0.0, "target_burn": 0.0, "photo":"-1", "exp":-1, 'target_carbon': -1.0,
      "target_fat": -1.0, "target_protein": -1.0});
    else if (signal == "No validation")
      return Userinfo.fromJson({"name": "-1", "sex": "f", "height": -2.0, "weight": -1.0, "age": -1, "id": -1,
        "target_weight": -1.0, "activity": "-1", "level": -1, "money": -1, "theory": -1, "authorize": false,
        "target_water": 0.0, "target_calorie": 0.0, "target_burn": 0.0, "photo":"-1", "exp":-1, 'target_carbon': -1.0,
        "target_fat": -1.0, "target_protein": -1.0});
    else if (signal == "No account"){
      return Userinfo.fromJson({"name": "-1", "sex": "f", "height": -3.0, "weight": -1.0, "age": -1, "id": -1,
        "target_weight": -1.0, "activity": "-1", "level": -1, "money": -1, "theory": -1, "authorize": false,
        "target_water": 0.0, "target_calorie": 0.0, "target_burn": 0.0, "photo":"-1", "exp":-1, 'target_carbon': -1.0,
        "target_fat": -1.0, "target_protein": -1.0});
    }
    else {
      return Userinfo.fromJson(jsonDecode(response.body));
    }

  } else {
    throw Exception('Failed to get user info.');
  }
}

Future<Illness> getIll(email, pwd) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.get(
      Uri.https(url, '/illness', a),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});

  if (response.statusCode == 200) {
      return Illness.fromJson(jsonDecode(response.body));

  } else {
    throw Exception('Failed to get illness.');
  }
}
Future<List<SportRecord>> getSport(email, pwd) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.get(
      Uri.https(url, '/sport_record', a),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});

  if (response.statusCode == 200) {
    var L = jsonDecode(response.body) as List;
    if (L.isNotEmpty) {
      return L.map((l) => SportRecord.fromJson(l)).toList();
    }
    else{
      return [];
    }
  }
  else {
    throw Exception('Failed to get sport record.');
  }
}
Future<List<Food>> getFood(email, pwd) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.get(
      Uri.https(url, '/food', a),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});

  if (response.statusCode == 200) {
    var L = jsonDecode(response.body)['food'] as List;
    return L.map((l) => Food.fromJson(l)).toList();
  } else {
    throw Exception('Failed to get food.');
  }
}
Future<List<FoodRecord>> getFoodRecord(email, pwd) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.get(
      Uri.https(url, '/food_record', a),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});

  if (response.statusCode == 200) {

    var L = jsonDecode(response.body)['foodrecord'] as List;
    if (L.isNotEmpty) {
      return L.map((l) => FoodRecord.fromJson(l)).toList();
    }
    else{
      return [];
    }
  } else {
    throw Exception('Failed to get foodRecord.');
  }
}
Future<List<ProductRecord>> getProductRecord(int uid) async {
  final a = {'uid': uid.toString()};
  final response = await http.get(
      Uri.https(url, '/product_record', a),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});

  if (response.statusCode == 200) {
    var L = jsonDecode(response.body)['product'] as List;
    if (L.isNotEmpty) {
      return L.map((l) => ProductRecord.fromJson(l)).toList();
    }
    else{
      return [];
    }
  } else {
    throw Exception('Failed to get ProductRecord.');
  }
}
Future<String> getWeightChart(email, pwd) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.get(
      Uri.https(url, '/weight_record', a),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});

  //print(jsonDecode(response.body));
  if (response.statusCode == 200) {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "chart.png");
    //print(path);
    //var absoluteFilePath = '$projectPath/assets/images/weightChart/chart.jpg';
    if (response.headers['content-type']?.startsWith('image/') ?? false) {
      // 将图像数据保存到文件
      await File(path).writeAsBytes(response.bodyBytes);
      print('新图像已成功保存到文件');
      return path;
    }
    else{
      var imageData = base64.decode(jsonDecode(response.body)['weight_record']);
      if (imageData.isNotEmpty) {
        await File(path).writeAsBytes(imageData);
        print('图像已成功保存到文件');
        return path;
      } else {
        print('无法获取图像数据。');
        return '';
      }
    }
  }
  else {
    throw Exception('Failed to save weight chart.');
  }
}
Future<List<Food>> getRecommendFood(email) async {
  final a = {'mail': email};
  final response = await http.get(
      Uri.https(url, '/recommend', a),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});

  if (response.statusCode == 200) {
    List<dynamic> L = jsonDecode(response.body)['food'];
    if (L.isNotEmpty) {
      return L.map((l) => Food.fromJson(l)).toList();
    }
    else{
      return [];
    }
  }
  else {
    throw Exception('Failed to get Recommand Food.');
  }
}

Future<bool> signup(String email, String password) async {
  final response = await http.post(
    Uri.https(url, '/users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'mail': email,
      'password': password
    }),
  );
  if (response.statusCode == 200) {
    if (jsonDecode(response.body) == "True")
      return true;
    else
      return false;
  } else {
    throw Exception('Failed to create account.');
  }
}

Future<String> chatgpt() async {
  final response = await http.post(
    Uri.https(url, '/greet'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }else {
    print('gpt wrong');
    return " ";
  }
}

Future<Userinfo> updateUser(email, pwd, List<String> content) async {
  print(content);
  final a = {"mail": email, "password": pwd};
  final response = await http.put(
    Uri.https(url, '/users', a),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': content[0],
      'sex': content[1],
      'height': content[2],
      'weight': content[3],
      'age': content[4]
    }),
  );
  if (response.statusCode == 200) {
    return Userinfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update user.');
  }
}
Future<Userinfo> updateUserPhoto(email, pwd, String content) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.put(
    Uri.https(url, '/users', a),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'photo': content,
    }),
  );
  if (response.statusCode == 200) {
    return Userinfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update user photo.');
  }
}
Future<Userinfo> updateTgWater(email, pwd, t) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.put(
    Uri.https(url, '/users', a),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'target_water': t,
    }),
  );
  if (response.statusCode == 200) {
    return Userinfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update target water.');
  }
}
Future<Userinfo> updateMoney(email, pwd, int balance) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.put(
    Uri.https(url, '/users', a),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'money': balance,
    }),
  );
  if (response.statusCode == 200) {
    return Userinfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update money.');
  }
}
Future<ProductRecord> updateProductApi(int uid, int pid) async {
  final response = await http.put(
    Uri.https(url, '/product_record'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'uid': uid,
      'pid': pid,
    }),
  );
  if (response.statusCode == 200) {
    return ProductRecord.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update product.');
  }
}
Future<void> updateProductStatus(email, pwd, int pid) async {
  final a = {'mail': email, 'password': pwd};
  final response = await http.put(
    Uri.https(url, '/product_record', a),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'pid': pid,
    }),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to update product status.');
  }
}
Future<void> editSport(email, pwd, SportRecord oldSport, SportRecord newSport) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.put(
    Uri.https(url, '/sport_record', a),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'old_sport_record': oldSport.toMap(),
      'new_sport_record': newSport.toMap(),
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to edit sport.');
  }
}
Future<Userinfo> updateTarget1(email, pwd, List<String> updateList) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.put(
    Uri.https(url, '/users', a),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'weight': updateList[0],
      'target_weight': updateList[1]
    }),
  );
  if (response.statusCode == 200) {
    return Userinfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update target1.');
  }
}
Future<Userinfo> updateTarget2(email, pwd, String hour) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.put(
    Uri.https(url, '/users', a),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'activity': hour
    }),
  );
  if (response.statusCode == 200) {
    return Userinfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update target2.');
  }
}
Future<Illness> updateTarget3(email, pwd, List<String>? content) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.put(
    Uri.https(url, '/illness', a),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, List<String>?>{
      'key': content,
    }),
  );
  print(jsonDecode(response.body));

  if (response.statusCode == 200) {
    return Illness.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update illness.');
  }
}

Future<Userinfo> updateDietplan(email, pwd, int theory) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.put(
    Uri.https(url, '/users', a),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int> {
      'theory': theory,
    }),
  );
  if (response.statusCode == 200) {
    return Userinfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update DietPlan.');
  }
}
Future<Userinfo> updateLevelExp(email, pwd, List<String> content) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.put(
    Uri.https(url, '/users', a),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'level': content[0],
      'exp' : content[1],
    }),
  );
  if (response.statusCode == 200) {
    return Userinfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update level and exp.');
  }
}
Future<void> addFood(email, pwd, FoodRecord food) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.post(
    Uri.https(url, '/food_record', a),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Map> {
      'food_record': food.toMap(),
    }),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to add food.');
  }
}
Future<void> addWeight(email, pwd, List<String> context) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.post(
    Uri.https(url, '/weight_record', a),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': context[0],
      'weight': context[1],
    }),
  );
  print(jsonDecode(response.body));
  if (response.statusCode != 200) {
    throw Exception('Failed to add user weight record.');
  }
}
Future<void> addProductApi(int uid, int pid, String type) async {

  final response = await http.post(
    Uri.https(url, '/product_record'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String> {
      'uid': uid.toString(),
      'pid': pid.toString(),
      'type': type
    }),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to add product.');
  }
}
Future<void> addSport(email, pwd, SportRecord sport) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.post(
    Uri.https(url, '/sport_record', a),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Map>{
      'sport_record': sport.toMap(),
    }),
  );

  if (response.statusCode == 200) {
    print('Sport added successfully.');
  } else {
    throw Exception('Failed to add sport.');
  }
}
Future<void> deleteSport(email, pwd, SportRecord sport) async {
  final a = {"mail": email, "password": pwd};
  final response = await http.delete(
    Uri.https(url, '/sport_record', a),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Map>{
      'sport_record': sport.toMap(),
    }),
  );

  if (response.statusCode == 200) {
    print('Sport deleted successfully.');
  } else {
    throw Exception('Failed to deleted sport.');
  }
}

Future<void> deleteFoodRec(email, Map<String, dynamic> food) async {
  final a = {"mail": email};
  final response = await http.delete(
    Uri.https(url, '/food_record', a),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Map>{
      'food_record': food,
    }),
  );
  if (response.statusCode == 200) {
    print('food rec deleted successfully.');
  } else {
    throw Exception('Failed to deleted food rec.');
  }
}
Future<String> sendForgetPWVal(email) async {
  final a = {'mail': email};
  final response = await http.post(
      Uri.https(url, '/forget', a),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to send validation.');
  }
}
Future<String> changePassword(String email, String newPassword) async {
  final response = await http.post(
    Uri.https(url, '/ForgetPWVal'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String> {
      'email': email,
      'newPassword': newPassword,
    }),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to change password.');
  }
  return jsonDecode(response.body);
}