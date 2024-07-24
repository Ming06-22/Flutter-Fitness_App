import 'package:test/api/api_manager.dart';
import 'package:test/database/sqfilite_db.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'view_food_model.dart';
export 'view_food_model.dart';
import 'package:test/database/model.dart';
import 'package:test/api/api_manager.dart';
import 'package:test/database/sqfilite_db.dart';

class ViewFoodWidget extends StatefulWidget {
  const ViewFoodWidget({
    Key? key,
    required this.meal,
    required this.title
  }) :super(key: key);

  final int meal;
  final String title;
  @override
  _ViewFoodWidgetState createState() => _ViewFoodWidgetState();
}

class _ViewFoodWidgetState extends State<ViewFoodWidget> {
  late ViewFoodModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  List<Map<String, dynamic>> foodItems = [];

  Future<void> refreshData() async {
    final data = await DatabaseHelper.getFoodItems(widget.meal);
    setState(() {
      foodItems = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewFoodModel());
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
        backgroundColor: Color(0xFFF1F4F8),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: Color(0xFF3C2E92),
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Color(0xFF3C2E92),
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              fillColor: Color(0xFF3C2E92),
              icon: Icon(
                Icons.arrow_back_outlined,
                color: Color(0xFFE5E0EB),
                size: 30.0,
              ),
              onPressed: () async {
                context.pushNamed('HomePage');
              },
            ),
            title: Text(
              widget.title,
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: Color(0xFFE5E0EB),
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            actions: [
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 80.0,
                icon: Icon(
                  Icons.add,
                  color: Color(0xFFE5E0EB),
                  size: 45.0,
                ),
                onPressed: () async {

                },
              ),
            ],
            centerTitle: false,
            elevation: 2.0,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3.0,
                        color: Color(0x33000000),
                        offset: Offset(0.0, 1.0),
                      )
                    ],
                  ),
                ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
              child: foodItems.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'No food items available',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                  )
                : ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) => Divider(),
                itemCount: foodItems.length,
                itemBuilder: (context, index) {
                  final foodItem = foodItems[index];
                  return Dismissible(
                    key: Key(foodItem['food']), // Provide a unique key for each item
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Color(0xFFF32143),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (_) async {
                      await deleteFoodRec(Userinfo.email, foodItem);
                      await DatabaseHelper.deleteFoodItem(foodItem);
                    },
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(
                          'nutrient_record',
                          queryParams: foodItem.map((key, value) =>
                              MapEntry(key, value.toString())).withoutNulls,
                        );
                      },
                      child: ListTile(
                        title: Text(
                          foodItem['food'],
                          style: FlutterFlowTheme.of(context).headlineSmall.override(
                            fontFamily: 'Poppins',
                            lineHeight: 1.0,
                            color: Color(0xFF050505),
                          ),
                        ),
                        subtitle: Text(
                          foodItem['calorie'].toString(),
                          style: FlutterFlowTheme.of(context).titleSmall,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF303030),
                          size: 20.0,
                        ),
                        tileColor: Color(0xFFE5E0EB),
                        dense: false,
                      ),
                    ),
                  );
                },
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
