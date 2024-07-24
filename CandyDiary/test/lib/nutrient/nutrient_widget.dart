import 'package:test/api/api_manager.dart';
import 'package:test/database/model.dart';
import 'package:test/database/sqfilite_db.dart';

import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'nutrient_model.dart';
export 'nutrient_model.dart';

class NutrientWidget extends StatefulWidget {
  const NutrientWidget({
    Key? key,
    required this.name,
    required this.carbon,
    required this.sugar,
    required this.fat,
    required this.saturated_fat,
    required this.unsaturated_fat,
    required this.protein,
    required this.calorie,
    required this.Na,
    required this.Ca,
    required this.K,
    required this.num,
    required this.unit,
    required this.category
  }) :super(key: key);

  final String name;
  final String carbon;
  final String sugar;
  final String fat;
  final String saturated_fat;
  final String unsaturated_fat;
  final String calorie;
  final String Na;
  final String Ca;
  final String K;
  final String num;
  final String unit;
  final String protein;
  final String category;

  @override
  _NutrientWidgetState createState() => _NutrientWidgetState();
}

class _NutrientWidgetState extends State<NutrientWidget> {
  late NutrientModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  int level = 0;
  int money = 0;
  int exp = 0;
  int id = 0;

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

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NutrientModel());

    _model.textController ??= TextEditingController();
    refreshData();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF1F4F8),
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
              color: Color(0xFFE5E0EB),
              size: 30.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: FFButtonWidget(
            onPressed: () {
              print('Button pressed ...');
            },
            text: 'Candy Diary',
            options: FFButtonOptions(
              width: 185.0,
              height: 40.0,
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              color: Color(0xFF3C2E92),
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Poppins',
                    color: Color(0xFFD4D4DC),
                    fontSize: 22.0,
                  ),
              elevation: 2.0,
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          actions: [],
          centerTitle: false,
          toolbarHeight: 70.0,
          elevation: 2.0,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF95A1AC),
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                      child: Text(
                        widget.name,
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF090F13),
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Calories',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF95A1AC),
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                        child: Text(
                          '${widget.calorie} kcal',
                          textAlign: TextAlign.end,
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF090F13),
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 8.0, 20.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Carbs',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF95A1AC),
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                      child: Text(
                        '${widget.carbon} g',
                        textAlign: TextAlign.start,
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF090F13),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sugars',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF95A1AC),
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                        child: Text(
                          '${widget.sugar} g',
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Fat',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF95A1AC),
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                        child: Text(
                          '${widget.fat} g',
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saturated Fat',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF95A1AC),
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                        child: Text(
                          '${widget.saturated_fat} g',
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Unsaturated Fat',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF95A1AC),
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      Text(
                        '${widget.unsaturated_fat} g',
                        textAlign: TextAlign.start,
                        style:
                        FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF090F13),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Protein',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF95A1AC),
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                        child: Text(
                          '${widget.protein} g',
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.0,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sodium',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF95A1AC),
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                        child: Text(
                          '${widget.Na} mg',
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ca',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF95A1AC),
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                        child: Text(
                          '${widget.Ca} mg',
                          textAlign: TextAlign.start,
                          style:
                          FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'K',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF95A1AC),
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                        child: Text(
                          '${widget.K} mg',
                          textAlign: TextAlign.start,
                          style:
                          FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            width: double.infinity,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 0.0,
                  color: Color(0xFFF1F4F8),
                  offset: Offset(0.0, 1.0),
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                  child: FlutterFlowDropDown<String>(
                    controller: _model.dropDownValueController ??=
                        FormFieldController<String>(
                          _model.dropDownValue ??= '',
                        ),
                    options: ['1', '2', '3', '4'],
                    optionLabels: ['早餐', '午餐', '晚餐', '點心'],
                    onChanged: (val) =>
                        setState(() => _model.dropDownValue = val),
                    width: 100.0,
                    height: 50.0,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                    hintText: '請選擇',
                    fillColor: Color(0xFFE5E0EB),
                    elevation: 2.0,
                    borderColor: Color(0xFFE5E0EB),
                    borderWidth: 5.0,
                    borderRadius: 10.0,
                    margin:
                    EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 12.0, 4.0),
                    hidesUnderline: true,
                    isSearchable: false,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _model.textController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: widget.unit == '份' ? '1' : '100',
                      hintStyle: FlutterFlowTheme.of(context).bodySmall,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium,
                    textAlign: TextAlign.end,
                    validator:
                        _model.textControllerValidator.asValidator(context),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                  child: Container(
                    width: 60.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFE5E0EB),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        widget.unit,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: FFButtonWidget(
                onPressed: () async {
                  double n;
                  try {
                    n = double.parse(_model.textController.text);
                  } catch (e) {
                    n = 1.0;
                  }
                  var cal = double.parse(widget.calorie) * n;
                  var carbon = double.parse(widget.carbon) * n;
                  var sugar = double.parse(widget.sugar) * n;
                  var fat = double.parse(widget.fat) * n;
                  var sFat = double.parse(widget.saturated_fat) * n;
                  var uFat = double.parse(widget.unsaturated_fat) * n;
                  var protein = double.parse(widget.protein) * n;
                  var na = double.parse(widget.Na) * n;
                  var ca = double.parse(widget.Ca) * n;
                  var k = double.parse(widget.K) * n;
                  int meal = 1;
                  if (_model.dropDownValue == '1')
                    meal = 1;
                  else if (_model.dropDownValue == '2')
                    meal = 2;
                  else if (_model.dropDownValue == '3')
                    meal = 3;
                  else if (_model.dropDownValue == '4')
                    meal = 4;

                  Food obj = Food(name: widget.name, calories: cal, carbon: carbon,
                    protein: protein, sugar: sugar, fat: fat, unsaturatedFat: uFat, saturatedFat: sFat,
                    na: na, ca: ca, k: k, unit: widget.unit, num: n, category: meal);

                  final now = DateTime.now();
                  final formatter = DateFormat('yyyy-MM-dd');
                  String d = formatter.format(now);

                  FoodRecord f = FoodRecord(date: d, foodObj: obj);
                  await DatabaseHelper.insertFoodrec(f);
                  await addFood(Userinfo.email, Userinfo.password, f);

                  money += 10;
                  exp += 10;
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
                      title: Text('加入食品'),
                      content: Text('已加入成功！\n獲得 10 exp\n獲得 10 pt'),
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
                text: 'Add',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFF3C2E92),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                  elevation: 2.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
