import 'package:test/api/api_manager.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'water_target_model.dart';
export 'water_target_model.dart';
import 'package:test/api/api_manager.dart';
import 'package:test/database/model.dart';
import 'package:test/database/sqfilite_db.dart';

class WaterTargetWidget extends StatefulWidget {
  const WaterTargetWidget({Key? key}) : super(key: key);

  @override
  _WaterTargetWidgetState createState() => _WaterTargetWidgetState();
}

class _WaterTargetWidgetState extends State<WaterTargetWidget> {
  late WaterTargetModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Userinfo user;
  void update(water) async {
    user = await updateTgWater(Userinfo.email, Userinfo.password, water);
    await DatabaseHelper.updateTgWater(user.id, user);
  }
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WaterTargetModel());

    _model.textController ??= TextEditingController();
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
              context.safePop();
            },
          ),
          title: FFButtonWidget(
            onPressed: () {
              print('Button pressed ...');
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
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
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        '飲水量目標',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF090F13),
                          fontSize: 22,
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
            padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
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
                        '請在此輸入欲修改的飲水量目標',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF858E99),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(8, 10, 8, 0),
                              child: TextFormField(
                                controller: _model.textController,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'ex. 2000、1500',
                                  labelStyle:
                                  FlutterFlowTheme.of(context).bodySmall,
                                  hintStyle:
                                  FlutterFlowTheme.of(context).labelMedium,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF3C2E92),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                      FlutterFlowTheme.of(context).primary,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyMedium,
                                keyboardType: TextInputType.number,
                                cursorColor: Color(0xFF13112C),
                                validator: _model.textControllerValidator
                                    .asValidator(context),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'))
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 1),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                              child: Text(
                                'ml',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional(0, 1),
              child: FFButtonWidget(
                onPressed: () async {
                  update(_model.textController.text);
                  await showDialog(
                    context: context,
                    builder: (alertDialogContext) {
                      return AlertDialog(
                        title: Text('修改目標飲水量'),
                        content: Text('修改成功！'),
                        actions: [
                          TextButton(
                            onPressed: (() {
                              Navigator.pop(alertDialogContext);

                            }),
                            child: Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                  context.safePop();
                },
                text: '修改',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60,
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: Color(0xFF3C2E92),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  elevation: 2,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
