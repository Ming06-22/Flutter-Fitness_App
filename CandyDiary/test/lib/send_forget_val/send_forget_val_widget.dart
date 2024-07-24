import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'send_forget_val_model.dart';
export 'send_forget_val_model.dart';
import 'package:test/api/api_manager.dart';

class SendForgetValWidget extends StatefulWidget {
  const SendForgetValWidget({
    Key? key
  }) :
        super(key: key);


  @override
  _SendForgetValWidgetState createState() => _SendForgetValWidgetState();
}

class _SendForgetValWidgetState extends State<SendForgetValWidget> {
  late SendForgetValModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String email = '';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SendForgetValModel());

    _model.emailAddressController ??= TextEditingController();
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
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          backgroundColor: Color(0xFFC0ADDC),
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30.0,
                        borderWidth: 1.0,
                        buttonSize: 50.0,
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFF0D0814),
                          size: 24.0,
                        ),
                        onPressed: () async {
                          context.pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                child: Text(
                  'Forgot Password',
                  style: FlutterFlowTheme.of(context).displaySmall.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF0D0814),
                        fontSize: 32.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
          actions: [],
          centerTitle: true,
          toolbarHeight: 100.0,
          elevation: 0.0,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 4.0, 20.0, 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 15.0),
                    child: Text(
                      'We will send you an email with a link to reset your password, please enter the email associated with your account below.',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF0D0814),
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 4.0, 24.0, 0.0),
            child: Container(
              width: double.infinity,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5.0,
                    color: Color(0x4D101213),
                    offset: Offset(0.0, 2.0),
                  )
                ],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                controller: _model.emailAddressController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Your email address...',
                  labelStyle: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF57636C),
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                  hintText: 'Enter your email...',
                  hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF57636C),
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 0.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 0.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 0.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 0.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 20.0, 0.0),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Outfit',
                      color: Color(0xFF0F1113),
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                maxLines: null,
                validator:
                    _model.emailAddressControllerValidator.asValidator(context),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
            child: FFButtonWidget(
              onPressed: () async {
                email = _model.emailAddressController.text;
                email = encrypt(email);

                var res = await sendForgetPWVal(email);
                if(res == 'No account')
                  {
                    await showDialog(
                      context: context,
                      builder: (alertDialogContext) {
                        return AlertDialog(
                          content: Text('查無此信箱'),
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
                else{
                  await showDialog(
                    context: context,
                    builder: (alertDialogContext) {
                      return AlertDialog(
                        content: Text('已將新密碼傳至會員信箱！\n請前往信箱進行驗證！'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(alertDialogContext),
                            child: Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                  context.pushNamed('forget_password');
                }
              },
              text: 'Send Link',
              options: FFButtonOptions(
                width: 270.0,
                height: 50.0,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Color(0xFF0F1113),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                elevation: 3.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
