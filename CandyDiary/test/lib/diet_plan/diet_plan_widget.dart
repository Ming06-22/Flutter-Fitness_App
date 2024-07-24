import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'diet_plan_model.dart';
export 'diet_plan_model.dart';
import 'package:test/database/sqfilite_db.dart';
import 'package:test/api/api_manager.dart';
import '../database/model.dart';

class DietPlanWidget extends StatefulWidget {
  const DietPlanWidget({Key? key}) : super(key: key);

  @override
  _DietPlanWidgetState createState() => _DietPlanWidgetState();
}

class _DietPlanWidgetState extends State<DietPlanWidget> {
  late DietPlanModel _model;
  late Userinfo user;
  String plan = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  int get pageViewCurrentIndex => _model.pageViewController != null &&
          _model.pageViewController!.hasClients &&
          _model.pageViewController!.page != null
      ? _model.pageViewController!.page!.round()
      : 0;


  List<Map<String, dynamic>> myData = [];
  Future<void> refreshData() async {
    final data = await DatabaseHelper.getItem();
    setState(() {
      myData = data;
      if (myData[0]['theory'] == 1)
        plan = '生酮飲食法';
      else if (myData[0]['theory'] == 2)
        plan = '蛋白質減重法';
      else if (myData[0]['theory'] == 3)
        plan = '211餐盤減肥法';
      else if (myData[0]['theory'] == 4)
        plan = '減醣飲食';
      else if (myData[0]['theory'] == 5)
        plan = '地中海飲食法';
    });

  }

