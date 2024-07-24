import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sport_costumize_model.dart';
export 'sport_costumize_model.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';

///修改後
import 'package:test/database/sqfilite_db.dart';
import '../database/model.dart';
import '../api/api_manager.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
// int valueDay = DateTime.now().day;
// int valueMonth = DateTime.now().month;
// int valueYear = DateTime.now().year;
// String selectedDate = '11';
///


class SportCostumizeWidget extends StatefulWidget {
  const SportCostumizeWidget({Key? key}) : super(key: key);
  @override
  _SportCostumizeWidgetState createState() => _SportCostumizeWidgetState();
}
class _SportCostumizeWidgetState extends State<SportCostumizeWidget> {
  late SportCostumizeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime now = new DateTime.now();

  ///修改後
  int valueDay = DateTime.now().day;
  int valueMonth = DateTime.now().month;
  int valueYear = DateTime.now().year;
  int level = 0;
  int money = 0;
  int exp = 0;
  int id = 0;

  String selectedDate = ""; // 你可以選擇將其初始化為今天的日期或留空
  String exerciseName = '';
  String caloriesBurned = '';
  String timeSpent = '';
  ///

  void initializeDateValues() {
    DateTime now = DateTime.now();
    valueDay = now.day;
    valueMonth = now.month;
    valueYear = now.year;
  }

  @override
  void initState() {
    ///修改後
    DateTime now = DateTime.now();  // 獲取當前時間
    selectedDate = DateFormat('yyyy-MM-dd').format(now);
    ///
    super.initState();
    _model = createModel(context, () => SportCostumizeModel());
    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
    _model.textController3 ??= TextEditingController();
    initializeDateValues();
    refreshData();
  }

  Future<void> updateDBMoneyLevelExp(int m, List<String> l) async {
    await DatabaseHelper.updateMoney(id, m);
    await DatabaseHelper.updateLevelExp(id, l);
  }

  List<Map<String, dynamic>> myData = [];
  Future<void> refreshData() async {
    final data = await DatabaseHelper.getItem();
    setState(() {
      myData = data;
      id = myData[0]['id'];
      level = myData[0]['level'];
      money = myData[0]['money'];
      exp = myData[0]['exp'];
    });
  }
  ///修改後
  void updateDate({int? day, int? month, int? year}) {
    setState(() { // 使用 setState 來觸發界面重繪
      if (day != null) {
        valueDay = day;
      }
      if (month != null) {
        valueMonth = month;
      }
      if (year != null) {
        valueYear = year;
      }
      selectedDate = '$valueYear-${valueMonth.toString().padLeft(2, '0')}-${valueDay.toString().padLeft(2, '0')}';
    });
  }


  void insertnewdata() async {
    // DateTime now = DateTime.now();  // 獲取當前時間
    // String formattedDate = DateFormat('yyyy-MM-dd').format(now);  // 將日期格式化為 'yyyy-MM-dd' 的格式

    double timeSpentDouble = double.parse(timeSpent);
    double caloriesBurnedDouble = double.parse(caloriesBurned);
    var s = SportRecord(time: timeSpentDouble, calories: caloriesBurnedDouble, name: exerciseName, input_time: selectedDate);
    await DatabaseHelper.insertSportrec(s);
    ///回傳給API
    addSport(Userinfo.email, Userinfo.password,s);

    ///印出本地資料庫內容
    await DatabaseHelper.getSportRecordItems();
  }

  ///

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF3C2E92),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          buttonSize: 48.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () async {
            context.safePop();
          },
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '快速加入運動',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF14181B),
                                fontSize: 24.0,
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 16.0, 0.0, 0.0),
                            child: TextFormField(
                              controller: _model.textController1,
                              ///修改後
                              onChanged: (value) {
                                setState(() {
                                  exerciseName = value;
                                });
                              },
                              ///
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: '運動名稱',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF57636C),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF57636C),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF4B39EF),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF14181B),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                              validator: _model.textController1Validator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 16.0, 0.0, 0.0),
                            child: TextFormField(
                              controller: _model.textController2,
                              ///修改後
                              onChanged: (value) {
                                setState(() {
                                  caloriesBurned = value;
                                });
                              },
                              ///
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: '消耗卡路里',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF57636C),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                hintText: '(cal)',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF57636C),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF4B39EF),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                              validator: _model.textController2Validator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 16.0, 0.0, 0.0),
                            child: TextFormField(
                              controller: _model.textController3,
                              ///修改後
                              onChanged: (value) {
                                setState(() {
                                  timeSpent = value;
                                });
                              },
                              ///
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: '時間',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF57636C),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                hintText: '(min)',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF57636C),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF4B39EF),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                              validator: _model.textController3Validator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 15),
                child: DropdownDatePicker(
                  inputDecoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFDBE2E7), width: 1.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))), // optional
                  isDropdownHideUnderline: true, // optional
                  isFormValidator: true, // optional
                  startYear: 2023, // optional
                  endYear: 2025, // optional
                  width: 8,
                  locale: "en",// optional
                  selectedDay: now.day, // optional
                  selectedMonth:now.month, // optional
                  selectedYear:now.year, // optional
                  ///修改後
                  // onChangedDay: (value) => valueDay = int.parse(value.toString()),
                  // onChangedMonth: (value) => valueMonth = int.parse(value.toString()),
                  // onChangedYear: (value) => valueYear = int.parse(value.toString()),
                  onChangedDay: (value) => updateDate(day: int.parse(value.toString())),
                  onChangedMonth: (value) => updateDate(month: int.parse(value.toString())),
                  onChangedYear: (value) => updateDate(year: int.parse(value.toString())),
                  ///
                  dayFlex: 4,// optional
                  yearFlex: 5,
                  monthFlex:6,// optional
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  ///修改後
                  print("selectedDate: $selectedDate"); // 打印所選日期
                  print("exerciseName: $exerciseName");
                  print("caloriesBurned: $caloriesBurned");
                  print("timeSpent: $timeSpent");
                  insertnewdata();
                  ///
                  money += 15;
                  exp += 20;
                  print(money);
                  print(exp);
                  if(exp >= 100)
                  {
                    level += 1;
                    exp = exp-100;
                  }
                  final updateList = <String> [
                    level.toString(),
                    exp.toString(),
                  ];
                  updateMoney(Userinfo.email, Userinfo.password, money);
                  updateLevelExp(Userinfo.email, Userinfo.password, updateList);
                  updateDBMoneyLevelExp(money, updateList);
                  await showDialog(
                    context: context,
                    builder: (alertDialogContext) {
                      return AlertDialog(
                        title: Text('加入運動'),
                        content: Text('已加入成功！\n獲得 20 exp\n獲得 20 pt'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(alertDialogContext),
                            child: Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );

                  context.safePop();
                },
                text: '儲存運動',
                options: FFButtonOptions(
                  width: 270.0,
                  height: 50.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFFAE99E3),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                  elevation: 3.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
