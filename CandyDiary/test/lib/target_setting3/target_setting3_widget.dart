import 'package:test/api/api_manager.dart';
import 'package:quiver/collection.dart';
import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'target_setting3_model.dart';
export 'target_setting3_model.dart';
import '../database/sqfilite_db.dart';
import '../database/model.dart';
class TargetSetting3Widget extends StatefulWidget {
  const TargetSetting3Widget({Key? key}) : super(key: key);

  @override
  _TargetSetting3WidgetState createState() => _TargetSetting3WidgetState();
}

class _TargetSetting3WidgetState extends State<TargetSetting3Widget> {
  late TargetSetting3Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();


  List<String> rec = [];
  List<String> rec2 = [];
  bool isChanged = false;
  Future<void> refreshData() async {
    final illness = await DatabaseHelper.getIll();
    setState(() {
      if (illness[0]['ill1'] == 1)
        rec.add('糖尿病');
      if (illness[0]['ill2'] == 1)
        rec.add('乳糖不耐症');
      if (illness[0]['ill3'] == 1)
        rec.add('高血壓');
    });
  }
  void updateTargetInfo() async {
    final ill = await updateTarget3(Userinfo.email, Userinfo.password, rec2);
    await DatabaseHelper.updateIll(ill);
  }
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TargetSetting3Model());
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Text(
                    '- 目標設定 -',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF0D0814),
                          fontSize: 24.0,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(15.0, 10.0, 15.0, 0.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color: Color(0xFFDACBEB),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Text(
                              '是否有個人疾病史：',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 25.0,
                                color: Colors.black
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 20.0, 15.0, 0.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1.0,
                              height: MediaQuery.of(context).size.height * 0.53,
                              decoration: BoxDecoration(
                                color: Color(0xFFDDCBE9),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FlutterFlowCheckboxGroup(
                                    options: ['糖尿病', '乳糖不耐症', '高血壓'],
                                    onChanged: (val) => setState(() {
                                      isChanged = true;
                                      rec2 = val;
                                    }),
                                    controller:
                                        _model.checkboxGroupValueController ??=
                                            FormFieldController<List<String>>(
                                      rec,
                                    ),
                                    activeColor: Color(0xFFA492BE),
                                    checkColor: Colors.white,
                                    checkboxBorderColor:
                                        Colors.white,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 20.0,
                                      color: Colors.black
                                        ),
                                    itemPadding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 5.0),
                                    checkboxBorderRadius:
                                        BorderRadius.circular(5.0),
                                    initialized:
                                        _model.checkboxGroupValues != null,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (!listsEqual(rec, rec2) && isChanged == true) {
                                  print('update');
                                  updateTargetInfo();
                                }
                                context.pushNamed('user');
                              },
                              text: '確定',
                              options: FFButtonOptions(
                                width: 130.0,
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0xFFA492BE),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
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
        ),
      ),
    );
  }
}