  void updateDietPlan(int theory) async {
    user = await updateDietplan(Userinfo.email, Userinfo.password, theory);
    await DatabaseHelper.updateItem(user.id, user);
    user = await getUser(Userinfo.email, Userinfo.password);
    await DatabaseHelper.updateItem(user.id, user);
    refreshData();
  }


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DietPlanModel());
    refreshData();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
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
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            context.pushNamed('user');
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: Color(0xFFFAF7F7),
            size: 32,
          ),
        ),
        title: Text(
          '減肥計劃',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
            fontFamily: 'Outfit',
            color: Color(0xFFFAF7F7),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
              child: PageView(
                controller: _model.pageViewController ??=
                    PageController(initialPage: 0),
                scrollDirection: Axis.horizontal,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/生酮.jpeg',
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  '生酮飲食法',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF0F1113),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                                color: Color(0xFFDBE2E7),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 8, 0, 5),
                                child: Text(
                                  '注意事項：',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 5),
                                child: Text(
                                  '1. 不適合對象: 肝臟類疾病患者',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text(
                                  '2. 可能造成營養不均衡',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                                color: Color(0xFFDBE2E7),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 10, 0),
                                    child: Icon(
                                      Icons.done,
                                      color: Color(0xFF050505),
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    '實行方法：',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF050505),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・高脂肪、低碳飲食方式',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・營養素比例：',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        40, 5, 0, 0),
                                    child: Text(
                                      '脂肪75~80%，碳水化合物10%以下，蛋白質20~35%。',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 10, 0),
                                      child: Icon(
                                        Icons.done,
                                        color: Color(0xFF050505),
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      '優點：',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・成效相對較快',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・精神變好、能協助控制血糖',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 10, 0),
                                      child: Icon(
                                        Icons.done,
                                        color: Color(0xFF050505),
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      '缺點：',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・營養不均衡，身體可能會產生不適',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・外食不易取得',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 20, 0, 24),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('更換成功！'),
                                    content: Text('已將減肥計劃更改為新的方案。'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                                );
                                updateDietPlan(1);
                              },
                              text: '選擇',
                              options: FFButtonOptions(
                                width: 300,
                                height: 60,
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: Color(0xFF4B39EF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                  fontFamily: 'Outfit',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                elevation: 3,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/蛋白質.jpeg',
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  '蛋白質減重法',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF0F1113),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                                color: Color(0xFFDBE2E7),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 8, 0, 5),
                                child: Text(
                                  '注意事項：',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 5),
                                child: Text(
                                  '1. 不適合有腎功能與血糖問題的人',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                                color: Color(0xFFDBE2E7),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 10, 0),
                                    child: Icon(
                                      Icons.done,
                                      color: Color(0xFF050505),
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    '實行方法：',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF050505),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・提高蛋白質的攝取量，達到25~30%',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・降低脂肪和澱粉的含量',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 10, 0),
                                      child: Icon(
                                        Icons.done,
                                        color: Color(0xFF050505),
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      '優點：',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・營養均衡，不過度忌口',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・漸漸調整為不復胖的易瘦體質',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 10, 0),
                                      child: Icon(
                                        Icons.done,
                                        color: Color(0xFF050505),
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      '缺點：',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・一次最多只能執行兩週，否則可能會造成身體營養素的不均衡',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 20, 0, 24),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('更換成功！'),
                                      content: Text('已將減肥計劃更改為新的方案。'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                updateDietPlan(2);
                              },
                              text: '選擇',
                              options: FFButtonOptions(
                                width: 300,
                                height: 60,
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: Color(0xFF4B39EF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                  fontFamily: 'Outfit',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                elevation: 3,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/211.jpeg',
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  '211餐盤減肥法',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF0F1113),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                                color: Color(0xFFDBE2E7),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 8, 0, 5),
                                child: Text(
                                  '注意事項：',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 5),
                                child: Text(
                                  '1. 不適合對象: 腎臟疾病患者',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                                color: Color(0xFFDBE2E7),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 10, 0),
                                    child: Icon(
                                      Icons.done,
                                      color: Color(0xFF050505),
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    '實行方法：',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF050505),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・餐盒平分為4等份：',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        45, 5, 0, 5),
                                    child: Text(
                                      '1/2蔬菜，1/4優質蛋白，1/4優質澱粉',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・盡量挑選「原型食材」取代加工食品',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 10, 0),
                                      child: Icon(
                                        Icons.done,
                                        color: Color(0xFF050505),
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      '優點：',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・正確比例更有飽足感',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・單純調整每餐的份量不需花大錢',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・適合長期執行',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 10, 0),
                                      child: Icon(
                                        Icons.done,
                                        color: Color(0xFF050505),
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      '缺點：',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・過度簡化飲食',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・僅根據固定比例來控制飲食',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・忽略食物的質量',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 20, 0, 24),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('更換成功！'),
                                      content: Text('已將減肥計劃更改為新的方案。'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                updateDietPlan(3);
                              },
                              text: '選擇',
                              options: FFButtonOptions(
                                width: 300,
                                height: 60,
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: Color(0xFF4B39EF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                  fontFamily: 'Outfit',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                elevation: 3,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/減醣.jpeg',
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  '減醣飲食法',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF0F1113),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                                color: Color(0xFFDBE2E7),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 8, 0, 5),
                                child: Text(
                                  '注意事項：',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 5),
                                child: Text(
                                  '1. 不適合對象: 腎功能不全患者',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 5),
                                child: Text(
                                  '2. 不適合對象: 甲狀腺、膽固醇問題者',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                                color: Color(0xFFDBE2E7),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 10, 0),
                                    child: Icon(
                                      Icons.done,
                                      color: Color(0xFF050505),
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    '實行方法：',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF050505),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・降低碳水化合物攝取',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・增加蛋白質和健康脂肪的攝取',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 10, 0),
                                      child: Icon(
                                        Icons.done,
                                        color: Color(0xFF050505),
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      '優點：',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・可能降低食欲，幫助減少體重',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・改善血糖控制',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 10, 0),
                                      child: Icon(
                                        Icons.done,
                                        color: Color(0xFF050505),
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      '缺點：',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・營養不均衡',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・習慣高碳水飲食的人可能感到飢餓和不適',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・很難長期堅持',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 20, 0, 24),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('更換成功！'),
                                      content: Text('已將減肥計劃更改為新的方案。'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                updateDietPlan(4);
                              },
                              text: '選擇',
                              options: FFButtonOptions(
                                width: 300,
                                height: 60,
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: Color(0xFF4B39EF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                  fontFamily: 'Outfit',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                elevation: 3,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/地中海.jpeg',
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  '地中海飲食法',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF0F1113),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                                color: Color(0xFFDBE2E7),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 8, 0, 5),
                                child: Text(
                                  '注意事項：',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 5),
                                child: Text(
                                  '1. 不適合對象:腎臟方面疾病患者',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                                color: Color(0xFFDBE2E7),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 10, 0),
                                    child: Icon(
                                      Icons.done,
                                      color: Color(0xFF050505),
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    '實行方法：',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF050505),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・拒絕精緻澱粉，避免吃下過多醣類',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・五穀飯、糙米、全麥麵包、地瓜等為主',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・攝取多樣化蔬果、使用健康橄欖油',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 10, 0),
                                      child: Icon(
                                        Icons.done,
                                        color: Color(0xFF050505),
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      '優點：',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・預防代謝症候群，有效管理體重',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・降低失智風險，改善憂鬱、促進心理健康',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 10, 0),
                                      child: Icon(
                                        Icons.done,
                                        color: Color(0xFF050505),
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      '缺點：',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・需耗費心思構思菜單',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 5, 0, 0),
                                    child: Text(
                                      '・外食開銷較大',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF050505),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 20, 0, 24),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('更換成功！'),
                                      content: Text('已將減肥計劃更改為新的方案。'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                updateDietPlan(5);
                              },
                              text: '選擇',
                              options: FFButtonOptions(
                                width: 300,
                                height: 60,
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: Color(0xFF4B39EF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                  fontFamily: 'Outfit',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                elevation: 3,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 1),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 16),
                child: smooth_page_indicator.SmoothPageIndicator(
                  controller: _model.pageViewController ??=
                      PageController(initialPage: 0),
                  count: 5,
                  axisDirection: Axis.horizontal,
                  onDotClicked: (i) async {
                    await _model.pageViewController!.animateToPage(
                      i,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  effect: smooth_page_indicator.ExpandingDotsEffect(
                    expansionFactor: 3,
                    spacing: 8,
                    radius: 16,
                    dotWidth: 16,
                    dotHeight: 8,
                    dotColor: FlutterFlowTheme.of(context).accent1,
                    activeDotColor: FlutterFlowTheme.of(context).primary,
                    paintStyle: PaintingStyle.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
