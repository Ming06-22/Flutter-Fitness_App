import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:test/database/sqfilite_db.dart';
import 'classify_food_model.dart';
export 'classify_food_model.dart';

class ClassifyFoodWidget extends StatefulWidget {
  const ClassifyFoodWidget({
    Key? key,
    String? str,
    String? title,
  }) :
        this.str = str ?? "",
        this.title = title ?? "",
  super(key: key);

  final String str;
  final String title;

  @override
  _ClassifyFoodWidgetState createState() => _ClassifyFoodWidgetState();
}

class _ClassifyFoodWidgetState extends State<ClassifyFoodWidget> {
  late ClassifyFoodModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> foods = [];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassifyFoodModel());
    _model.textController ??= TextEditingController();
    refreshData();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }
  Future<void> refreshData() async {
    final data = await DatabaseHelper.getFoods(widget.str);
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
        backgroundColor: Color(0xFFF1F4F8),
        appBar: AppBar(
          backgroundColor: Color(0xFF3C2E92),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFFD4D4DC),
              size: 30,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                      child: Text(
                        widget.title,
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF57636C),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      'See All',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF14181B),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: foods.length,
                        itemBuilder: (context, index) {
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
                                          food['name'], // Replace with your actual item title
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
                                            '${food['calorie'].toString()}大卡', // Replace with your actual item calories
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
                                        context.pushNamed('nutrient', queryParams: food.map((key, value) =>
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
            ],
          ),
        ),
      ),
    );
  }
}
