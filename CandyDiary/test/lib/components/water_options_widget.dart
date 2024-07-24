import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'water_options_model.dart';
export 'water_options_model.dart';

class WaterOptionsWidget extends StatefulWidget {
  const WaterOptionsWidget({Key? key}) : super(key: key);

  @override
  _WaterOptionsWidgetState createState() => _WaterOptionsWidgetState();
}

class _WaterOptionsWidgetState extends State<WaterOptionsWidget> {
  late WaterOptionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WaterOptionsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: Container(
        width: 300,
        height: 225,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x33000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 12, 0, 0),
              child: Text(
                'Options',
                textAlign: TextAlign.start,
                style: FlutterFlowTheme.of(context).labelMedium.override(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Color(0xFF57636C),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pushNamed('record_water');
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: FaIcon(
                            FontAwesomeIcons.coffee,
                            color: Color(0xFF14181B),
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              '記錄飲水',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF14181B),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pushNamed('water_target');
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: FaIcon(
                            FontAwesomeIcons.coffee,
                            color: Color(0xFF14181B),
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              '修改飲水目標',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF14181B),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
