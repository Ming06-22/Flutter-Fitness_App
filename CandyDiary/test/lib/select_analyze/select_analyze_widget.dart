import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'select_analyze_model.dart';
export 'select_analyze_model.dart';

class SelectAnalyzeWidget extends StatefulWidget {
  const SelectAnalyzeWidget({Key? key}) : super(key: key);

  @override
  _SelectAnalyzeWidgetState createState() => _SelectAnalyzeWidgetState();
}

class _SelectAnalyzeWidgetState extends State<SelectAnalyzeWidget> {
  late SelectAnalyzeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectAnalyzeModel());
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
                color: Color(0xFFE5E0EB),
                size: 30,
              ),
              onPressed: () async {
                context.pushNamed('Homepage');
              },
            ),
            title: FFButtonWidget(
              onPressed: () {
                context.pushNamed('Homepage');
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
            actions: [],
            centerTitle: false,
            toolbarHeight: 70,
            elevation: 2,
          ),
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    '- 結算報告 -',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Poppins',
                      color: Color(0xFF0D0814),
                      fontSize: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color: Color(0xFFDACBEB),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Text(
                              '挑選您想了解的結算報告：',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Poppins',
                                fontSize: 25,
                                color: Color(0xFF050505),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.53,
                              decoration: BoxDecoration(
                                color: Color(0xFFDDCBE9),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15, 0, 15, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        context.pushNamed('analyze');
                                      },
                                      text: '整日結算報告',
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 80,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        iconPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        color: Color(0xFFA492BE),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15, 0, 15, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        Future.delayed(const Duration(milliseconds:200), () {
                                          context.pushNamed('weight_analyze');
                                        });
                                      },
                                      text: '體重變化報告',
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 80,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        iconPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        color: Color(0xFFA492BE),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
