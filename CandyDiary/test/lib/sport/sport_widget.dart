import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/flutter_flow/utils.dart';
import 'sport_model.dart';
export 'sport_model.dart';
import '../api/api_manager.dart';
import '../database/model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test/database/sqfilite_db.dart';

double cal = 0.0;
double time = 0.0;
String name = "";
String? input_time = "";
// double totalSportTime = 0.0;
// double totalSportCal = 0.0;
///傳給sport_record_widget頁面使用
double recordtotaltime = 1.1;
double recordtotalcal = 1.1;

class SportWidget extends StatefulWidget {
  const SportWidget({
    Key? key,
    this.date,
  }) : super(key: key);

  final DateTime? date;

  @override
  _SportWidgetState createState() => _SportWidgetState();
}

class _SportWidgetState extends State<SportWidget> {
  late SportModel _model;
  ///修改過
  late SportRecord sport;
  ///
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double totalSportTime = 0.0;
  double totalSportCal = 0.0;
  double remainingCal = 0.0;
  DateTimeRange? _selectedDateRange;

  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  ///修改過
  void getSportinfo() async {
    List<SportRecord> sports = await getSport(Userinfo.email, Userinfo.password);
    for (var sport in sports) {
      var s = SportRecord(time: sport.time, calories: sport.calories, name: sport.name, input_time: sport.input_time);
      ///從API拿資料插進本地資料庫
      // await DatabaseHelper.insertSportrec(s);

    }
  }



  ///
  void initState() {
    super.initState();
    _model = createModel(context, () => SportModel());
    ///修改過
    getSportinfo();
    initTotalSportTime().then((_) {
    });
    initTotalSportCal().then((_) {
      updateRemainingCal();
    });
    ///
    doSportDay();
  }

  Future<void> doSportDay() async {
    var doSportDay = await DatabaseHelper.getSportRecordItems();
    List<DateTimeRange> selectedDateRanges = []; // Create a list to store selected date ranges
    for (var i in doSportDay) {
      DateTime start = DateTime.parse(i['input_time']);
      DateTimeRange dateRange = DateTimeRange(start: start, end: start);
      selectedDateRanges.add(dateRange);
    }
    setState(() {
      _selectedDateRange = selectedDateRanges.isNotEmpty ? selectedDateRanges[0] : null;
    });
  }


