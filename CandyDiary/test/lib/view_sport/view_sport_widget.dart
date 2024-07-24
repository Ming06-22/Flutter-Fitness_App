import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'view_sport_model.dart';
export 'view_sport_model.dart';
///
import '../database/model.dart';
import 'package:test/database/sqfilite_db.dart';
import '../api/api_manager.dart';
///

class ViewSportWidget extends StatefulWidget {
  const ViewSportWidget({Key? key}) : super(key: key);

  @override
  _ViewSportWidgetState createState() => _ViewSportWidgetState();
}

class _ViewSportWidgetState extends State<ViewSportWidget> {
  late ViewSportModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  ///修改後
  List<SportRecord> sportRecords = [];
  ///
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewSportModel());
    ///修改後
    loadSportRecords(); // 讀取資料庫中的資料
    retrieveTodaySportRecords();

    ///
  }
  ///修改後
  void loadSportRecords() async {
    final List<SportRecord> records = await DatabaseHelper.getTodaySportRecords();
    setState(() {
      sportRecords = records;
    });
  }
  Future<void> retrieveTodaySportRecords() async {
    List<SportRecord> records = await DatabaseHelper.getTodaySportRecords();
    // 打印總記錄數
    print('Total number of records: ${records.length}');
    // 打印每個記錄的信息
    for (var record in records) {
      print('今日運動紀錄ID:Sport Name: ${record.name}, Time: ${record.time}, Calories: ${record.calories}');
    }
  }

  // Future<void> deleteSportRecord(SportRecord record, String todayDate) async {
  //   final db = await DatabaseHelper.opendb();  // 用 DatabaseHelper.opendb() 來取得資料庫實例
  //   await db.delete(
  //     'sport_record',
  //     where: "input_time = ? AND sport_time = ? AND sport_cal = ? AND sport_name = ?",
  //     whereArgs: [todayDate, record.time, record.calories, record.name],
  //   );
  //   deleteSport(Userinfo.email, Userinfo.password,record);
  // }



  ///

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF1F4F8),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            backgroundColor: Color(0xFF3C2E92),
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Color(0xFF3C2E92),
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              fillColor: Color(0xFF3C2E92),
              icon: Icon(
                Icons.arrow_back_outlined,
                color: Color(0xFFE5E0EB),
                size: 30,
              ),
              onPressed: () async {
                context.safePop();
              },
            ),
            title: Text(
              '今日運動紀錄',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                color: Color(0xFFE5E0EB),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 80,
                icon: Icon(
                  Icons.add,
                  color: Color(0xFFE5E0EB),
                  size: 40,
                ),
                onPressed: () async {
                  context.pushNamed('sport_record');
                },
              ),
            ],
            centerTitle: false,
            elevation: 2,
          ),
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                  ///修改後
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: sportRecords.length, // 根據運動記錄的數量動態生成元件
                    itemBuilder: (BuildContext context, int index) {
                      SportRecord record = sportRecords[index];
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          extentRatio: 0.5,
                          children: [
                            SlidableAction(
                              label: 'Delete',
                              backgroundColor: Color(0xFFF32143),
                              icon: Icons.delete,
                              ///修改後
                              onPressed: (_) async{
                                DatabaseHelper db = DatabaseHelper();
                                String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
                                // await db.deleteSportRecord(record, todayDate);
                                await db.deleteSportRecord(record);
                                deleteSport(Userinfo.email, Userinfo.password, record);
                                loadSportRecords();
                                print('SlidableActionWidget pressed ...');
                              },
                              ///
                            ),
                            SlidableAction(
                              label: 'Edit',
                              backgroundColor: Color(0xFF858E99),
                              icon: FontAwesomeIcons.tools,
                              // ... 在你的 Edit 按鈕中
                              onPressed: (_) async {
                                String inputData = '';
                                await showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('編輯運動紀錄'),
                                      content: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: TextField(
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                  labelText: '輸入新的時數', hintText: '請輸入時數...'),
                                              onChanged: (value) {
                                                inputData = value;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('送出'),
                                          onPressed: () {
                                            Navigator.of(context).pop(); // 閉閉對話框
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                // 確認輸入的數值不是空的，並轉換成 double
                                if (inputData.isNotEmpty) {
                                  double newTime = double.parse(inputData);
                                  double averageCaloriesPerMinute = await DatabaseHelper.getSportCalorieByName(record.name);
                                  double newCalories = newTime * averageCaloriesPerMinute;
                                  String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
                                  SportRecord newRecord = SportRecord(input_time:todayDate ,time: newTime, calories: newCalories, name: record.name, id: record.id);
                                  await DatabaseHelper.updateSportRecord(record, newRecord);
                                  editSport(Userinfo.email, Userinfo.password, record, newRecord);

                                  loadSportRecords();
                                }

                              },
                              ///edit onpress的結尾
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.swimmer,
                            color: Color(0xFF13112C),
                            size: 25,
                          ),
                          title: Text(
                            '${record.name} - ${record.time} min',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                              fontFamily: 'Poppins',
                              lineHeight: 2,
                              color: Color(0xFF050505),
                            ),
                          ),
                          subtitle: Text(
                            '消耗 ${record.calories} kal',
                            style: FlutterFlowTheme.of(context).titleSmall,
                          ),
                          tileColor: Color(0xFFE5E0EB),
                          dense: false,
                        ),
                      );
                    },
                  ),
                  ///
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
