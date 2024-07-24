import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:test/database/sqfilite_db.dart';
import '../database/model.dart';
import 'package:test/flutter_flow/internationalization.dart';
import 'food_weekend_model.dart';
export 'food_weekend_model.dart';

class FoodWeekendWidget extends StatefulWidget {
  const FoodWeekendWidget({Key? key}) : super(key: key);

  @override
  _FoodWeekendWidgetState createState() => _FoodWeekendWidgetState();
}

class _FoodWeekendWidgetState extends State<FoodWeekendWidget> {
  late FoodWeekendModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? date ;
  double calories = 0.0;
  String foodName = ' ';
  List<Map> foods = [];
  double water = 0.0;

  Future<void> refreshData() async {
    final w = await DatabaseHelper.getWater(date.toString());
    final l = await DatabaseHelper.getFoodRecordItems(date.toString());
    setState(() {
      water = w;
      foods = l;
    });
  }


  @override
  void initState() {
    super.initState();
    refreshData();
    _model = createModel(context, () => FoodWeekendModel());
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
        backgroundColor: Color(0xFFF1F4F8),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            backgroundColor: Color(0xFF3C2E92),
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Color(0xFF3C2E92),
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              fillColor: Color(0xFF3C2E92),
              icon: Icon(
                Icons.arrow_back_outlined,
                color: Color(0xFFE5E0EB),
                size: 30,
              ),
              onPressed: () async {
                context.safePop();
              },
            ),
            title: Text(
                '歷史飲食紀錄' /* 晚餐 */,
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                color: Color(0xFFE5E0EB),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: false,
            elevation: 2,
          ),
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView (
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FlutterFlowCalendar(
                  color: Color(0xFFBEB1DA),
                  iconColor: FlutterFlowTheme.of(context).secondaryText,
                  weekFormat: true,
                  weekStartsMonday: false,
                  initialDate: getCurrentTimestamp,
                  rowHeight: 64,
                  onChange: (newSelectedDate) {
                    setState(() => _model.calendarSelectedDay = newSelectedDate);
                    date = _model.calendarSelectedDay?.start.toLocal().toString().split(' ')[0];
                    refreshData();
                  },
                  titleStyle: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Poppins',
                    color: Color(0xFF0D0F10),
                  ),
                  dateStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Poppins',
                    color: Color(0xFF0D0303),
                  ),
                  selectedDateStyle:
                  FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Poppins',
                    color: Color(0xFF0D0F10),
                  ),
                  locale: FFLocalizations.of(context).languageCode,
                ),
                // Generated code for this Container Widget...
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0xFFAE99E3),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 8, 15, 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Water' /* Hello World */,
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Text(
                                '$water ml',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                color: Color(0xFF4B39EF),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    if (foods.isEmpty) {
                      // Display "No data" message
                      return Center(
                        child: Text(
                          '該日無飲食紀錄',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    var food = foods[index];
                    return Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0xFFAE99E3),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7, // Adjust the width as needed
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Color(0x25000000),
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(15, 8, 15, 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      food['food'], // Replace with your actual item title
                                      style: FlutterFlowTheme.of(context).headlineMedium.override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF101213),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                      child: Text(
                                        '${food['calorie']}大卡', // Replace with your actual item calories
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF4B39EF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(1, 0.5),
                                child: FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  borderWidth: 1,
                                  buttonSize: 60,
                                  icon: Icon(
                                    Icons.navigate_next,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    context.pushNamed('nutrient_record', queryParams: food.map((key, value) =>
                                        MapEntry(key, value.toString())));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
