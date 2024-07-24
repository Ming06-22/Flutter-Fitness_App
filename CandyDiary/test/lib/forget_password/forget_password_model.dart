import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgetPasswordModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for emailAddress widget.
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;
  // State field(s) for newPassword widget.
  TextEditingController? newPasswordController;
  String? Function(BuildContext, String?)? newPasswordControllerValidator;
  // State field(s) for checkNewPassword widget.
  TextEditingController? checkNewPasswordController;
  String? Function(BuildContext, String?)? checkNewPasswordControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    emailAddressController?.dispose();
    newPasswordController?.dispose();
    checkNewPasswordController?.dispose();
  }

/// Action blocks are added here.

/// Additional helper methods are added here.
}
