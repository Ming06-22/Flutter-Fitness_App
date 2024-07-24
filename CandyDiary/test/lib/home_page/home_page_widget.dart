import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math';
import 'home_page_model.dart';
export 'home_page_model.dart';
import 'package:test/database/sqfilite_db.dart';
import 'package:test/database/model.dart';
import 'package:test/api/api_manager.dart';
import 'package:marquee/marquee.dart';
class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  int get mealWaterCurrentIndex => _model.mealWaterController != null &&
      _model.mealWaterController!.hasClients &&
      _model.mealWaterController!.page != null
      ? _model.mealWaterController!.page!.round()
      : 0;
  double water = 0.0;
  String name = "";
  int level = 0;
  int money = 0;
  double calories = 0.0;
  double meal1 = 0.0;
  double meal2 = 0.0;
  double meal3 = 0.0;
  double meal4 = 0.0;
  int carbon = 0;
  int fat = 0;
  int protein = 0;
  double targetWater = 0.0;
  double waterPercent = 0.0;
  double targetCal = 0.0;
  double calPercent = 0.0;
  double calPercentInteger = 0.0;
  String canPath = "assets/images/can3.png";
  String candyPath = "assets/images/candy_pink.png";
  List<Widget> images = [];
  int numOfImages = 0;
  int exp = 0;
  double expPercent = 0.0;
  var water_image = 'assets/images/water/water_0.png';
  var _image = "assets/images/user_default_photo.png";


  @override
  void initState() {
    super.initState();
    refreshData();
    refreshFood();


    Future.delayed(const Duration(milliseconds:2000), () {
    });
    _model = createModel(context, () => HomePageModel());

    setupAnimations(
      animationsMap.values.where((anim) =>
      anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  Future<void> refreshData() async {
    final data = await DatabaseHelper.getItem();

    setState(() {
      name = data[0]['name'];
      level = data[0]['level'];
      money = data[0]['money'];
      targetWater = data[0]['target_water'];
      targetCal = data[0]['target_calorie'];
      _image = data[0]['photo'];
      exp = data[0]['exp'];

    });
    expPercent = exp/100;
  }

  
  Future<void> refreshFood() async {
    DateTime now = new DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dateSlug = formatter.format(now);
    final w = await DatabaseHelper.getWater(dateSlug);
    final map = await DatabaseHelper.getCalories();
    final p = await DatabaseHelper.getCanPath();
    final p2 = await DatabaseHelper.getCandyPath();

    setState(() {
      water = w;
      calories = map['calorie'];
      meal1 = map['1'];
      meal2 = map['2'];
      meal3 = map['3'];
      meal4 = map['4'];
      carbon = (map['carbon'] * 4).toInt();
      fat = (map['fat'] * 9).toInt();
      protein = (map['protein'] * 4).toInt();
      canPath = p;
      candyPath = p2;
    });



    addRandomImages(carbon, fat, protein);

    if(water/targetWater < 0.1)
    {
      water_image = ('assets/images/water/water_0.png');
    }
    else if(water/targetWater >= 0.1 && water/targetWater < 0.2)
    {
      water_image = ('assets/images/water/water_10.png');
    }
    else if(water/targetWater >= 0.2 && water/targetWater < 0.3)
    {
      water_image = ('assets/images/water/water_20.png');
    }
    else if(water/targetWater >= 0.3 && water/targetWater < 0.4)
    {
      water_image = ('assets/images/water/water_30.png');
    }
    else if(water/targetWater >= 0.4 && water/targetWater < 0.5)
    {
      water_image = ('assets/images/water/water_40.png');
    }
    else if(water/targetWater >= 0.5 && water/targetWater < 0.6)
    {
      water_image = ('assets/images/water/water_50.png');
    }
    else if(water/targetWater >= 0.6 && water/targetWater < 0.7)
    {
      water_image = ('assets/images/water/water_60.png');
    }
    else if(water/targetWater >= 0.7 && water/targetWater < 0.8)
    {
      water_image = ('assets/images/water/water_70.png');
    }
    else if(water/targetWater >= 0.8 && water/targetWater < 0.9)
    {
      water_image = ('assets/images/water/water_80.png');
    }
    else if(water/targetWater >= 0.9 && water/targetWater < 1)
    {
      water_image = ('assets/images/water/water_90.png');
    }
    else
    {
      water_image = ('assets/images/water/water_100.png');
    }

    waterPercent = water/targetWater;
    if(waterPercent>1) {
      waterPercent = 1;
    }

    calPercent = calories/targetCal;
    if(calPercent > 1)
    {
      calPercent = 1;
    }

    calPercentInteger = calPercent*100;
    calPercentInteger = double.parse(calPercentInteger.toStringAsFixed(1));
  }
  Future<void> addRandomImages(carbon, fat , protein) async{
    if (carbon >= 50) {
      int n = carbon ~/ 100;
      int k = carbon % 100;
      if (k >= 50)
        n += 1;
      String candyPath1 = candyPath.replaceFirst('default.png', 'carbon.png');

      for (int i = 0; i < n; i++) {
        double x = Random().nextInt(125) + 55;
        double y = Random().nextInt(100) + 150;

        Widget imageWidget = Positioned(
          left: x,
          top: y,
          child: Image.asset(
            candyPath1, // Replace with the actual image path
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
        );
        images.add(imageWidget);
      }
    }
    if (protein >= 50) {
      int n = protein ~/ 100;
      int k = protein % 100;
      if (k >= 50)
        n += 1;
      String candyPath2 = candyPath.replaceFirst('default.png', 'protein.png');
      for (int i = 0; i < n; i++) {
        double x = Random().nextInt(125) + 55;
        double y = Random().nextInt(100) + 150;

        Widget imageWidget = Positioned(
          left: x,
          top: y,
          child: Image.asset(
            candyPath2, // Replace with the actual image path
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
        );
        images.add(imageWidget);
      }
    }
    if (fat >= 50) {
      int n = fat ~/ 100;
      int k = fat % 100;
      if (k >= 50)
        n += 1;
      String candyPath3 = candyPath.replaceFirst('default.png', 'fat.png');

      for (int i = 0; i < n; i++) {
        double x = Random().nextInt(125) + 55;
        double y = Random().nextInt(100) + 150;

        Widget imageWidget = Positioned(
          left: x,
          top: y,
          child: Image.asset(
            candyPath3, // Replace with the actual image path
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
        );
        images.add(imageWidget);
      }
    }

  }

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 50.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(40.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'progressBarOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(-50.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.7, 0.7),
          end: Offset(1.0, 1.0),
        ),
      ],
    ),
  };
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFE5E0EB),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: Color(0xFF3C2E92),
            automaticallyImplyLeading: false,
            title: FFButtonWidget(
              onPressed: () async {
                context.goNamed('HomePage');
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
            actions: [
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.analytics,
                  color: Color(0xFFD4D4DC),
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pushNamed('select_analyze');
                },
              ),
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.local_dining,
                  color: Color(0xFFD4D4DC),
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pushNamed('food');
                },
              ),
            ],
            centerTitle: false,
            toolbarHeight: 70.0,
            elevation: 2.0,
          ),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: Container(
                                  width: 90.0,
                                  height: 90.0,
                                  decoration: BoxDecoration(),
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width * 0.2,
                                    height:
                                    MediaQuery.of(context).size.width * 0.2,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      _image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height:
                                  MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 10.0, 100.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '$name',
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium.override(fontFamily: 'Poppins',
                                              color:
                                              Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'LV.$level',
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium.override(fontFamily: 'Poppins',
                                                color:
                                                Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20.0, 10.0, 0.0, 0.0),
                                          child: LinearPercentIndicator(
                                            percent: expPercent,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.6,
                                            lineHeight: 24.0,
                                            animation: true,
                                            progressColor: Color(0xFF3C2E92),
                                            backgroundColor: Color(0xFFF1F4F8),
                                            center: Text(
                                              '$exp/100',
                                              style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                Color(0xFFA492BE),
                                              ),
                                            ),
                                            barRadius: Radius.circular(10.0),
                                            padding: EdgeInsets.zero,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20.0, 5.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                Icons.attach_money,
                                                color: Colors.black,
                                                size: 24.0,
                                              ),
                                              Text(
                                                '$money',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium.override(fontFamily: 'Poppins',
                                                  color: Colors.black ,
                                                ),
                                              ),
                                              Text(
                                                '      ',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium,
                                              ),
                                            ],
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
                      FutureBuilder<String>(
                        future: chatgpt(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator(color: Color(0xFF3C2E92));
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final gpt = snapshot.data;
                            return ListView(
                              shrinkWrap: true,
                              children: [
                                _buildComplexMarquee(gpt),
                              ].map(_wrapWithStuff).toList(),
                            );
                          }
                        },
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Container(
                          height: 600.0,
                          decoration: BoxDecoration(),
                          child: Container(
                            width: double.infinity,
                            height: 500.0,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 50.0),
                                  child: PageView(
                                    controller: _model.mealWaterController ??=
                                        PageController(initialPage: 0),
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                30.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  Icons.fastfood_sharp,
                                                  color: Colors.black,
                                                  size: 30.0,
                                                ),
                                                Text(
                                                  '卡路里攝取量：',
                                                  textAlign: TextAlign.start,
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color:
                                                    Color(0xFF0D0814),
                                                    fontSize: 25.0,
                                                  ),
                                                ),
                                                Text(
                                                  '$calories kal',
                                                  textAlign: TextAlign.start,
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color:
                                                    Color(0xFF0D0814),
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                30.0, 0.0, 0.0, 0.0),
                                            child: LinearPercentIndicator(
                                              percent: calPercent,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.85,
                                              lineHeight: 24.0,
                                              animation: true,
                                              progressColor: Color(0xFFA492BE),
                                              backgroundColor:
                                              Color(0xFFF1F4F8),
                                              center: Text(
                                                '$calories/$targetCal',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color:
                                                  Color(0xFF3C2E92),
                                                ),
                                              ),
                                              barRadius: Radius.circular(10.0),
                                              padding: EdgeInsets.zero,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(),
                                              child: Stack(
                                                children: [
                                                  Align(
                                                    alignment: AlignmentDirectional(
                                                        0, 0),
                                                    child: Image.asset(
                                                      canPath,
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  ...images,
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                30.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.drupal,
                                                  color: Colors.black,
                                                  size: 30.0,
                                                ),
                                                Text(
                                                  '水分攝取量：',
                                                  textAlign: TextAlign.start,
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color:
                                                    Color(0xFF0D0814),
                                                    fontSize: 25.0,
                                                  ),
                                                ),
                                                Text(
                                                  '$water ml',
                                                  textAlign: TextAlign.start,
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color:
                                                    Color(0xFF0D0814),
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                30.0, 0.0, 0.0, 0.0),
                                            child: LinearPercentIndicator(
                                              percent: waterPercent,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.85,
                                              lineHeight: 24.0,
                                              animation: true,
                                              progressColor: Color(0xFFA492BE),
                                              backgroundColor:
                                              Color(0xFFF1F4F8),
                                              center: Text(
                                                '$water/$targetWater',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color:
                                                  Color(0xFF3C2E92),
                                                ),
                                              ),
                                              barRadius: Radius.circular(10.0),
                                              padding: EdgeInsets.zero,
                                            ),
                                          ),
                                          Expanded(
                                            child: Image.asset(
                                              water_image,
                                              width: 100.0,
                                              height: 100.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ListView(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        16.0,
                                                        12.0,
                                                        16.0,
                                                        0.0),
                                                    child: InkWell(
                                                      splashColor:
                                                      Colors.transparent,
                                                      focusColor:
                                                      Colors.transparent,
                                                      hoverColor:
                                                      Colors.transparent,
                                                      highlightColor:
                                                      Colors.transparent,
                                                      onTap: () async {
                                                        context.pushNamed('view_food', queryParams: {'meal': '1', 'title': '早餐'});
                                                      },
                                                    child: Container(
                                                      width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 3.0,
                                                            color: Color(
                                                                0x25000000),
                                                            offset: Offset(
                                                                0.0, 2.0),
                                                          )
                                                        ],
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8.0),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                8.0,
                                                                8.0,
                                                                4.0,
                                                                8.0),
                                                            child: Container(
                                                              width: 4.0,
                                                              height: 65.0,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Color(
                                                                    0xFF4B39EF),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    4.0),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                12.0,
                                                                12.0,
                                                                16.0,
                                                                12.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  '早餐',
                                                                  style: FlutterFlowTheme.of(
                                                                      context)
                                                                      .headlineMedium
                                                                      .override(
                                                                    fontFamily:
                                                                    'Outfit',
                                                                    color: Color(
                                                                        0xFF101213),
                                                                    fontSize:
                                                                    22.0,
                                                                    fontWeight:
                                                                    FontWeight.w500,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      0.0,
                                                                      0.0),
                                                                  child: Text(
                                                                    '共$meal1大卡',
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily:
                                                                      'Outfit',
                                                                      color:
                                                                      Color(0xFF4B39EF),
                                                                      fontSize:
                                                                      14.0,
                                                                      fontWeight:
                                                                      FontWeight.w500,
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
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        16.0,
                                                        12.0,
                                                        16.0,
                                                        0.0),
                                                    child: Container(
                                                      width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 3.0,
                                                            color: Color(
                                                                0x25000000),
                                                            offset: Offset(
                                                                0.0, 2.0),
                                                          )
                                                        ],
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8.0),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                8.0,
                                                                8.0,
                                                                4.0,
                                                                8.0),
                                                            child: Container(
                                                              width: 4.0,
                                                              height: 65.0,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Color(
                                                                    0xFF39D2C0),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    4.0),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                12.0,
                                                                12.0,
                                                                16.0,
                                                                12.0),
                                                            child: InkWell(
                                                              splashColor:
                                                              Colors.transparent,
                                                              focusColor:
                                                              Colors.transparent,
                                                              hoverColor:
                                                              Colors.transparent,
                                                              highlightColor:
                                                              Colors.transparent,
                                                              onTap: () async {
                                                                context.pushNamed(
                                                                    'view_food', queryParams: {'meal': '2', 'title': '午餐'});
                                                              },
                                                            child: Column(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  '午餐',
                                                                  style: FlutterFlowTheme.of(
                                                                      context)
                                                                      .headlineMedium
                                                                      .override(
                                                                    fontFamily:
                                                                    'Outfit',
                                                                    color: Color(
                                                                        0xFF101213),
                                                                    fontSize:
                                                                    22.0,
                                                                    fontWeight:
                                                                    FontWeight.w500,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      0.0,
                                                                      0.0),
                                                                  child: Text(
                                                                    '共$meal2大卡',
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily:
                                                                      'Outfit',
                                                                      color:
                                                                      Color(0xFF39D2C0),
                                                                      fontSize:
                                                                      14.0,
                                                                      fontWeight:
                                                                      FontWeight.w500,
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
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        16.0,
                                                        12.0,
                                                        16.0,
                                                        0.0),
                                                    child: Container(
                                                      width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 3.0,
                                                            color: Color(
                                                                0x25000000),
                                                            offset: Offset(
                                                                0.0, 2.0),
                                                          )
                                                        ],
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8.0),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                8.0,
                                                                8.0,
                                                                4.0,
                                                                8.0),
                                                            child: Container(
                                                              width: 4.0,
                                                              height: 65.0,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Color(
                                                                    0xFFEE8B60),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    4.0),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                12.0,
                                                                12.0,
                                                                16.0,
                                                                12.0),
                                                            child: InkWell(
                                                              splashColor:
                                                              Colors.transparent,
                                                              focusColor:
                                                              Colors.transparent,
                                                              hoverColor:
                                                              Colors.transparent,
                                                              highlightColor:
                                                              Colors.transparent,
                                                              onTap: () async {
                                                                context.pushNamed(
                                                                    'view_food', queryParams: {'meal': '3', 'title': '晚餐'});
                                                              },
                                                            child: Column(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  '晚餐',
                                                                  style: FlutterFlowTheme.of(
                                                                      context)
                                                                      .headlineMedium
                                                                      .override(
                                                                    fontFamily:
                                                                    'Outfit',
                                                                    color: Color(
                                                                        0xFF101213),
                                                                    fontSize:
                                                                    22.0,
                                                                    fontWeight:
                                                                    FontWeight.w500,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      0.0,
                                                                      0.0),
                                                                  child: Text(
                                                                    '共$meal3大卡',
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily:
                                                                      'Outfit',
                                                                      color:
                                                                      Color(0xFFEE8B60),
                                                                      fontSize:
                                                                      14.0,
                                                                      fontWeight:
                                                                      FontWeight.w500,
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
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        16.0,
                                                        12.0,
                                                        16.0,
                                                        0.0),
                                                    child: Container(
                                                      width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 3.0,
                                                            color: Color(
                                                                0x25000000),
                                                            offset: Offset(
                                                                0.0, 2.0),
                                                          )
                                                        ],
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8.0),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                8.0,
                                                                8.0,
                                                                4.0,
                                                                8.0),
                                                            child: Container(
                                                              width: 4.0,
                                                              height: 65.0,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Color(
                                                                    0xFFCF77C3),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    4.0),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                12.0,
                                                                12.0,
                                                                16.0,
                                                                12.0),
                                                            child: InkWell(
                                                              splashColor:
                                                              Colors.transparent,
                                                              focusColor:
                                                              Colors.transparent,
                                                              hoverColor:
                                                              Colors.transparent,
                                                              highlightColor:
                                                              Colors.transparent,
                                                              onTap: () async {
                                                                context.pushNamed(
                                                                    'view_food', queryParams: {'meal': '4', 'title': '點心'});
                                                              },
                                                            child: Column(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  '點心',
                                                                  style: FlutterFlowTheme.of(
                                                                      context)
                                                                      .headlineMedium
                                                                      .override(
                                                                    fontFamily:
                                                                    'Outfit',
                                                                    color: Color(
                                                                        0xFF101213),
                                                                    fontSize:
                                                                    22.0,
                                                                    fontWeight:
                                                                    FontWeight.w500,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      0.0,
                                                                      0.0),
                                                                  child: Text(
                                                                    '共$meal4大卡',
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily:
                                                                      'Outfit',
                                                                      color:
                                                                      Color(0xFFEE8B60),
                                                                      fontSize:
                                                                      14.0,
                                                                      fontWeight:
                                                                      FontWeight.w500,
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
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        16.0,
                                                        12.0,
                                                        16.0,
                                                        0.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 111.1,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 5.0,
                                                            color: Color(
                                                                0x23000000),
                                                            offset: Offset(
                                                                0.0, 2.0),
                                                          )
                                                        ],
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(12.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            16.0,
                                                            16.0,
                                                            16.0,
                                                            16.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                    '今日攝取卡路里數',
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .headlineSmall
                                                                        .override(
                                                                      fontFamily:
                                                                      'Outfit',
                                                                      color:
                                                                      Color(0xFF101213),
                                                                      fontWeight:
                                                                      FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        0.0,
                                                                        8.0,
                                                                        0.0,
                                                                        0.0),
                                                                    child: Text(
                                                                      '共$calories卡',
                                                                      style: FlutterFlowTheme.of(
                                                                          context)
                                                                          .displaySmall
                                                                          .override(
                                                                        fontFamily:
                                                                        'Outfit',
                                                                        color:
                                                                        Color(0xFF101213),
                                                                        fontSize:
                                                                        28.0,
                                                                        fontWeight:
                                                                        FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ).animateOnPageLoad(
                                                                  animationsMap[
                                                                  'columnOnPageLoadAnimation']!),
                                                            ),
                                                            Column(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                  AlignmentDirectional(
                                                                      -0.05,
                                                                      -1.0),
                                                                  child:
                                                                  CircularPercentIndicator(
                                                                    percent:
                                                                    calPercent,
                                                                    radius:
                                                                    30.0,
                                                                    lineWidth:
                                                                    4.0,
                                                                    animation:
                                                                    true,
                                                                    progressColor:
                                                                    Color(
                                                                        0xFF4B39EF),
                                                                    backgroundColor:
                                                                    Color(
                                                                        0xFFF1F4F8),
                                                                    center:
                                                                    Text(
                                                                      '$calPercentInteger%',
                                                                      style: FlutterFlowTheme.of(
                                                                          context)
                                                                          .headlineMedium
                                                                          .override(
                                                                        fontFamily:
                                                                        'Outfit',
                                                                        color:
                                                                        Color(0xFF101213),
                                                                        fontSize:
                                                                        22.0,
                                                                        fontWeight:
                                                                        FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ).animateOnPageLoad(
                                                                      animationsMap[
                                                                      'progressBarOnPageLoadAnimation']!),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                  AlignmentDirectional(
                                                                      -0.1,
                                                                      0.0),
                                                                  child: Text(
                                                                    '總攝取量佔比',
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily:
                                                                      'Poppins',
                                                                      fontSize:
                                                                      12.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ).animateOnPageLoad(
                                                        animationsMap[
                                                        'containerOnPageLoadAnimation']!),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 10.0),
                                    child: smooth_page_indicator
                                        .SmoothPageIndicator(
                                      controller: _model.mealWaterController ??=
                                          PageController(initialPage: 0),
                                      count: 3,
                                      axisDirection: Axis.horizontal,
                                      onDotClicked: (i) async {
                                        await _model.mealWaterController!
                                            .animateToPage(
                                          i,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                      },
                                      effect: smooth_page_indicator
                                          .ExpandingDotsEffect(
                                        expansionFactor: 2.0,
                                        spacing: 8.0,
                                        radius: 16.0,
                                        dotWidth: 16.0,
                                        dotHeight: 16.0,
                                        dotColor: Color(0xFF9E9E9E),
                                        activeDotColor: Color(0xFF3F51B5),
                                        paintStyle: PaintingStyle.fill,
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
    );
  }
}

Widget _buildMarquee() {
  return Marquee(
    text: 'hello',
  );
}

//Secondary Marquee text
Widget _buildComplexMarquee(gpt) {
  return Marquee(
    text: gpt,
    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),

    scrollAxis: Axis.horizontal,
    crossAxisAlignment: CrossAxisAlignment.start,
    blankSpace: 20.0,
    velocity: 50.0,
    pauseAfterRound: Duration(seconds: 1),
    showFadingOnlyWhenScrolling: true,
    fadingEdgeStartFraction: 0.1,
    fadingEdgeEndFraction: 0.1,
    numberOfRounds: 3,
    startPadding: 10.0,
    accelerationDuration: Duration(seconds: 1),
    accelerationCurve: Curves.linear,
    decelerationDuration: Duration(milliseconds: 650),
    decelerationCurve: Curves.easeOut,
  );
}

// Styling the Marquee
Widget _wrapWithStuff(Widget child) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
    child: Container(height: 35.0,
        color: Color(0xFFE5E0EB),
         child: child),
  );
}


