import '/flutter_flow/flutter_flow_icon_button.dart';
import 'package:test/api/api_manager.dart';
import 'package:test/database/sqfilite_db.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'shopping_model.dart';
export 'shopping_model.dart';
import 'package:test/database/model.dart';

class ShoppingWidget extends StatefulWidget {
  const ShoppingWidget({Key? key}) : super(key: key);

  @override
  _ShoppingWidgetState createState() => _ShoppingWidgetState();
}

class _ShoppingWidgetState extends State<ShoppingWidget>
    with TickerProviderStateMixin {
  late ShoppingModel _model;
  var yourVariable1 = '';

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> u = [];
  List<Map<String, dynamic>> products = [];
  Future<void> refreshData() async {
    final data = await DatabaseHelper.getProduct();
    final user = await DatabaseHelper.getItem();
    setState(() {
      print(data);
      products = data;
      u = user;
    });
  }
  Future<void> addProduct(int uid, int pid, int balance, String type) async {
    await addProductApi(uid, pid, type);
    ProductRecord p = ProductRecord(pid: pid);
    await DatabaseHelper.insertProductrec(p);
    await DatabaseHelper.updateMoney(uid, balance);
    await updateMoney(Userinfo.email, Userinfo.password, balance);
    await Future.delayed(Duration(milliseconds: 500));

    refreshData();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShoppingModel());
    refreshData();
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
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: Icon(
                Icons.shopping_cart,
                color: Color(0xFFE5E0EB),
                size: 30,
              ),
              onPressed: () async {
                context.safePop();
              },
            ),
            title: Text(
              '購物',
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
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' Products',
                        style:
                        FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF14181B),
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed('product');
                          },
                          text: '已擁有之商品',
                          options: FFButtonOptions(
                            height: 40,
                            padding:
                            EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                            iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: Color(0xFF7767FE),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                              fontFamily: 'Poppins',
                              color: Colors.white
                            ),
                            elevation: 3,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1
                            ),
                            borderRadius: BorderRadius.circular(15)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 44),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return  Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16,
                              12),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              int userMoney = u[0]['money'];
                              int productPrice = product['point'];
                              if (userMoney < productPrice) {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('購買失敗'),
                                      content: Text('您的金額不足以購買此商品。'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                return; // Exit the onTap function
                              }
                              var confirmDialogResponse = await showDialog<
                                  bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('是否購買？'),
                                    content: Text('確定花費${product['point']} Pt購買此商品嗎？'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(
                                                alertDialogContext, false),
                                        child: Text('取消'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(
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

                              setState(() {
                                int balance = userMoney - productPrice;
                                addProduct(u[0]['id'], product['id'], balance, product['type']);
                                // 更新状态，例如更改变量的值
                                yourVariable1 = '已購買';

                              });
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('購買成功'),
                                    content: Text('已成功購買此商品！'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    color: Color(0x1F000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4, 4, 4, 4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        product['path'],
                                        width: 120,
                                        height: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(
                                              8, 12, 16, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                product['name'],
                                                style: FlutterFlowTheme
                                                    .of(
                                                    context)
                                                    .headlineSmall
                                                    .override(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF14181B),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(
                                              8, 0, 16, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Produced by Celine',
                                                style:
                                                FlutterFlowTheme
                                                    .of(context)
                                                    .bodySmall
                                                    .override(
                                                  fontFamily: 'Outfit',
                                                  color:
                                                  Color(0xFF57636C),
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(
                                              8, 0, 16, 12),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${product['point']} pt',
                                                style:
                                                FlutterFlowTheme
                                                    .of(context)
                                                    .titleMedium
                                                    .override(
                                                  fontFamily: 'Outfit',
                                                  color:
                                                  Color(0xFF4B39EF),
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ],
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
