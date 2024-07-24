import 'package:test/api/api_manager.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'target_setting1_model.dart';
export 'target_setting1_model.dart';
import '../database/sqfilite_db.dart';
import '../database/model.dart';
class TargetSetting1Widget extends StatefulWidget {
  const TargetSetting1Widget({Key? key}) : super(key: key);

  @override
  _TargetSetting1WidgetState createState() => _TargetSetting1WidgetState();
}

class _TargetSetting1WidgetState extends State<TargetSetting1Widget> {
  late TargetSetting1Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  late Userinfo user;
  double weight = 0.0;
  double targetWeight = 0.0;
  void refreshData() async{
    final data = await DatabaseHelper.getItem();
    setState(() {
      weight = data[0]['weight'];
      targetWeight = data[0]['target_weight'];
    });
  }

  void updateTargetInfo(List<String> l) async {
    user = await updateTarget1(Userinfo.email, Userinfo.password, l);
    await DatabaseHelper.updateItem(user.id, user);
    refreshData();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TargetSetting1Model());

    // _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
    _model.textController3 ??= TextEditingController();
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // Align(
                                  //   alignment: AlignmentDirectional(-0.85, 0.0),
                                  //   child: Padding(
                                  //     padding: EdgeInsetsDirectional.fromSTEB(
                                  //         0.0, 10.0, 0.0, 0.0),
                                  //     child: Text(
                                  //       '1. 身高：',
                                  //       textAlign: TextAlign.start,
                                  //       style: FlutterFlowTheme.of(context)
                                  //           .bodyMedium
                                  //           .override(
                                  //             fontFamily: 'Poppins',
                                  //             fontSize: 20.0,
                                  //           ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: EdgeInsetsDirectional.fromSTEB(
                                  //       15.0, 0.0, 15.0, 0.0),
                                  //   child: Container(
                                  //     width: double.infinity,
                                  //     height: 50.0,
                                  //     decoration: BoxDecoration(
                                  //       color: FlutterFlowTheme.of(context)
                                  //           .secondaryBackground,
                                  //       borderRadius:
                                  //           BorderRadius.circular(15.0),
                                  //     ),
                                  //     child: Padding(
                                  //       padding: EdgeInsetsDirectional.fromSTEB(
                                  //           20.0, 0.0, 20.0, 0.0),
                                  //       child: TextFormField(
                                  //         controller: _model.textController1,
                                  //         autofocus: true,
                                  //         obscureText: false,
                                  //         decoration: InputDecoration(
                                  //           hintText: 'ex. 158',
                                  //           hintStyle:
                                  //               FlutterFlowTheme.of(context)
                                  //                   .bodySmall,
                                  //           enabledBorder: UnderlineInputBorder(
                                  //             borderSide: BorderSide(
                                  //               color: Color(0x00000000),
                                  //               width: 1.0,
                                  //             ),
                                  //             borderRadius:
                                  //                 const BorderRadius.only(
                                  //               topLeft: Radius.circular(4.0),
                                  //               topRight: Radius.circular(4.0),
                                  //             ),
                                  //           ),
                                  //           focusedBorder: UnderlineInputBorder(
                                  //             borderSide: BorderSide(
                                  //               color: Color(0x00000000),
                                  //               width: 1.0,
                                  //             ),
                                  //             borderRadius:
                                  //                 const BorderRadius.only(
                                  //               topLeft: Radius.circular(4.0),
                                  //               topRight: Radius.circular(4.0),
                                  //             ),
                                  //           ),
                                  //           errorBorder: UnderlineInputBorder(
                                  //             borderSide: BorderSide(
                                  //               color: Color(0x00000000),
                                  //               width: 1.0,
                                  //             ),
                                  //             borderRadius:
                                  //                 const BorderRadius.only(
                                  //               topLeft: Radius.circular(4.0),
                                  //               topRight: Radius.circular(4.0),
                                  //             ),
                                  //           ),
                                  //           focusedErrorBorder:
                                  //               UnderlineInputBorder(
                                  //             borderSide: BorderSide(
                                  //               color: Color(0x00000000),
                                  //               width: 1.0,
                                  //             ),
                                  //             borderRadius:
                                  //                 const BorderRadius.only(
                                  //               topLeft: Radius.circular(4.0),
                                  //               topRight: Radius.circular(4.0),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         style: FlutterFlowTheme.of(context)
                                  //             .bodyMedium,
                                  //         validator: _model
                                  //             .textController1Validator
                                  //             .asValidator(context),
                                  //         inputFormatters: [
                                  //           FilteringTextInputFormatter.allow(
                                  //               RegExp('[0-9]'))
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  Align(
                                    alignment: AlignmentDirectional(-0.85, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Text(
                                        '1. 現在體重：',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 20.0,
                                          color: Colors.black
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 15.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 0.0),
                                        child: TextFormField(
                                          controller: _model.textController2,
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: weight.toString(),
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall,
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                          validator: _model
                                              .textController2Validator
                                              .asValidator(context),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]'))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-0.85, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Text(
                                        '2. 目標體重：',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 20.0,
                                          color: Colors.black
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 15.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 0.0),
                                        child: TextFormField(
                                          controller: _model.textController3,
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: targetWeight.toString(),
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall,
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                          validator: _model
                                              .textController3Validator
                                              .asValidator(context),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]'))
                                          ],
                                        ),
                                      ),
                                    ),
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
                                final updateList = <String> [
                                  _model.textController2.text,
                                  _model.textController3.text
                                ];
                                updateTargetInfo(updateList);
                                context.pushNamed('target_setting2');
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
