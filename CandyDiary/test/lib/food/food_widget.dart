import 'package:test/home_page/home_page_model.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import '/components/water_options_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'food_model.dart';
export 'food_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/database/sqfilite_db.dart';

class FoodWidget extends StatefulWidget {
  const FoodWidget({Key? key}) : super(key: key);

  @override
  _FoodWidgetState createState() => _FoodWidgetState();

}

class _FoodWidgetState extends State<FoodWidget> {
  late FoodModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }
  double tgWater = 0.0;
  String name = "";
  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> queryFoods = [];
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FoodModel());
    _model.textController ??= TextEditingController();
    refreshData();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }
  
  Future<void> refreshData() async {
    final data = await DatabaseHelper.getItem();
    final f = await DatabaseHelper.getFoodDB();
    setState(() {
      tgWater = data[0]['target_water'];
      name = data[0]['name'];
      productList = f;
    });

  }
  void search(String keyword) async{
    final suggestions = productList.where((food) {
      final foodTitle = food['name'];
      final input = keyword;
      return foodTitle.contains(input);
    }).toList();
    setState(() => queryFoods = suggestions);
    for (int i = 0; i < 5; i++) {
      print(queryFoods[i]);
    }
  }
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('請選取想使用的圖片'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFF3C2E92)),          //背景颜色
                    ),
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('相簿'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF3C2E92)),          //背景颜色
                    ),
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('相機'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
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
                Icons.arrow_back,
                color: Color(0xFFD4D4DC),
                size: 30,
              ),
              onPressed: () async {
                context.pushNamed('HomePage');
              },
            ),
            actions: [
              FlutterFlowIconButton(
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 40,
                icon: Icon(
                  Icons.search_outlined,
                  color: Color(0xFFD4D4DC),
                  size: 30,
                ),
                onPressed: () async {
                  context.pushNamed(
                    'search_page',
                    extra: <String, dynamic>{
                      kTransitionInfoKey: TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                        alignment: Alignment.bottomCenter,
                      ),
                    },
                  );
                },
              ),
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.add,
                  color: Color(0xFFD4D4DC),
                  size: 30,
                ),
                onPressed: () async {
                  // takeshot
                  context.pushNamed('food_costumize');
                },
              ),
            ],
            centerTitle: false,
            toolbarHeight: 70,
            elevation: 0,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   width: double.infinity,
              //   height: 70.0,
              //   decoration: BoxDecoration(
              //     color: Color(0xFF3C2E92),
              //     boxShadow: [
              //       BoxShadow(
              //         blurRadius: 5.0,
              //         color: Color(0x27000000),
              //         offset: Offset(0.0, 3.0),
              //       )
              //     ],
              //   ),
              //     child: Column(
              //       children:<Widget>[
              //         Padding(
              //           padding:
              //               EdgeInsetsDirectional.fromSTEB(16.0, 5.0, 16.0, 0.0),
              //         ),
              //         // Expanded(
              //         //   child: ListView.builder(
              //         //     shrinkWrap: true,
              //         //     itemCount: queryFoods.length,
              //         //     itemBuilder: (context, index) {
              //         //       final food = queryFoods[index];
              //         //       return ListTile(
              //         //         title: Text(food['name']),
              //         //         onTap: () async {
              //         //           context.pushNamed('nutrient_record', queryParams: food.map((key, value) =>
              //         //               MapEntry(key, value.toString())).withoutNulls);
              //         //         },
              //         //       );
              //         //     },
              //         //   ),
              //         // ),
              //       ],
              //     ),
              // ),
              // Generated code for this Row Widget...
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 5, 0),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x230E151B),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30,
                                borderWidth: 1,
                                buttonSize: 60,
                                icon: Icon(
                                  Icons.history_outlined,
                                  color: Colors.black,
                                  size: 40,
                                ),
                                onPressed: () async {
                                  context.pushNamed('food_weekend');
                                },
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  'History record',
                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF57636C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 8, 12, 8),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x230E151B),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30,
                                borderWidth: 1,
                                buttonSize: 60,
                                icon: Icon(
                                  Icons.water_drop_outlined,
                                  color: Colors.black,
                                  size: 40,
                                ),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => FocusScope.of(context)
                                            .requestFocus(_model.unfocusNode),
                                        child: Padding(
                                          padding: MediaQuery.of(context).viewInsets,
                                          child: WaterOptionsWidget(),
                                        ),
                                      );
                                    },
                                  ).then((value) => setState(() {}));
                                },
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  'Water',
                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF57636C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 4.0),
                      child: Text(
                        'Categories',
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Outfit',
                              color: Color(0xFF57636C),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    Text(
                      'See All',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF14181B),
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 44.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 190.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x230E151B),
                            offset: Offset(0.0, 2.0),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 4.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('classify_food', queryParams: {'str': "排", 'title': "Steak"});
                          },
                          child:Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Zm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
                                  width: double.infinity,
                                  height: 115.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 12.0, 0.0, 0.0),
                              child: Text(
                                'Steak',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF14181B),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 4.0, 0.0, 0.0),
                              child: Text(
                                'Category Name',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF57636C),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 190.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x230E151B),
                            offset: Offset(0.0, 2.0),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 4.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('classify_food', queryParams: {'str': "沙拉", 'title': 'Salad'});
                          },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Zm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
                                width: double.infinity,
                                height: 115.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 12.0, 0.0, 0.0),
                              child: Text(
                                'Salad',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF14181B),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 4.0, 0.0, 0.0),
                              child: Text(
                                'Category Name',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF57636C),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 190.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x230E151B),
                            offset: Offset(0.0, 2.0),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 4.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('classify_food', queryParams: {'str': "蛋糕", 'title': 'Cake'});
                          },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1565958011703-44f9829ba187?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Zm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
                                width: double.infinity,
                                height: 115.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 12.0, 0.0, 0.0),
                              child: Text(
                                'Cake',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF14181B),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 4.0, 0.0, 0.0),
                              child: Text(
                                'Category Name',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF57636C),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 190.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x230E151B),
                            offset: Offset(0.0, 2.0),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 4.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('classify_food', queryParams: {'str': "佐", 'title': "Western Cuisine"});
                          },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1476224203421-9ac39bcb3327?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTl8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                                width: double.infinity,
                                height: 115.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 12.0, 0.0, 0.0),
                              child: Text(
                                'Western Cuisine',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF14181B),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 4.0, 0.0, 0.0),
                              child: Text(
                                'Category Name',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF57636C),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 190.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x230E151B),
                            offset: Offset(0.0, 2.0),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 4.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('classify_food', queryParams: {'str': "義大利麵", 'title': 'Spaghetti'});
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1484980972926-edee96e0960d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjN8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                                width: double.infinity,
                                height: 115.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 12.0, 0.0, 0.0),
                              child: Text(
                                'Spaghetti',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF14181B),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 4.0, 0.0, 0.0),
                              child: Text(
                                'Category Name',
                                style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF57636C),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 190.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x230E151B),
                            offset: Offset(0.0, 2.0),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 4.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('classify_food', queryParams: {'str': "飯", 'title': 'Others'});
                          },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                                width: double.infinity,
                                height: 115.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 12.0, 0.0, 0.0),
                              child: Text(
                                'Others',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF14181B),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 4.0, 0.0, 0.0),
                              child: Text(
                                'Category Name',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF57636C),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
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
    );
  }
}
