import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'timer_model.dart';
export 'timer_model.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    Key? key,
    int? time,
  })  : this.time = time ?? 60000,
        super(key: key);

  final int time;

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late TimerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TimerModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.close_rounded,
              color: Color(0xFF14181B),
              size: 30,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'Pushups',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Space Grotesk',
              color: Color(0xFF14181B),
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(32, 8, 32, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Time Left',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF14181B),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: '修改時間',
                          options: FFButtonOptions(
                            height: 40,
                            padding:
                            EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
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
                        FlutterFlowIconButton(
                          borderColor: Color(0xFFE0E3E7),
                          borderRadius: 30,
                          borderWidth: 2,
                          buttonSize: 44,
                          fillColor: Colors.white,
                          icon: Icon(
                            Icons.refresh_rounded,
                            color: Color(0xFF14181B),
                            size: 20,
                          ),
                          onPressed: () async {
                            _model.timerController.onExecute
                                .add(StopWatchExecute.reset);
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 24),
                        child: FlutterFlowTimer(
                          initialTime: widget.time,
                          getDisplayTime: (value) =>
                              StopWatchTimer.getDisplayTime(value,
                                  milliSecond: false),
                          timer: _model.timerController,
                          onChanged: (value, displayTime, shouldUpdate) {
                            _model.timerMilliseconds = value;
                            _model.timerValue = displayTime;
                            if (shouldUpdate) setState(() {});
                          },
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .displaySmall
                              .override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF14181B),
                            fontSize: 64,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: Color(0xFFE0E3E7),
                        borderRadius: 30,
                        borderWidth: 2,
                        buttonSize: 60,
                        icon: Icon(
                          Icons.pause_rounded,
                          color: Color(0xFF14181B),
                          size: 30,
                        ),
                        onPressed: () async {
                          _model.timerController.onExecute
                              .add(StopWatchExecute.stop);
                        },
                      ),
                      FlutterFlowIconButton(
                        borderColor: Color(0xFF048B6C),
                        borderRadius: 30,
                        borderWidth: 2,
                        buttonSize: 60,
                        fillColor: Color(0xFFAE99E3),
                        icon: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 36,
                        ),
                        onPressed: () async {
                          _model.timerController.onExecute
                              .add(StopWatchExecute.start);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFE5E0EB),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Color(0x34111417),
                            offset: Offset(0, -2),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 12, 15, 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Workout ',
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF14181B),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'Push Ups',
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF03CE9F),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 12, 0, 12),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Current Set',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF14181B),
                                            fontSize: 28,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          '40 in 1 minute',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF14181B),
                                            fontSize: 28,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Pushups are an exercise in which a person, keeping a prone position, with the hands palms down under the shoulders, the balls of the feet on the ground, and the back straight, pushes the body up and lets it down by an alternate straightening and bending of the arms.',
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                      fontFamily: 'Space Grotesk',
                                      color: Color(0xFF57636C),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                              child: FFButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
                                },
                                text: 'Complete Workout',
                                options: FFButtonOptions(
                                  width: 270,
                                  height: 50,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  color: Color(0xFF14181B),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                    fontFamily: 'Space Grotesk',
                                    color: Color(0xFFF1F4F8),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  elevation: 2,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
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
    );
  }
}
