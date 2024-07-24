import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'product_model.dart';
export 'product_model.dart';
import 'package:test/database/sqfilite_db.dart';
import 'package:test/database/model.dart';
import 'package:test/api/api_manager.dart';
class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget>
    with TickerProviderStateMixin {
  late ProductModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> products = [];
  Future<void> refreshData() async {
    final data = await DatabaseHelper.getProductRec();
    setState(() {
      products = data;
    });
  }
  Future<void> updateCanStatus(pid, type) async {
    await DatabaseHelper.updateCan(pid, type);
    await updateProductStatus(Userinfo.email, Userinfo.password, pid);
  }
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductModel());
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
              borderRadius: 20,
              borderWidth: 1,
              buttonSize: 40,
              icon: Icon(
                Icons.arrow_back_outlined,
                color: FlutterFlowTheme.of(context).primaryBtnText,
                size: 30,
              ),
              onPressed: () async {
                context.pushNamed('shopping');
              },
            ),
            title: FFButtonWidget(
              onPressed: () async {
                context.pushNamed('HomePage');
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
            actions: [
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.analytics,
                  color: Color(0xFFD4D4DC),
                  size: 30,
                ),
                onPressed: () async {
                  context.pushNamed('select_analyze');
                },
              ),
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.local_dining,
                  color: Color(0xFFD4D4DC),
                  size: 30,
                ),
                onPressed: () async {
                  context.pushNamed('record');
                },
              ),
            ],
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                        child: Text(
                          '已擁有之商品：',
                          style:
                          FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF14181B),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
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
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
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
                                padding:
                                EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    product['path'],
                                    width: 120,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 12, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            product['name'],
                                            style: FlutterFlowTheme
                                                .of(context)
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Produced by Celine',
                                            style: FlutterFlowTheme
                                                .of(context)
                                                .bodySmall
                                                .override(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF57636C),
                                              fontSize: 12,
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
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    updateCanStatus(product['pid'], product['type']);
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text('替換糖果罐或糖果'),
                                          content: Text('替換成功！'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(
                                                      alertDialogContext),
                                              child: Text('Ok'),
                                            ),                                          ],
                                        );
                                      },
                                    );
                                  },
                                  text: '替換',
                                  options: FFButtonOptions(
                                    width: 50,
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    color: Color(0xFFAE99E3),
                                    textStyle: FlutterFlowTheme
                                        .of(context)
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
