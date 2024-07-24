import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test/database/sqfilite_db.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test/api/api_manager.dart';
import '../database/model.dart';
import 'food_recommand_model.dart';
export 'food_recommand_model.dart';

class FoodRecommandWidget extends StatefulWidget {
  const FoodRecommandWidget({Key? key}) : super(key: key);

  @override
  _FoodRecommandWidgetState createState() => _FoodRecommandWidgetState();
}

class _FoodRecommandWidgetState extends State<FoodRecommandWidget> {
  late FoodRecommandModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Food> foods = [];
  late String name;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FoodRecommandModel());
    refreshData();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> refreshData() async {
    final data = await getRecommendFood(Userinfo.email);
    setState(() {
      foods = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFFAF7F7),
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
                Icons.recommend_outlined,
                color: Color(0xFFE5E0EB),
                size: 30,
              ),
              onPressed: () async {
                context.safePop();
              },
            ),
            title: Text(
                '推薦食品',
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
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (foods.isEmpty)
                  Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(
                          0, 250, 0, 0),
                      child:SpinKitCircle(
                        color: Colors.blue,
                        size: 50.0,
                      ),
                  ),

                // Show image when weightChart is not empty
                if (foods.isNotEmpty)
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      var recommendFood = foods[index];
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
                                        recommendFood.name, // Replace with your actual item title
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
                                          '${recommendFood.calories.toString()}大卡', // Replace with your actual item calories
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
                                      context.pushNamed('nutrient', queryParams: recommendFood.toMap().map((key, value) =>
                                          MapEntry(key, value.toString())).withoutNulls);
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
