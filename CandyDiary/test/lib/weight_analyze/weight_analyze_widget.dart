import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'weight_analyze_model.dart';
export 'weight_analyze_model.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/form_field_controller.dart';
import '../api/api_manager.dart';
import '../database/sqfilite_db.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '/database/model.dart';


class WeightAnalyzeWidget extends StatefulWidget {
  const WeightAnalyzeWidget({Key? key}) : super(key: key);

  @override
  _WeightAnalyzeWidgetState createState() => _WeightAnalyzeWidgetState();
}

class _WeightAnalyzeWidgetState extends State<WeightAnalyzeWidget> {
  late WeightAnalyzeModel _model;
  String weightChart = '';
  var Chart = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double weight = 0.0;
  int id = 0;
  double weightChange = 0.0;


  Future<void> refreshData() async {
    final data = await DatabaseHelper.getItem();
    setState(() {
      id = data[0]['id'];
      weight = data[0]['weight'];
    });
  }

  Future<void> refreshChart() async {
    ImageCache imageCache = PaintingBinding.instance!.imageCache!;
    // 清除图像缓存
    imageCache.clear();
    await DatabaseHelper.deleteOldImage();
    weightChart = await getWeightChart(Userinfo.email, Userinfo.password);
    setState(() {
      weightChart = weightChart;
    });
    print("拿到圖表了！!!");
    print(weightChart);
  }


  void updateUserWeight(List<String> l) async {
    addWeight(Userinfo.email, Userinfo.password, l);
  }

  void updateDBWeight(double weight) async {
    await DatabaseHelper.updateWeight(id, weight);
  }

  @override
  void initState() {
    super.initState();
    refreshData();
    refreshChart();
    _model = createModel(context, () => WeightAnalyzeModel());
  }

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
        backgroundColor: Color(0xFFE3D6EB),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            backgroundColor: Color(0xFF3C2E92),
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: Icon(
                Icons.arrow_back_outlined,
                color: Color(0xFFD4D4DC),
                size: 30,
              ),
              onPressed: () async {
                context.safePop();
              },
            ),
            title: FFButtonWidget(
              onPressed: () async {
                context.goNamed('HomePage');
              },
              text: 'Candy Diary',
              options: FFButtonOptions(
                width: 185,
                height: 40,
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: Color(0xFF3C2E92),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                  fontFamily: 'Poppins',
                  color: Color(0xFFD4D4DC),
                  fontSize: 22,
                ),
                elevation: 2,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            actions: [
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.analytics,
                  color: Color(0xFFD4D4DC),
                  size: 30,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.local_dining,
                  color: Color(0xFFD4D4DC),
                  size: 30,
                ),
                onPressed: () async {
                  context.pushNamed('record');
                },
              ),
            ],
            centerTitle: false,
            toolbarHeight: 70,
            elevation: 2,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, -1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(45, 0, 45, 20),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFFE5E0EB),
                            borderRadius: BorderRadius.circular(30),
                            shape: BoxShape.rectangle,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                child: Icon(
                                  Icons.trending_up_sharp,
                                  color: Colors.black,
                                  size: 40,
                                ),
                              ),
                              Text(
                                'Weight Report',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Poppins',
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                              child: Container(
                                width: 100,
                                constraints: BoxConstraints(
                                  maxWidth: double.infinity,
                                  maxHeight: double.infinity,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFE5E0EB),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 10),
                                        child: Text(
                                          '- 體重紀錄 -',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 0, 0, 0),
                                        child: Text(
                                          '目前體重：$weight kg',
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 15, 15, 15),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                15, 0, 0, 0),
                                            child: // Generated code for this DropDown Widget...
                                            FlutterFlowDropDown<String>(
                                              controller: _model.dropDownValueController ??= FormFieldController<String>(
                                                _model.dropDownValue ??= '40',
                                              ),
                                              options: List.generate(200, (index) => (35 + index*0.5).toString()),
                                              onChanged: (val) => setState((){
                                                _model.dropDownValue = val as String;
                                              }),
                                                width: 300,
                                                height: 50,
                                                searchHintTextStyle: FlutterFlowTheme.of(context).labelMedium,
                                                textStyle: FlutterFlowTheme.of(context).bodyMedium,
                                                searchHintText: 'Search for ...',
                                                hintText: '請選擇您的體重...',
                                                icon: Icon(
                                                Icons.keyboard_arrow_down_rounded,
                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                size: 24,
                                                ),
                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                elevation: 2,
                                                borderColor: Color(0xFF7467EF),
                                                borderWidth: 2,
                                              borderRadius: 8,
                                              margin: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                                              hidesUnderline: true,
                                              isSearchable: true,
                                          ),
                                          ),
                                        ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            50, 0, 50, 0),
                                        child: FFButtonWidget(
                                          onPressed: () async {

                                            setState(() {
                                              final updateList = <String>[
                                                id.toString(),
                                                _model.dropDownValue.toString(),
                                              ];
                                              updateUserWeight(updateList);
                                              updateDBWeight(double.parse(_model.dropDownValue.toString()));
                                              Future.delayed(const Duration(milliseconds:100), () {
                                                refreshChart();
                                                refreshData();
                                              });
                                            }
                                            );
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  content: Text('今日體重已登記成功！'),
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
                                            context.pushNamed('HomePage');
                                          },
                                          text: '確認',
                                          options: FFButtonOptions(
                                            width: 50,
                                            height: 40,
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                            iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                            color: Color(0xFFA492BE),
                                            textStyle:
                                            FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE5E0EB),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: Text(
                                          '- 體重分析圖 -',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          child: Transform.scale(
                                            scale: 1.06,
                                            child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              // Show loading indicator when weightChart is empty
                                              if (weightChart.isEmpty)
                                                Padding(
                                                  padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                      0, 10, 0, 10),
                                                  child: SpinKitCircle(
                                                    color: Colors.blue,
                                                    size: 50.0,
                                                  ),
                                                ),
                                              if (weightChart.isNotEmpty)
                                                Image.asset(
                                                  weightChart,
                                                  width: 350,
                                                  height: 300,
                                                  fit: BoxFit.contain,
                                                ),
                                            ],
                                          ),
                                          ),
                                        ),
                                      ),
                                    ],
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
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
