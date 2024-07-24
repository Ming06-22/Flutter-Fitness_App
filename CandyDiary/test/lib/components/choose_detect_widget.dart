import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'choose_detect_model.dart';
export 'choose_detect_model.dart';

class ChooseDetectWidget extends StatefulWidget {
  const ChooseDetectWidget({
    Key? key,
    required this.onSelectionChanged,
    String? name,
  })  : this.name = name ?? 'photo',
        super(key: key);

  final String name;
  final Function(String) onSelectionChanged;

  @override
  _ChooseDetectWidgetState createState() => _ChooseDetectWidgetState();
}

class _ChooseDetectWidgetState extends State<ChooseDetectWidget> {
  late ChooseDetectModel _model;
  String name = 'photo';

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChooseDetectModel());

  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 1.0),
      child: Container(
        width: double.infinity,
        height: 225.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 8.0,
              color: Color(0xFF0D0F10),
              offset: Offset(0.0, 2.0),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                child: Text(
                    '選取辨識種類' /* 選取辨識種類 */,
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF050505),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 0.0, 8.0),
                child: Text(
                    'label or photo' /* label or photo */,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF57636C),
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 60.0,
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      name = 'photo';
                      widget.onSelectionChanged(name);
                      Navigator.pop(context, name);
                    },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Color(0xFFF1F4F8),
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 8.0, 8.0, 8.0),
                          child: Icon(
                            Icons.fastfood_sharp,
                            color: Color(0xFF57636C),
                            size: 20.0,
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                      child:
                      Text(
                          '食品影像' /* 食品影像 */,
                        style: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF14181B),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ],
                  ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 60.0,
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      name = 'label';
                      widget.onSelectionChanged(name);
                      Navigator.pop(context, name);
                    },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Color(0xFFF1F4F8),
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 8.0, 8.0, 8.0),
                          child: Icon(
                            Icons.label,
                            color: Color(0xFF57636C),
                            size: 20.0,
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                      child:
                      Text(
                          '食品標籤' /* 食品標籤 */,
                        style: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF14181B),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
