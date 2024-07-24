import 'package:test/database/sqfilite_db.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import '../database/model.dart';
import '../api/api_manager.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'food_costumize_model.dart';
export 'food_costumize_model.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/permissions_util.dart';
import '/components/choose_detect_widget.dart';

class FoodCostumizeWidget extends StatefulWidget {
  const FoodCostumizeWidget({Key? key}) : super(key: key);

  @override
  _FoodCostumizeWidgetState createState() => _FoodCostumizeWidgetState();
}

class _FoodCostumizeWidgetState extends State<FoodCostumizeWidget> {
  late FoodCostumizeModel _model;
  int meal = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime now = new DateTime.now();
  String valueDay = '1';
  String valueMonth = '1';
  String valueYear = '2023';

  String selectedResult = ' ';
  int level = 0;
  int money = 0;
  int exp = 0;
  int id = 0;
  bool isLoading = false;

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

  void onSelectionChanged(String result) {
    setState(() {
      selectedResult = result;
    });
  }


  void initializeDateValues() {
    DateTime now = DateTime.now();
    valueDay = now.day.toString();
    valueMonth = now.month.toString();
    valueYear = now.year.toString();
  }

  Future<void> addFoodRec(FoodRecord f) async {
    await DatabaseHelper.insertFoodrec(f);
  }


