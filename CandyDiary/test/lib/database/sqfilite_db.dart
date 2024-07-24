import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';  // 包含 debugPrint
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './model.dart';
import 'package:intl/intl.dart';



class DatabaseHelper {
  static Future<void> checkconn() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "data.db");

    if (await databaseExists(path)) {
      // print(path);
      // print("資料庫已存在");
    } else {

      print("複製資料庫從assets資料夾");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "data.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }
  }
  static Future<Database> opendb() async {
    // 在此調用 checkconn()，確保資料庫存在
    await DatabaseHelper.checkconn();

    // 從應用程序目錄中獲取資料庫路徑
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "data.db");

    // 開啟資料庫
    return await openDatabase(path, version: 1);
  }

  // 從資料庫獲取項目
  static Future<List<Map<String, dynamic>>> getItem() async {
    final Database db = await DatabaseHelper.opendb();
    final List<Map<String, dynamic>> results = await db.query('users');

    return results;
  }
  static Future<List<Map<String, dynamic>>> getIll() async {
    final Database db = await DatabaseHelper.opendb();
    final List<Map<String, dynamic>> results = await db.query('illness', limit: 1);
    // print("query from food illness：");
    // results.forEach((row) => print(row));
    return results;
  }

  static Future<List<Map<String, dynamic>>> getFoodRecordItems(String? time) async {
    final Database db = await DatabaseHelper.opendb();
    List<Map<String, dynamic>>  result = await db.rawQuery('SELECT * FROM food_record WHERE food !=? AND input_time=?', ['water', time]);
    return result;
  }
  static Future<List<Map<String, dynamic>>> getFoods(String s) async {
    final Database db = await DatabaseHelper.opendb();
    final List<Map<String, dynamic>> results = await db.query('food', where: "name LIKE ?",
        whereArgs: ['%$s%']);
    return results.isEmpty ? [] : results;
  }
  static Future<List<Map<String, dynamic>>> getFoodDB() async {
    final Database db = await DatabaseHelper.opendb();
    final List<Map<String, dynamic>> results = await db.query('food');
    return results;
  }
  static Future<List<Map<String, dynamic>>> getFoodItems(int meal) async {
    final Database db = await DatabaseHelper.opendb();

    DateTime now = new DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dateSlug = formatter.format(now);

    final List<Map<String, dynamic>> results = await db.rawQuery('SELECT * FROM food_record WHERE food!=? AND input_time=? AND meal=?', ['water', dateSlug, meal]);

    return results;
  }

  static Future<double> getWater(dateSlug) async {
    final Database db = await DatabaseHelper.opendb();
    List<Map> result = await db.rawQuery('SELECT * FROM food_record WHERE food=? AND input_time=?', ['water', dateSlug]);
    double water = 0.0;
    if (result.isNotEmpty){
      for (final row in result){
        water += row['num'];
      }
    }
    return water;
  }
  static Future<Map> getCalories() async {
    final Database db = await DatabaseHelper.opendb();

    DateTime now = new DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dateSlug = formatter.format(now);

    List<Map> result = await db.rawQuery('SELECT * FROM food_record WHERE food!=? AND input_time=?', ['water', dateSlug]);
    // print(result);
    Map map = {'1': 0.0, '2': 0.0, '3': 0.0, '4': 0.0, 'calorie': 0.0, 'carbon': 0.0, 'fat': 0.0, 'protein': 0.0};
    if (result.isNotEmpty) {
      for (final row in result) {
        map['calorie'] += row['calorie'];
        map['carbon'] += row['carbon'];
        map['fat'] += row['fat'];
        map['protein'] += row['protein'];
        if (row['meal'] == 1)
          map['1'] += row['calorie'];
        else if (row['meal'] == 2)
          map['2'] += row['calorie'];
        else if (row['meal'] == 3)
          map['3'] += row['calorie'];
        else if (row['meal'] == 4)
          map['4'] += row['calorie'];
      }
      map['calorie'] = double.parse(map['calorie'].toStringAsFixed(1));
      map['carbon'] = double.parse(map['carbon'].toStringAsFixed(1));
      map['fat'] = double.parse(map['fat'].toStringAsFixed(1));
      map['protein'] = double.parse(map['protein'].toStringAsFixed(1));
      map['1'] = double.parse(map['1'].toStringAsFixed(1));
      map['2'] = double.parse(map['2'].toStringAsFixed(1));
      map['3'] = double.parse(map['3'].toStringAsFixed(1));
      map['4'] = double.parse(map['4'].toStringAsFixed(1));
    }
    return map;
  }

  static Future<List<Map<String, dynamic>>> getProduct() async {
    final Database db = await DatabaseHelper.opendb();
    final List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT *
    FROM product
    LEFT JOIN product_record ON product.id = product_record.pid
    WHERE product_record.pid IS NULL
  ''');

    return results;
  }
  static Future<List<Map<String, dynamic>>> getProductRec() async {
    final Database db = await DatabaseHelper.opendb();
    final List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT *
    FROM product
    INNER JOIN product_record ON product.id = product_record.pid
    AND product_record.have = 0
  ''');

    return results;
  }
  static Future<String> getCanPath() async {
    final Database db = await DatabaseHelper.opendb();
    final List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT path
    FROM product
    INNER JOIN product_record ON product.id = product_record.pid
    AND product_record.have = 1
    AND product.type = "can"
  ''');
    return results[0]['path'];
  }
  static Future<String> getCandyPath() async {
    final Database db = await DatabaseHelper.opendb();
    final List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT path
    FROM product
    INNER JOIN product_record ON product.id = product_record.pid
    AND product_record.have = 1
    AND product.type = "candy"
  ''');
    return results[0]['path'];
  }
  // 更新資料庫項目
  static Future<void> updateItem(int id, Userinfo u) async {
    final db = await DatabaseHelper.opendb();
    await db.update('users', u.toMap(), where: "id = ?", whereArgs: [id]);
  }
  static Future<void> updateMoney(int id, int balance) async {
    final db = await DatabaseHelper.opendb();
    final a = {'money': balance};
    await db.update('users', a, where: "id = ?", whereArgs: [id]);
  }
  static Future<void> updateTgWater(int id, Userinfo u) async {
    final db = await DatabaseHelper.opendb();
    await db.update('users', u.toMap(), where: "id = ?", whereArgs: [id]);
  }
  static Future<void> updateIll(Illness i) async {
    final db = await DatabaseHelper.opendb();
    await db.update('illness', i.toMap());
  }
  static Future<void> updateWeight(int id, double weight) async {
    final db = await DatabaseHelper.opendb();
    final a = {'weight': weight};
    await db.update('users', a, where: "id = ?", whereArgs: [id]);
  }
  static Future<void> updateProduct(ProductRecord p) async {
    final db = await DatabaseHelper.opendb();
    await db.update('product_record', p.toMap());
  }
  static Future<void> updateCan(int pid, String type) async {
    final db = await DatabaseHelper.opendb();
    await db.rawUpdate('''
    UPDATE product_record
    SET have = 0
    WHERE pid IN (
      SELECT product_record.pid
      FROM product_record
      JOIN product ON product_record.pid = product.id
      WHERE product.type = ?
    )
    ''', [type]);
    await db.rawUpdate('''
    UPDATE product_record
    SET have = 1
    WHERE pid =?
    ''', [pid]);
  }
  // 插入新的項目到資料庫
  static Future<void> insertItem(Userinfo u) async {
    final Database db = await DatabaseHelper.opendb();
    await db.insert('users', u.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  static Future<void> insertIll(Illness ill) async {
    final Database db = await DatabaseHelper.opendb();

    await db.insert('illness', ill.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  static Future<void> insertFoodrec(FoodRecord f) async {
    final Database db = await DatabaseHelper.opendb();
    await db.insert('food_record', f.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  static Future<void> insertProductrec(ProductRecord p) async {
    final Database db = await DatabaseHelper.opendb();
    // final a = {'pid':pid, 'have': have};
    await db.insert('product_record', p.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  static Future<void> insertFood(Food f) async {
    final Database db = await DatabaseHelper.opendb();
    await db.insert('food', f.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  //
  static Future<void> deleteFoodItem(Map<String, dynamic> record) async {
    final Database db = await DatabaseHelper.opendb();
    await db.delete(
      'food_record',
      where: 'input_time = ? AND food = ? AND carbon = ? AND sugar = ? '
          'AND fat = ? AND saturated_fat = ? AND unsaturated_fat = ? '
          'AND protein = ? AND calorie = ? AND na = ? AND ca = ? '
          'AND k = ? AND num = ? AND unit = ? AND meal = ? limit 1',
      whereArgs: [
        record['input_time'],
        record['food'],
        record['carbon'],
        record['sugar'],
        record['fat'],
        record['saturated_fat'],
        record['unsaturated_fat'],
        record['protein'],
        record['calorie'],
        record['na'],
        record['ca'],
        record['k'],
        record['num'],
        record['unit'],
        record['meal'],
      ],
    );
  }


  // 刪除資料庫項目
  static Future<void> deleteItem() async {
    final db = await DatabaseHelper.opendb();
    try {
      await db.execute("delete from " + 'users');
    } catch (err) {
      debugPrint("Something went wrong when deleting user: $err");
    }
  }
  static Future<void> deleteFoodRec() async {
    final db = await DatabaseHelper.opendb();
    try {
      await db.execute("delete from " + 'food_record');
    } catch (err) {
      debugPrint("Something went wrong when deleting food record: $err");
    }
  }
  static Future<void> deleteIll() async {
    final db = await DatabaseHelper.opendb();
    try {
      await db.execute("delete from " + 'illness');
    } catch (err) {
      debugPrint("Something went wrong when deleting illness: $err");
    }
  }
  static Future<void> deleteProduct() async {
    final db = await DatabaseHelper.opendb();
    try{
      await db.execute("delete from " + "product_record");
    }catch (err) {
      debugPrint("Something went wrong when deleting product record: $err");
    }
  }
  static Future<void> deleteOldImage() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "chart.jpg");
    try {
      var file = File(path);
      if (await file.exists()) {
        await file.delete();
        print('旧图像文件已成功删除');
      }
    } catch (e) {
      print('删除旧图像文件时出现错误：$e');
    }
  }
  static Future<List<Map<String, dynamic>>> getSportRecordItems() async {
    final Database db = await DatabaseHelper.opendb();
    final List<Map<String, dynamic>> results = await db.query('sport_record');  // 'sport_record' 應為你的運動記錄表名

    return results;
  }

  static Future<double> getTotalSportTime(String inputDate) async {
    final Database db = await DatabaseHelper.opendb();

    final List<Map<String, dynamic>> results = await db.rawQuery('SELECT * FROM sport_record WHERE input_time = ?', [inputDate]);

    double totalSportTime = 0.0;

    for (var row in results) {
      totalSportTime += row['sport_time'];
    }

    return totalSportTime;
  }

  static Future<double> getTotalSportCal(String inputDate) async {
    final Database db = await DatabaseHelper.opendb();

    final List<Map<String, dynamic>> results = await db.rawQuery('SELECT * FROM sport_record WHERE input_time = ?', [inputDate]);

    double totalSportCal = 0.0;

    for (var row in results) {
      totalSportCal += row['sport_cal'];
    }

    return totalSportCal;
  }

  static Future<List<Map<String, dynamic>>> getSportItems() async {
    final Database db = await DatabaseHelper.opendb();
    final List<Map<String, dynamic>> results = await db.query('sport');

    return results;
  }

  static Future<double> getSportCalorieByName(String name) async {
    final Database db = await DatabaseHelper.opendb();
    final List<Map<String, dynamic>> results = await db.query('sport', where: 'name = ?', whereArgs: [name]);

    if (results.isNotEmpty) {
      return results.first['calorie'];
    } else {
      return 0.0;  // or throw an exception, or handle this situation as you see fit
    }
  }

  static Future<List<SportRecord>> getTodaySportRecords() async {
    final Database db = await DatabaseHelper.opendb();

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String today = formatter.format(DateTime.now());

    final List<Map<String, dynamic>> results = await db.rawQuery('SELECT * FROM sport_record WHERE input_time = ?', [today]);

    List<SportRecord> todayRecords = results.map((row) => SportRecord.fromMap(row)).toList();

    return todayRecords;
  }
  static Future<void> insertSportrec(SportRecord s) async {
    final Database db = await DatabaseHelper.opendb();
    await db.insert('sport_record', s.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteSportRecordsByName(String name) async {
    final Database db = await opendb();
    return await db.delete('sport_record', where: 'sport_name = ?', whereArgs: [name]);
  }
  Future<void> deleteSportRecord(SportRecord record) async {
    final db = await DatabaseHelper.opendb();
    await db.delete(
      'sport_record',
      where: "id = ?",
      whereArgs: [record.id],
    );
  }
  static Future<void> updateSportRecord(SportRecord oldRecord, SportRecord newRecord) async {
    final db = await DatabaseHelper.opendb();
    await db.update(
      'sport_record',
      newRecord.toMap(),
      where: "id = ?",
      whereArgs: [oldRecord.id],
    );
  }
  static Future<void> updateLevelExp(int id, List<String> context) async {
    final db = await DatabaseHelper.opendb();
    final a = {'level': context[0],
      'exp': context[1]};
    await db.update('users', a, where: "id = ?", whereArgs: [id]);
  }
}
