import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sport_yoga_model.dart';
export 'sport_yoga_model.dart';
///修改後
import 'package:test/database/sqfilite_db.dart';
import '../database/model.dart';
import '../api/api_manager.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
///

class SportYogaWidget extends StatefulWidget {
  const SportYogaWidget({Key? key}) : super(key: key);

  @override
  _SportYogaWidgetState createState() => _SportYogaWidgetState();
}

class _SportYogaWidgetState extends State<SportYogaWidget> {
  late SportYogaModel _model;
  ///增加時間
  DateTime now = new DateTime.now();
  int valueDay = DateTime.now().day;
  int valueMonth = DateTime.now().month;
  int valueYear = DateTime.now().year;
  String selectedDate = "";
  int level = 0;
  int money = 0;
  int exp = 0;
  int id = 0;
  ///
  ///修改後
  double totalCalorieBurn = 0.0;
  double aveCal = 0.0;
  double inputMinutes = 0.0;
  String sportname = "";
  ///
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    ///修改後
    DateTime now = DateTime.now();  // 獲取當前時間
    selectedDate = DateFormat('yyyy-MM-dd').format(now);
    ///
    super.initState();
    _model = createModel(context, () => SportYogaModel());

    _model.textController ??= TextEditingController();
    ///修改後
    refreshData();

    assignSportCalorieByName(_model.dropDownValue);
    ///
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
  Future<void> printSportItems() async {
    await DatabaseHelper.getSportItems();
  }

  Future<void> assignSportCalorieByName(String? sportName) async {
    if(sportName != null && sportName.isNotEmpty){
      aveCal = await DatabaseHelper.getSportCalorieByName(sportName);
      print(aveCal); // For testing purposes. Remove if not needed.
      setState(() {
        totalCalorieBurn = aveCal * inputMinutes;// Update totalCalorieBurn when aveCal is updated
        print("aveCal:");
        print(aveCal);
        print("inputMinutes:");
        print(inputMinutes);
      });
    }
  }

  void insertnewdata() async {
    DateTime now = DateTime.now();  // 獲取當前時間
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);  // 將日期格式化為 'yyyy-MM-dd' 的格式

    var s = SportRecord(time: inputMinutes, calories: totalCalorieBurn, name: sportname, input_time: selectedDate);
    await DatabaseHelper.insertSportrec(s);
    ///回傳給API
    addSport(Userinfo.email, Userinfo.password,s);

    ///印出本地資料庫內容
    await DatabaseHelper.getSportRecordItems();
  }

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
        backgroundColor: Color(0xFFFAF7F7),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: Color(0xFF3C2E92),
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.arrow_back_outlined,
                color: Color(0xFFD4D4DC),
                size: 30.0,
              ),
              onPressed: () async {
                context.pushNamed('sport_record');
              },
            ),
            title: Text(
              'Hi! Celine',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.of(context).primaryBtnText,
                    fontSize: 25.0,
                  ),
            ),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://picsum.photos/seed/856/600',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
            centerTitle: false,
            toolbarHeight: 70.0,
            elevation: 2.0,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 20.0),
              child: Text(
                '請在此紀錄您的運動',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Poppins',
                      fontSize: 25.0,
                  color: Colors.black
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
              child: FlutterFlowDropDown<String>(
                controller: _model.dropDownValueController ??=
                    FormFieldController<String>(null),
                options: ['瑜珈', '跳舞(慢)、元極舞', '跳舞(快)、國際標準舞', '太極拳', '有氧舞蹈'],
                ///修改後
                onChanged: (val) {
                  setState(() {
                    _model.dropDownValue = val;
                    sportname = val!;
                    assignSportCalorieByName(_model.dropDownValue); // 當運動選項變更時，更新平均熱量

                  });
                },
                ///
                width: 300.0,
                height: 80.0,
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Poppins',
                  color: Colors.black
                ),
                hintText: '請選擇運動種類...',
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
                fillColor: Color(0xFFFAF7F7),
                elevation: 2.0,
                borderColor: Color(0xFFAE99E3),
                borderWidth: 2.0,
                borderRadius: 8.0,
                margin: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                hidesUnderline: true,
                isSearchable: false,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 0.0),
                  child: Text(
                    '此次選擇之運動為：',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          fontSize: 20.0,
                      color: Colors.black
                        ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 20.0, 0.0),
                    child: Text(
                      ///修改過
                      _model.dropDownValue ?? '尚未選擇', // 若尚未選擇任何運動，則顯示 '尚未選擇',
                      ///
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            fontSize: 20.0,
                        color: Colors.black
                          ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 10.0),
              child: TextFormField(
                controller: _model.textController,
                ///修改後
                onChanged: (val) {
                  setState(() {
                    _model.inputMinutes = double.parse(val);
                    inputMinutes = double.parse(val);  // 同時賦值給 inputMinutes
                    assignSportCalorieByName(_model.dropDownValue);
                  });
                },
                ///
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: '請輸入運動總時間...(單位：分鐘）',
                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Poppins',
                    color: Colors.grey
                  ),
                  hintStyle: FlutterFlowTheme.of(context).labelMedium,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFAE99E3),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFAE99E3),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium,
                validator: _model.textControllerValidator.asValidator(context),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 0.0),
                  child: Text(
                    '此次輸入之總時間為：',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          fontSize: 20.0,
                      color: Colors.black
                        ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 20.0, 0.0),
                    child: Text(
                      ///修改後
                      '${_model.inputMinutes} mins',
                      ///
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            fontSize: 20.0,
                        color: Colors.black
                          ),
                    ),
                  ),
                ),
              ],
            ),
            ///修改後增加時間
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
            ///
            Expanded(
              child: Align(
                alignment: AlignmentDirectional(-1.0, 1.0),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 20.0, 10.0),
                  child: Text(
                    'Total:',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFFCB5165),
                          fontSize: 30.0,
                        ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                    child: Text(
                      '本次運動之平均熱量消耗量：',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            fontSize: 20.0,
                        color: Colors.black
                          ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                      child: Text(
                        ///修改後
                        '$totalCalorieBurn kal',
                        ///
                        textAlign: TextAlign.end,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFFCB5165),
                              fontSize: 20.0,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FFButtonWidget(
              onPressed: () async {
                ///修改後
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
              },
              text: '加入運動',
              options: FFButtonOptions(
                height: 60.0,
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Color(0xFFAE99E3),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                elevation: 3.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
