import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'photo_response_model.dart';
export 'photo_response_model.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import 'package:test/flutter_flow/uploaded_file.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:test/database/model.dart';
import 'package:test/database/sqfilite_db.dart';
import 'package:test/api/api_manager.dart';
class PhotoResponseWidget extends StatefulWidget {
  const PhotoResponseWidget({
    Key? key,
    required this.response,

   }) :super(key: key);

  final String response;

  @override
  _PhotoResponseWidgetState createState() => _PhotoResponseWidgetState();
}

class _PhotoResponseWidgetState extends State<PhotoResponseWidget> {
  late PhotoResponseModel _model;

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
    _model = createModel(context, () => PhotoResponseModel());
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
    FFUploadedFile uploadedFile = FFUploadedFile.deserialize(widget.response);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF1F4F8),
        appBar: PreferredSize(
          preferredSize:
          Size.fromHeight(MediaQuery.of(context).size.height * 0.09),
          child: AppBar(
            backgroundColor: Color(0xFF3C2E92),
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(1, 0, 0, 0),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xFFD4D4DC),
                  size: 30,
                ),
                onPressed: () async {
                  context.safePop();
                },
              ),
            ),
            actions: [],
            centerTitle: false,
            toolbarHeight: 100,
            elevation: 0,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: FutureBuilder<ApiCallResponse>(
                future: UploadImageCall.call(
                  name: 'photo',
                  image: uploadedFile,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  else if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  final swipeableStackUploadImageResponse = snapshot.data!;
                  final getFoodsResponse = UploadImageCall.getFoods(
                    swipeableStackUploadImageResponse.jsonBody,
                  )?.toList() ?? [];

                  if (getFoodsResponse.isEmpty) {
                    return // Generated code for this Column Widget...
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Unrecognized' ,
                                      style: FlutterFlowTheme.of(context).headlineMedium.override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF7755C9),
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                      child: Text(
                                          'Please try again.',
                                        style: FlutterFlowTheme.of(context).titleSmall.override(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFFAE99E3),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                  }
                  return Builder(
                    builder: (context) {
                      return FlutterFlowSwipeableStack(
                        topCardHeightFraction: 0.72,
                        middleCardHeightFraction: 0.68,
                        bottomCardHeightFraction: 0.8,
                        topCardWidthFraction: 0.9,
                        middleCardWidthFraction: 0.85,
                        bottomCardWidthFraction: 0.8,
                        onSwipeFn: (index) {},
                        onLeftSwipe: (index) {},
                        onRightSwipe: (index) {},
                        onUpSwipe: (index) {},
                        onDownSwipe: (index) {},
                        itemBuilder: (context, getFoodsResponseIndex) {
                          final getFoodsResponseItem = getFoodsResponse[getFoodsResponseIndex];
                          return Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 20, 0, 0),
                                          child: Text(
                                            getJsonField(
                                              getFoodsResponseItem,
                                              r'''$.name''',
                                            ).toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF14181B),
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 16, 24, 0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 0,
                                                  color: Color(0xFFF1F4F8),
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      '份量' /* 份量 */,
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .labelLarge
                                                        .override(
                                                      fontFamily:
                                                      'Plus Jakarta Sans',
                                                      color:
                                                      Color(0xFF57636C),
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  getJsonField(
                                                    getFoodsResponseItem,
                                                    r'''$.num''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyLarge
                                                      .override(
                                                    fontFamily:
                                                    'Plus Jakarta Sans',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 1, 24, 0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 0,
                                                  color: Color(0xFFF1F4F8),
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      '熱量' /* 熱量 */,
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .labelLarge
                                                        .override(
                                                      fontFamily:
                                                      'Plus Jakarta Sans',
                                                      color:
                                                      Color(0xFF57636C),
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  getJsonField(
                                                    getFoodsResponseItem,
                                                    r'''$.calorie''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyLarge
                                                      .override(
                                                    fontFamily:
                                                    'Plus Jakarta Sans',
                                                    color:
                                                    Color(0xFF14181B),
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 1, 24, 0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 0,
                                                  color: Color(0xFFF1F4F8),
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      '碳水化合物' /* 碳水化合物 */,
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .labelLarge
                                                        .override(
                                                      fontFamily:
                                                      'Plus Jakarta Sans',
                                                      color:
                                                      Color(0xFF57636C),
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  getJsonField(
                                                    getFoodsResponseItem,
                                                    r'''$.carbon''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyLarge
                                                      .override(
                                                    fontFamily:
                                                    'Plus Jakarta Sans',
                                                    color:
                                                    Color(0xFF14181B),
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 1, 24, 0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 0,
                                                  color: Color(0xFFF1F4F8),
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      '蛋白質' /* 蛋白質 */,
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .labelLarge
                                                        .override(
                                                      fontFamily:
                                                      'Plus Jakarta Sans',
                                                      color:
                                                      Color(0xFF57636C),
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  getJsonField(
                                                    getFoodsResponseItem,
                                                    r'''$.protein''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyLarge
                                                      .override(
                                                    fontFamily:
                                                    'Plus Jakarta Sans',
                                                    color:
                                                    Color(0xFF14181B),
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 1, 24, 0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 0,
                                                  color: Color(0xFFF1F4F8),
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      '脂肪' /* 脂肪 */,
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .labelLarge
                                                        .override(
                                                      fontFamily:
                                                      'Plus Jakarta Sans',
                                                      color:
                                                      Color(0xFF57636C),
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  getJsonField(
                                                    getFoodsResponseItem,
                                                    r'''$.fat''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyLarge
                                                      .override(
                                                    fontFamily:
                                                    'Plus Jakarta Sans',
                                                    color:
                                                    Color(0xFF14181B),
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 1, 24, 0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 0,
                                                  color: Color(0xFFF1F4F8),
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      '飽和脂肪' /* 飽和脂肪 */,
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .labelLarge
                                                        .override(
                                                      fontFamily:
                                                      'Plus Jakarta Sans',
                                                      color:
                                                      Color(0xFF57636C),
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  getJsonField(
                                                    getFoodsResponseItem,
                                                    r'''$.saturated_fat''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyLarge
                                                      .override(
                                                    fontFamily:
                                                    'Plus Jakarta Sans',
                                                    color:
                                                    Color(0xFF14181B),
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 1, 24, 0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 0,
                                                  color: Color(0xFFF1F4F8),
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      '反式脂肪' /* 反式脂肪 */,
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .labelLarge
                                                        .override(
                                                      fontFamily:
                                                      'Plus Jakarta Sans',
                                                      color:
                                                      Color(0xFF57636C),
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  getJsonField(
                                                    getFoodsResponseItem,
                                                    r'''$.unsaturated_fat''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyLarge
                                                      .override(
                                                    fontFamily:
                                                    'Plus Jakarta Sans',
                                                    color:
                                                    Color(0xFF14181B),
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 1, 24, 0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 0,
                                                  color: Color(0xFFF1F4F8),
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      '糖類' /* 糖 */,
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .labelLarge
                                                        .override(
                                                      fontFamily:
                                                      'Plus Jakarta Sans',
                                                      color:
                                                      Color(0xFF57636C),
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  getJsonField(
                                                    getFoodsResponseItem,
                                                    r'''$.sugar''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyLarge
                                                      .override(
                                                    fontFamily:
                                                    'Plus Jakarta Sans',
                                                    color:
                                                    Color(0xFF14181B),
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 1, 24, 0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 0,
                                                  color: Color(0xFFF1F4F8),
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      '鈉' /* 鈉 */,
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .labelLarge
                                                        .override(
                                                      fontFamily:
                                                      'Plus Jakarta Sans',
                                                      color:
                                                      Color(0xFF57636C),
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  getJsonField(
                                                    getFoodsResponseItem,
                                                    r'''$.na''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyLarge
                                                      .override(
                                                    fontFamily:
                                                    'Plus Jakarta Sans',
                                                    color:
                                                    Color(0xFF14181B),
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 1, 24, 0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 0,
                                                  color: Color(0xFFF1F4F8),
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      '鈣' /* 鈣 */,
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .labelLarge
                                                        .override(
                                                      fontFamily:
                                                      'Plus Jakarta Sans',
                                                      color:
                                                      Color(0xFF57636C),
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  getJsonField(
                                                    getFoodsResponseItem,
                                                    r'''$.ca''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyLarge
                                                      .override(
                                                    fontFamily:
                                                    'Plus Jakarta Sans',
                                                    color:
                                                    Color(0xFF14181B),
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 1, 24, 0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 0,
                                                  color: Color(0xFFF1F4F8),
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      '鉀' /* 鉀 */,
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .labelLarge
                                                        .override(
                                                      fontFamily:
                                                      'Plus Jakarta Sans',
                                                      color:
                                                      Color(0xFF57636C),
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  getJsonField(
                                                    getFoodsResponseItem,
                                                    r'''$.k''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyLarge
                                                      .override(
                                                    fontFamily:
                                                    'Plus Jakarta Sans',
                                                    color:
                                                    Color(0xFF14181B),
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              10, 10, 10, 10),
                                          child: Container(
                                            width: double.infinity,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 0,
                                                  color: Color(0xFFF1F4F8),
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      5, 0, 0, 0),
                                                  child: FlutterFlowDropDown<
                                                      String>(
                                                    controller: _model
                                                        .dropDownValueController ??=
                                                        FormFieldController<
                                                            String>(
                                                          _model.dropDownValue ??=
                                                          '',
                                                        ),
                                                    options: ['1', '2', '3', '4'],
                                                    optionLabels: ['早餐', '午餐', '晚餐', '點心'],
                                                    onChanged: (val) =>
                                                        setState(() => _model.dropDownValue = val),
                                                    width: 100,
                                                    height: 50,
                                                    textStyle:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .bodyMedium
                                                        .override(
                                                      fontFamily:
                                                      'Poppins',
                                                      color: Colors
                                                          .black,
                                                    ),
                                                    hintText:
                                                      '請選擇',
                                                    fillColor:
                                                    Color(0xFFE5E0EB),
                                                    elevation: 2,
                                                    borderColor:
                                                    Color(0xFFE5E0EB),
                                                    borderWidth: 5,
                                                    borderRadius: 10,
                                                    margin:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        12, 4, 12, 4),
                                                    hidesUnderline: true,
                                                    isSearchable: false,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                    _model.textController,
                                                    obscureText: false,
                                                    decoration:
                                                    InputDecoration(
                                                      hintText:
                                                        '1.0' ,
                                                      hintStyle:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodySmall,
                                                      enabledBorder:
                                                      UnderlineInputBorder(
                                                        borderSide:
                                                        BorderSide(
                                                          color: Color(
                                                              0x00000000),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .only(
                                                          topLeft:
                                                          Radius.circular(
                                                              4.0),
                                                          topRight:
                                                          Radius.circular(
                                                              4.0),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                      UnderlineInputBorder(
                                                        borderSide:
                                                        BorderSide(
                                                          color: Color(
                                                              0x00000000),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .only(
                                                          topLeft:
                                                          Radius.circular(
                                                              4.0),
                                                          topRight:
                                                          Radius.circular(
                                                              4.0),
                                                        ),
                                                      ),
                                                      errorBorder:
                                                      UnderlineInputBorder(
                                                        borderSide:
                                                        BorderSide(
                                                          color: Color(
                                                              0x00000000),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .only(
                                                          topLeft:
                                                          Radius.circular(
                                                              4.0),
                                                          topRight:
                                                          Radius.circular(
                                                              4.0),
                                                        ),
                                                      ),
                                                      focusedErrorBorder:
                                                      UnderlineInputBorder(
                                                        borderSide:
                                                        BorderSide(
                                                          color: Color(
                                                              0x00000000),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .only(
                                                          topLeft:
                                                          Radius.circular(
                                                              4.0),
                                                          topRight:
                                                          Radius.circular(
                                                              4.0),
                                                        ),
                                                      ),
                                                      contentPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0, 0,
                                                          15, 0),
                                                    ),
                                                    style:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .bodyMedium,
                                                    textAlign: TextAlign.end,
                                                    validator: _model
                                                        .textControllerValidator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                  AlignmentDirectional(
                                                      0, 0),
                                                  child: Container(
                                                    width: 60,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color:
                                                      Color(0xFFE5E0EB),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(10),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(10, 15, 10, 10),
                                                      child: Text(
                                                        getJsonField(
                                                          getFoodsResponseItem,
                                                          r'''$.unit''',
                                                        ).toString(),
                                                        textAlign: TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .of(context)
                                                            .bodyMedium,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    print(_model.dropDownValue);
                                    if (_model.dropDownValue == "") {
                                      showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('警告'),
                                            content: Text('請選擇飲食時段!!'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(
                                                        alertDialogContext),
                                                child: Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      return;
                                    }

                                    double n = 1.0;

                                    try {
                                      double tmp = _model.textController.text.isEmpty ? 1.0
                                          : double.tryParse(_model.textController.text.trim()) ?? 1.0;

                                      if (getFoodsResponseItem['unit'] == '份') {
                                        n = tmp;
                                      } else
                                      if (getFoodsResponseItem['unit'] == 'g') {
                                        n = tmp / 100.0;
                                      }

                                      var cal = getFoodsResponseItem['calorie'] * n;
                                      var carbon = getFoodsResponseItem['carbon'] * n;
                                      var sugar = getFoodsResponseItem['sugar'] * n;
                                      var fat = getFoodsResponseItem['fat'] * n;
                                      var sFat = getFoodsResponseItem['saturated_fat'] * n;
                                      var uFat = getFoodsResponseItem['unsaturated_fat'] * n;
                                      var protein = getFoodsResponseItem['protein'] * n;
                                      var na = getFoodsResponseItem['na'] * n;
                                      var ca = getFoodsResponseItem['ca'] * n;
                                      var k = getFoodsResponseItem['k'] * n;

                                      int meal = 1;
                                      if (_model.dropDownValue == '1')
                                        meal = 1;
                                      else if (_model.dropDownValue == '2')
                                        meal = 2;
                                      else if (_model.dropDownValue == '3')
                                        meal = 3;
                                      else if (_model.dropDownValue == '4')
                                        meal = 4;

                                      Food obj = Food(
                                          name: getFoodsResponseItem['name'],
                                          calories: cal,
                                          carbon: carbon,
                                          protein: protein,
                                          sugar: sugar,
                                          fat: fat,
                                          unsaturatedFat: uFat,
                                          saturatedFat: sFat,
                                          na: na,
                                          ca: ca,
                                          k: k,
                                          unit: getFoodsResponseItem['unit'],
                                          num: tmp,
                                          category: meal);

                                      final now = DateTime.now();
                                      final formatter = DateFormat(
                                          'yyyy-MM-dd');
                                      String d = formatter.format(now);

                                      FoodRecord f = FoodRecord(
                                          date: d, foodObj: obj);
                                      await DatabaseHelper.insertFoodrec(f);
                                      await addFood(
                                          Userinfo.email, Userinfo.password, f);

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
                                    } catch (e) {
                                      showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text('錯誤'),
                                              content: Text('輸入無效的數值!!'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child: Text('Ok'),
                                                ),
                                              ],
                                            );
                                          },
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 65,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF4B39EF),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Color(0x411D2429),
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Add' /* Add  */,
                                            textAlign: TextAlign.center,
                                            style:
                                            FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                              fontFamily:
                                              'Plus Jakarta Sans',
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight:
                                              FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: getFoodsResponse.length,
                        controller: _model.swipeableStackController,
                        enableSwipeUp: false,
                        enableSwipeDown: false,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
