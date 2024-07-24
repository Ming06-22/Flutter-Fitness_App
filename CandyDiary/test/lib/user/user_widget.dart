import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'user_model.dart';
export 'user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/database/sqfilite_db.dart';
import 'package:test/api/api_manager.dart';
import '../database/model.dart';
import 'package:test/sport/sport_widget.dart';




class UserWidget extends StatefulWidget {
  const UserWidget({Key? key}) : super(key: key);

  @override
  _UserWidgetState createState() => _UserWidgetState();
}


class _UserWidgetState extends State<UserWidget> {
  late UserModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late Userinfo user;
  late SportRecord sport;
  String name = "";
  int level = 0;
  int money = 0;
  String plan = "";
  double target_cal = 0.0;
  double cal = 0.0;
  double time = 0.0;
  double water = 0.0;
  double sport_cal = 0.0;
  String _image = "assets/images/user_default_photo.png";
  final ImagePicker picker = ImagePicker();


  List<Map<String, dynamic>> myData = [];
  Future<void> refreshData() async {
    DateTime now = new DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dateSlug = formatter.format(now);
    final w = await DatabaseHelper.getWater(dateSlug);
    final data = await DatabaseHelper.getItem();
    final map = await DatabaseHelper.getCalories();
    setState(() {
      myData = data;
      if (myData[0]['theory'] == 1)
        plan = '生酮飲食法';
      else if (myData[0]['theory'] == 2)
        plan = '蛋白質減重法';
      else if (myData[0]['theory'] == 3)
        plan = '211餐盤減肥法';
      else if (myData[0]['theory'] == 4)
        plan = '減醣飲食';
      else if (myData[0]['theory'] == 5)
        plan = '地中海飲食法';
      name = myData[0]['name'];
      level = myData[0]['level'];
      money = myData[0]['money'];
      target_cal = myData[0]['target_calorie'];
      _image = myData[0]['photo'];
      water = w;
      cal = map['calorie'];
    });

  }

  void updatePhoto(String path) async {
    user = await updateUserPhoto(Userinfo.email, Userinfo.password, path);
    await DatabaseHelper.updateItem(user.id, user);
    //print("!!!!!!!!!\n");
    //print(path);
    refreshData();
  }


  // void getSportinfo() async {
  //   sport = await getSport(Userinfo.email, Userinfo.password);
  //   setState(() {
  //     cal = sport.calories;
  //     time = sport.time;
  //   });
  // }


  @override
  void initState() {
    super.initState();
    refreshData();
    _model = createModel(context, () => UserModel());
    //getSportinfo();
  }


  Future _openModalBottomSheet() async {
    final option = await showModalBottomSheet(context: context, builder: (BuildContext context) {
      return Container(
        height: 161 + MediaQuery.of(context).padding.bottom,
        color: Color.fromRGBO(245, 245, 245, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: _itemCreat(context, '拍照'),
              onTap: (){
                print('選擇相機');
                Navigator.pop(context);
                getImage(ImageSource.camera);

              },
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(top: 1),
                child: _itemCreat(context, '相簿'),
              ),
              onTap: (){
                print('選擇相簿');
                Navigator.pop(context);
                getImage(ImageSource.gallery);
              },
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: _itemCreat(context, '取消'),
              ),
              onTap: (){
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    });
  }


  Widget _itemCreat(BuildContext context, String title) {
    return Container(
      color: Colors.white,
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      // 拍照获取图片
      //source: ImageSource.camera,
      // 手机选择图库
        source: source,
        // 图片的最大宽度
        maxWidth: 400
    );
    // 更新状态
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile.path.toString();
        updatePhoto(_image);
        print(_image);
      } else {
        print('没有选择任何图片');
      }
    });
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: 220.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF3C2E92),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 30.0, 20.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 70.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    name,
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Colors.white,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'LV.$level | \$$money',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 20.0, 10.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 10.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: ()  {
                                _openModalBottomSheet();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.width * 0.25,
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
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async => context.pushNamed('setting'),
                                    text: '修改個人資料',
                                    options: FFButtonOptions(
                                      width: 130.0,
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF3C2E92),
                                          ),
                                      elevation: 2.0,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 190.0, 0.0, 0.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x5B000000),
                          offset: Offset(0.0, -2.0),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 10),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFF1F4F8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '目前減肥計劃',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF0D0814),
                                            fontSize: 24,
                                          ),
                                        ),
                                        Icon(
                                          Icons.content_paste_outlined,
                                          color: Color(0xFF0D0814),
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE3D6EB),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                        child: Text(
                                          plan,
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF0D0814),
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE3D6EB),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                                                child: Text(
                                                  '每日可攝取總量：',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    color: Color(0xFF0D0814),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                                                child: Text(
                                                  '$target_cal cal',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xFFCB5165),
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        context.pushNamed('diet_plan');
                                      },
                                      text: '修改減肥法',
                                      icon: Icon(
                                        Icons.assignment_outlined,
                                        size: 24,
                                      ),
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 40,
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                        color: Color(0xFFE3D6EB),
                                        textStyle:
                                        FlutterFlowTheme.of(context).titleSmall.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF0D0814),
                                          fontSize: 18,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16, 15, 16, 15),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFF1F4F8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.fastfood_sharp,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          Text(
                                            '今日飲食攝取量',
                                            textAlign: TextAlign.center,
                                            style:
                                            FlutterFlowTheme.of(context).bodySmall.override(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF0D0814),
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            '攝取卡路里數：$cal kal',
                                            style:
                                            FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF0D0814),
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            '飲水量：$water ml',
                                            style:
                                            FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF0D0814),
                                              fontSize: 20,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                            child: Text(
                                              '每日總攝取限制：$target_cal cal',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Poppins',
                                                fontSize: 20,
                                                color: Color(0xFF0D0F10),
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
                            padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 15),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFF1F4F8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.fitness_center,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          Text(
                                            '今日運動消耗',
                                            textAlign: TextAlign.center,
                                            style:
                                            FlutterFlowTheme.of(context).bodySmall.override(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF0D0814),
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            '消耗卡路里數：$recordtotalcal cal',
                                            style:
                                            FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF0D0814),
                                              fontSize: 20,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                            child: Text(
                                              '運動總時數：$recordtotaltime hr',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Poppins',
                                                fontSize: 20,
                                                color: Color(0xFF0D0F10),
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
                            EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              'Created by Candy Diary',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                  fontFamily: 'Open Sans Condensed',
                                  fontSize: 18,
                                color: Color(0xFF0D0F10),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                            child: FFButtonWidget(
                              onPressed: () async {
                                var confirmDialogResponse = await showDialog<bool>(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('登出'),
                                      content: Text('確定要登出嗎？'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, false),
                                          child: Text('取消'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, true),
                                          child: Text('確定'),
                                        ),
                                      ],
                                    );
                                  },
                                ) ??
                                    false;
                                if (!confirmDialogResponse) {
                                  return;
                                }
                                context.goNamed('sign_in');
                              },
                              text: '登出',
                              options: FFButtonOptions(
                                height: 40,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 0, 24, 0),
                                iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: Color(0xFFAE99E3),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                                elevation: 3,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