  Future<void> addFoodDB(Food f) async {
    await DatabaseHelper.insertFood(f);
  }


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FoodCostumizeModel());
    _model.textController1 ??= TextEditingController(text: '自定義食品');
    _model.textController2 ??= TextEditingController();
    _model.textController3 ??= TextEditingController();
    _model.textController4 ??= TextEditingController();
    _model.textController5 ??= TextEditingController();
    _model.textController6 ??= TextEditingController();
    _model.textController7 ??= TextEditingController();
    _model.textController8 ??= TextEditingController();
    _model.textController9 ??= TextEditingController();
    _model.textController10 ??= TextEditingController();
    _model.textController11 ??= TextEditingController();
    initializeDateValues();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF3C2E92),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          buttonSize: 48,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            context.safePop();
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
            child: FlutterFlowIconButton(
              borderRadius: 20,
              borderWidth: 1,
              buttonSize: 48,
              icon: Icon(
                Icons.photo_camera,
                color: Color(0xFFFAF7F7),
                size: 30,
              ),
              onPressed: () async {
                String? result = await showModalBottomSheet<String>(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  enableDrag: false,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery
                          .of(context)
                          .viewInsets,
                      child: ChooseDetectWidget(
                        onSelectionChanged: onSelectionChanged,),
                    );
                  },
                );
                final selectedMedia = await selectMediaWithSourceBottomSheet(
                  context: context,
                  allowPhoto: true,
                );

                if (selectedMedia != null &&
                    selectedMedia
                        .every((m) =>
                        validateFileFormat(m.storagePath, context))) {
                  setState(() => _model.isDataUploading = true);
                  var selectedUploadedFiles = <FFUploadedFile>[];
                  try {
                    selectedUploadedFiles = selectedMedia
                        .map((m) =>
                        FFUploadedFile(
                          name: m.storagePath
                              .split('/')
                              .last,
                          bytes: m.bytes,
                          height: m.dimensions?.height,
                          width: m.dimensions?.width,
                          blurHash: m.blurHash,
                        ))
                        .toList();
                  }
                  finally {
                    _model.isDataUploading = false;
                  }
                  if (selectedUploadedFiles.length == selectedMedia.length) {
                    setState(() {
                      _model.uploadedLocalFile = selectedUploadedFiles.first;
                    });
                  }
                  else {
                    setState(() {});
                    return;
                  }

                  if (result == 'photo') {
                    context.pushNamed(
                      'photo_response',
                      queryParams: {
                        'response': _model.uploadedLocalFile.serialize(),
                      }.withoutNulls,
                    );

                  }
                  else {
                      setState(() {
                        isLoading = true;
                      });
                      _model.imageDetect = await UploadImageCall.call(
                        image: _model.uploadedLocalFile,
                        name: result,
                      );
                      setState(() {
                        isLoading = false; // 设置加载状态为false，隐藏加载指示器
                      });

                      setState(() {
                        _model.textController2.text = valueOrDefault<String>(
                          UploadImageCall.calorie(
                            (_model.imageDetect?.jsonBody ?? ''),
                          ).toString(),
                          '0.0',
                        );
                        _model.textController3.text = valueOrDefault<String>(
                          UploadImageCall.sugar(
                            (_model.imageDetect?.jsonBody ?? ''),
                          ).toString(),
                          '0.0',
                        );
                        _model.textController4.text = valueOrDefault<String>(
                          UploadImageCall.protein(
                            (_model.imageDetect?.jsonBody ?? ''),
                          ).toString(),
                          '0.0',
                        );
                        _model.textController5.text = valueOrDefault<String>(
                          UploadImageCall.carbon(
                            (_model.imageDetect?.jsonBody ?? ''),
                          ).toString(),
                          '0.0',
                        );
                        _model.textController6.text = valueOrDefault<String>(
                          UploadImageCall.saturatedFat(
                            (_model.imageDetect?.jsonBody ?? ''),
                          ).toString(),
                          '0.0',
                        );
                        _model.textController7.text = valueOrDefault<String>(
                          UploadImageCall.unsaturatedFat(
                            (_model.imageDetect?.jsonBody ?? ''),
                          ).toString(),
                          '0.0',
                        );
                        _model.textController8.text = valueOrDefault<String>(
                          UploadImageCall.fat(
                            (_model.imageDetect?.jsonBody ?? ''),
                          ).toString(),
                          '0.0',
                        );
                        _model.textController9.text = valueOrDefault<String>(
                          UploadImageCall.na(
                            (_model.imageDetect?.jsonBody ?? ''),
                          ).toString(),
                          '0.0',
                        );
                        _model.textController10.text = valueOrDefault<String>(
                          UploadImageCall.ca(
                            (_model.imageDetect?.jsonBody ?? ''),
                          ).toString(),
                          '0.0',
                        );
                        _model.textController11.text = valueOrDefault<String>(
                          UploadImageCall.k(
                            (_model.imageDetect?.jsonBody ?? ''),
                          ).toString(),
                          '0.0',
                        );

                      });
                    }
                  }
              }
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: isLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          )
          :SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '快速加入食品',
                      style:
                      FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF14181B),
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: TextFormField(
                              controller: _model.textController1,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: '食品名稱',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF4B39EF),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF14181B),
                                fontSize: 14,
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
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: TextFormField(
                              controller: _model.textController2,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: '卡路里',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: '(cal)',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF4B39EF),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF050505),
                                fontSize: 14,
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
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: TextFormField(
                              controller: _model.textController3,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: '糖',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: '(g)',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF4B39EF),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF050505),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              validator: _model.textController3Validator
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
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: TextFormField(
                              controller: _model.textController4,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: '蛋白質',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: '(g)',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF4B39EF),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF050505),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              validator: _model.textController4Validator
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
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                controller: _model.textController5,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: '碳水化合物',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: '(g)',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFE0E3E7),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF4B39EF),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF050505),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                validator: _model.textController5Validator
                                    .asValidator(context),
                              ),
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
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                controller: _model.textController8,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: '脂肪',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: '(g)',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFE0E3E7),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF4B39EF),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF050505),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                validator: _model.textController8Validator
                                    .asValidator(context),
                              ),
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
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                controller: _model.textController6,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: '飽和脂肪',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: '(g)',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFE0E3E7),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF4B39EF),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF050505),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                validator: _model.textController6Validator
                                    .asValidator(context),
                              ),
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
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                controller: _model.textController7,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: '反式脂肪',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: '(g)',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFE0E3E7),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF4B39EF),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF050505),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                validator: _model.textController7Validator
                                    .asValidator(context),
                              ),
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
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                controller: _model.textController9,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: '鈉',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: '(mg)',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFE0E3E7),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF4B39EF),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF050505),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                validator: _model.textController9Validator
                                    .asValidator(context),
                              ),
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
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                controller: _model.textController10,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: '鈣',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: '(mg)',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFE0E3E7),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF4B39EF),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF050505),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                validator: _model.textController10Validator
                                    .asValidator(context),
                              ),
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
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                controller: _model.textController11,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: '鉀',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: '(mg)',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFE0E3E7),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF4B39EF),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF050505),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                validator: _model.textController11Validator
                                    .asValidator(context),
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
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: FlutterFlowDropDown<String>(
                  controller: _model.dropDownValueController1 ??=
                      FormFieldController<String>(
                        _model.dropDownValue1 ??= '早餐',
                      ),
                  options: ['早餐', '午餐', '晚餐', '點心'],
                  onChanged: (val) =>
                      setState(() => _model.dropDownValue1 = val),
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: 50,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Poppins',
                    color: Colors.black
                  ),
                  hintText: '選擇飲食時段',
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24,
                  ),
                  fillColor: Colors.white,
                  elevation: 2,
                  borderColor: Color(0xFFDBE2E7),
                  borderWidth: 2,
                  borderRadius: 8,
                  margin: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                  hidesUnderline: true,
                  isSearchable: false,
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
                  onChangedDay: (value) => valueDay = value.toString(),
                  onChangedMonth: (value) => valueMonth = value.toString(),
                  onChangedYear: (value) => valueYear = value.toString(),
                  dayFlex: 4,// optional
                  yearFlex: 5,
                  monthFlex:6,// optional
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  if (_model.dropDownValue1 == '早餐') {
                    meal = 1;
                  } else if (_model.dropDownValue1 == '午餐') {
                    meal = 2;
                  } else if (_model.dropDownValue1 == '晚餐') {
                    meal = 3;
                  } else if (_model.dropDownValue1 == '點心') {
                    meal = 4;
                  }

                  try {
                    var obj = Food(
                      name: _model.textController1.text,
                      num: 1,
                      category: meal,
                      calories: double.tryParse(_model.textController2.text) ?? 0.0,
                      carbon: double.tryParse(_model.textController5.text) ?? 0.0,
                      protein: double.tryParse(_model.textController4.text) ?? 0.0,
                      sugar: double.tryParse(_model.textController3.text) ?? 0.0,
                      saturatedFat: double.tryParse(_model.textController6.text) ?? 0.0,
                      unsaturatedFat: double.tryParse(_model.textController7.text) ?? 0.0,
                      fat: double.tryParse(_model.textController8.text) ?? 0.0,
                      na: double.tryParse(_model.textController9.text) ?? 0.0,
                      ca: double.tryParse(_model.textController10.text) ?? 0.0,
                      k: double.tryParse(_model.textController11.text) ?? 0.0,
                      unit: '份',
                    );
                    var obj2 = Food(
                      name: _model.textController1.text,
                      num: 1,
                      category: 0,
                      calories: double.tryParse(_model.textController2.text) ?? 0.0,
                      carbon: double.tryParse(_model.textController5.text) ?? 0.0,
                      protein: double.tryParse(_model.textController4.text) ?? 0.0,
                      sugar: double.tryParse(_model.textController3.text) ?? 0.0,
                      saturatedFat: double.tryParse(_model.textController6.text) ?? 0.0,
                      unsaturatedFat: double.tryParse(_model.textController7.text) ?? 0.0,
                      fat: double.tryParse(_model.textController8.text) ?? 0.0,
                      na: double.tryParse(_model.textController9.text) ?? 0.0,
                      ca: double.tryParse(_model.textController10.text) ?? 0.0,
                      k: double.tryParse(_model.textController11.text) ?? 0.0,
                      unit: '份',
                    );

                    String dateString = '${valueYear.toString().padLeft(4, '0')}-${valueMonth.toString().padLeft(2, '0')}-${valueDay.toString().padLeft(2, '0')}';
                    var f = FoodRecord(date: dateString.toString(), foodObj: obj);

                    await addFoodRec(f);
                    await addFood(Userinfo.email, Userinfo.password, f);
                    await addFoodDB(obj2);

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
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (alertDialogContext) {
                        return AlertDialog(
                          title: Text('加入食品'),
                          content: Text('加入失敗！請再試一次。'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(alertDialogContext),
                              child: Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                text: '儲存食品',
                options: FFButtonOptions(
                  width: 270,
                  height: 50,
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: Color(0xFFAE99E3),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  elevation: 3,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
