import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import '../database/model.dart';
import '../api/api_manager.dart';

import 'forget_password_model.dart';
export 'forget_password_model.dart';

class ForgetPasswordWidget extends StatefulWidget {
  const ForgetPasswordWidget({Key? key}) : super(key: key);

  @override
  _ForgetPasswordWidgetState createState() => _ForgetPasswordWidgetState();
}

class _ForgetPasswordWidgetState extends State<ForgetPasswordWidget> {
  late ForgetPasswordModel _model;
  late String email;
  late String newPassword;
  late String confirmPassword;
  late String account;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ForgetPasswordModel());

    _model.emailAddressController ??= TextEditingController();
    _model.newPasswordController ??= TextEditingController();
    _model.checkNewPasswordController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  String encrypt(String token) {
    String result = "";
    for (int i = 0; i < token.length; i += 8) {
      if (i + 4 < token.length) {
        for (int i2 = i + 4; i2 < (i + 8 < token.length ? i + 8 : token.length); i2++) {
          result += String.fromCharCode(token.codeUnitAt(i2) + 7);
        }
      }
      for (int i2 = i; i2 < (i + 4 < token.length ? i + 4 : token.length); i2++) {
        result += String.fromCharCode(token.codeUnitAt(i2) + 7);
      }
    }
    return result;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFC0ADDC),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          backgroundColor: Color(0xFFC0ADDC),
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 50,
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFF0D0814),
                          size: 24,
                        ),
                        onPressed: () async {
                          context.pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                      child: Text(
                        'Back',
                        style:
                        FlutterFlowTheme.of(context).displaySmall.override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF0D0814),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                child: Text(
                  'Forgot Password',
                  style: FlutterFlowTheme.of(context).displaySmall.override(
                    fontFamily: 'Outfit',
                    color: Color(0xFF0D0814),
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          actions: [],
          centerTitle: true,
          toolbarHeight: 100,
          elevation: 0,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 4, 20, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                    child: Text(
                      '請輸入帳號及欲修改之新密碼',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF0D0814),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 10),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Color(0x4D101213),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: TextFormField(
                  controller: _model.emailAddressController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Your email address...',
                    labelStyle: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'Outfit',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    hintText: 'Enter your email...',
                    hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding:
                    EdgeInsetsDirectional.fromSTEB(24, 24, 20, 0),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Outfit',
                    color: Color(0xFF0F1113),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: null,
                  validator: _model.emailAddressControllerValidator
                      .asValidator(context),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 4),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Color(0x4D101213),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: TextFormField(
                  controller: _model.newPasswordController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Your new password...',
                    labelStyle: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'Outfit',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    hintText: 'Enter your new password...',
                    hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding:
                    EdgeInsetsDirectional.fromSTEB(24, 24, 20, 0),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Outfit',
                    color: Color(0xFF0F1113),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: null,
                  validator: _model.newPasswordControllerValidator
                      .asValidator(context),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 10, 24, 4),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Color(0x4D101213),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: TextFormField(
                  controller: _model.checkNewPasswordController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Confirm the new password...',
                    labelStyle: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'Outfit',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    hintText: 'Confirm your new password...',
                    hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding:
                    EdgeInsetsDirectional.fromSTEB(24, 24, 20, 0),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Outfit',
                    color: Color(0xFF0F1113),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: null,
                  validator: _model.checkNewPasswordControllerValidator
                      .asValidator(context),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            child: FFButtonWidget(
              onPressed: () async {
                email = _model.emailAddressController.text;
                account = _model.emailAddressController.text;
                newPassword = _model.newPasswordController.text;
                confirmPassword = _model.checkNewPasswordController.text;
                if(newPassword == confirmPassword)
                  {
                    email = encrypt(email);
                    newPassword = encrypt(newPassword);

                    var res = await changePassword(email, newPassword);
                    if(res == 'False')
                      {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Wrong!'),
                              content: Text('密碼格式錯誤，請重新輸入！'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(alertDialogContext),
                                  child: Text('Ok'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    if(res == 'Success')
                      {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('修改密碼'),
                              content: Text('成功修改密碼！'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(alertDialogContext),
                                  child: Text('Ok'),
                                ),
                              ],
                            );
                          },
                        );
                        context.safePop();
                      }
                    if(res == 'No Validation')
                      {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Wrong!'),
                              content: Text('帳號尚未驗證成功，請先至信箱進行驗證。'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(alertDialogContext),
                                  child: Text('Ok'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    if(res == 'No account')
                    {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: Text('Wrong!'),
                            content: Text('帳號$account不存在'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(alertDialogContext),
                                child: Text('Ok'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                else{
                  await showDialog(
                    context: context,
                    builder: (alertDialogContext) {
                      return AlertDialog(
                        title: Text('Wrong!'),
                        content: Text('密碼不相符'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(alertDialogContext),
                            child: Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              text: 'Send Request',
              options: FFButtonOptions(
                width: 270,
                height: 50,
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: Color(0xFF0F1113),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                elevation: 3,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
