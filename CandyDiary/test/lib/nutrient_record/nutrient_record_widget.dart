import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'nutrient_record_model.dart';
export 'nutrient_record_model.dart';

class NutrientRecordWidget extends StatefulWidget {
  const NutrientRecordWidget({
    Key? key,
    required this.input_time,
    required this.food,
    required this.carbon,
    required this.sugar,
    required this.fat,
    required this.saturated_fat,
    required this.unsaturated_fat,
    required this.protein,
    required this.calorie,
    required this.na,
    required this.ca,
    required this.k,
    required this.num,
    required this.meal,
    required this.unit
  }) :super(key: key);

  final String food;
  final String input_time;
  final String carbon;
  final String sugar;
  final String fat;
  final String saturated_fat;
  final String unsaturated_fat;
  final String calorie;
  final String na;
  final String ca;
  final String k;
  final String num;
  final String meal;
  final String unit;
  final String protein;

  @override
  _NutrientRecordWidgetState createState() => _NutrientRecordWidgetState();
}

class _NutrientRecordWidgetState extends State<NutrientRecordWidget> {
  late NutrientRecordModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NutrientRecordModel());
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
                      'name',
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
                        widget.food,
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
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Calories',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF95A1AC),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          '${widget.calorie} kcal',
                          textAlign: TextAlign.end,
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
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 8, 20, 0),
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
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        '${widget.carbon} g',
                        textAlign: TextAlign.start,
                        style:
                        FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF090F13),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(32, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sugars',
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
                          '${widget.sugar} g',
                          textAlign: TextAlign.start,
                          style:
                          FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 18,
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
                        'Total Fat',
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
                          '${widget.fat} g',
                          textAlign: TextAlign.start,
                          style:
                          FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 16,
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
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          '${widget.saturated_fat} g',
                          textAlign: TextAlign.start,
                          style:
                          FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 16,
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
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        '${widget.unsaturated_fat} g',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ],
                  ),
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
                        'Protein',
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
                          '${widget.protein} g',
                          textAlign: TextAlign.start,
                          style:
                          FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 16,
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
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
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
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          '${widget.na} mg',
                          textAlign: TextAlign.start,
                          style:
                          FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 16,
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
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          '${widget.ca} mg',
                          textAlign: TextAlign.start,
                          style:
                          FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 16,
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
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          '${widget.k} mg',
                          textAlign: TextAlign.start,
                          style:
                          FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 16,
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
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFF3C2E92),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.num,
                    textAlign: TextAlign.end,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                  child: Text(
                    widget.unit,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