  ///從本地端資料庫抓出 今日 的所有運動時間相加
  Future<void> initTotalSportTime() async {
    DateTime now = DateTime.now();  // 獲取當前日期和時間
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);  // 將日期格式化為 'yyyy-MM-dd' 的格式
    totalSportTime = await DatabaseHelper.getTotalSportTime(formattedDate);
    recordtotaltime=totalSportTime;
    setState((){}); // This is necessary to update the UI with the new value
  }
  ///從本地端資料庫抓出 今日 的所有運動卡路里相加
  Future<void> initTotalSportCal() async{
    DateTime now = DateTime.now();  // 獲取當前日期和時間
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);  // 將日期格式化為 'yyyy-MM-dd' 的格式
    totalSportCal = await DatabaseHelper.getTotalSportCal(formattedDate);

    recordtotalcal=totalSportCal;
    setState((){}); // This is necessary to update the UI with the new value
  }
  ///更新今日剩餘卡路里
  void updateRemainingCal() {
    setState(() {
      remainingCal = 2000 - totalSportCal;
    });
  }




  ///
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
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: Icon(
                Icons.sports_handball,
                color: Color(0xFFE5E0EB),
                size: 30,
              ),
              onPressed: () async {
                context.safePop();
              },
            ),
            title: Text(
              '運動',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Poppins',
                color: Color(0xFFE5E0EB),
                fontSize: 24,
              ),
            ),
            actions: [],
            centerTitle: false,
            toolbarHeight: 70,
            elevation: 2,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(
                        'This is your daily summary.',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF57636C),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 0,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x34090F13),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(12, 8, 12, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                  child:Text(
                                    '今日運動時間',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF0F1113),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                              ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 4, 0, 0),
                                    child: Text(
                                      'Goals',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF57636C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 16, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          ///修改過
                                          '$totalSportTime',
                                          ///
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF0F1113),
                                            fontSize: 40,
                                            fontWeight: FontWeight.w500,
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
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x34090F13),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(10, 8, 10, 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '已消耗卡路里',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF0F1113),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 4, 0, 0),
                                    child: Text(
                                      '大卡',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF57636C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 16, 0, 16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$totalSportCal',
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF0F1113),
                                            fontSize: 50,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '今日剩餘',
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF57636C),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    '$remainingCal',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF0F1113),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Generated code for this Calendar Widget...
              // Generated code for this Calendar Widget...
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child:
                TableCalendar(
                  firstDay: DateTime.utc(2010,10,20),
                  lastDay: DateTime.utc(2040,10,20),
                  focusedDay: DateTime.now(),
                  headerVisible: true,
                  daysOfWeekVisible: true,
                  shouldFillViewport: false,
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  selectedDayPredicate: (day) {
                    if (_selectedDateRange != null) {
                      DateTime start = _selectedDateRange!.start;
                      DateTime end = _selectedDateRange!.end;

                      // Check if the selected day falls within the selected date range
                      return day.isAfter(start.subtract(Duration(days: 1))) &&
                          day.isBefore(end.add(Duration(days: 1)));
                    }
                    return false;
                  },
                  headerStyle: HeaderStyle(
                      titleTextStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w700),
                      formatButtonTextStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w700)),
                  calendarStyle: CalendarStyle(
                      todayTextStyle: TextStyle(
                          fontSize:20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold ),
                      selectedTextStyle: TextStyle(
                          fontSize:20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold ),
                      outsideTextStyle: TextStyle(
                          fontSize:16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold ),
                      defaultTextStyle: TextStyle(
                          fontSize:16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold ),
                    weekNumberTextStyle: TextStyle(
                          fontSize:16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold ),),
                ),
              ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(16, 2, 16, 12),
              //   child: Container(
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       color: Color(0xFFB181F4),
              //       boxShadow: [
              //         BoxShadow(
              //           blurRadius: 8,
              //           color: Color(0x34090F13),
              //           offset: Offset(0, 4),
              //         )
              //       ],
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //     child: Padding(
              //       padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 12),
              //       child: Column(
              //         mainAxisSize: MainAxisSize.max,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           // Padding(
              //           //   padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
              //           //   child: Text(
              //           //     'Timer',
              //           //     style: FlutterFlowTheme.of(context)
              //           //         .headlineMedium
              //           //         .override(
              //           //       fontFamily: 'Outfit',
              //           //       color: Colors.white,
              //           //       fontSize: 24,
              //           //       fontWeight: FontWeight.w500,
              //           //     ),
              //           //   ),
              //           // ),
              //           // Padding(
              //           //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
              //           //   child: Row(
              //           //     mainAxisSize: MainAxisSize.max,
              //           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           //     crossAxisAlignment: CrossAxisAlignment.end,
              //           //     children: [
              //           //       Padding(
              //           //         padding:
              //           //         EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
              //           //         child: Text(
              //           //           'Go Training Now',
              //           //           style: FlutterFlowTheme.of(context)
              //           //               .titleMedium
              //           //               .override(
              //           //             fontFamily: 'Outfit',
              //           //             color: Colors.white,
              //           //             fontSize: 18,
              //           //             fontWeight: FontWeight.w500,
              //           //           ),
              //           //         ),
              //           //       ),
              //           //       Align(
              //           //         alignment: AlignmentDirectional(-0.15, 0.2),
              //           //         child: FlutterFlowIconButton(
              //           //           borderColor: Colors.transparent,
              //           //           borderRadius: 30,
              //           //           borderWidth: 1,
              //           //           buttonSize: 40,
              //           //           icon: FaIcon(
              //           //             FontAwesomeIcons.angleRight,
              //           //             color: FlutterFlowTheme.of(context)
              //           //                 .primaryBtnText,
              //           //             size: 25,
              //           //           ),
              //           //           onPressed: () async {
              //           //             context.pushNamed('timer');
              //           //           },
              //           //         ),
              //           //       ),
              //           //     ],
              //           //   ),
              //           // ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 2, 16, 12),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFAE99E3),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Color(0x34090F13),
                        offset: Offset(0, 4),
                      )
                    ],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Text(
                            'Record',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                              fontFamily: 'Outfit',
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                child: Text(
                                  'Go Record Your Training Now',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-0.15, 0.2),
                                child: FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  borderWidth: 1,
                                  buttonSize: 40,
                                  icon: FaIcon(
                                    FontAwesomeIcons.angleRight,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBtnText,
                                    size: 25,
                                  ),
                                  onPressed: () async {
                                    context.pushNamed('sport_record');
                                  },
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
