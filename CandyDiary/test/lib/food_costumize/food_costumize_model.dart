import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';

class FoodCostumizeModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
  FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (upload image)] action in IconButton widget.
  ApiCallResponse? imageDetect;

  // State field(s) for TextField widget.
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for TextField widget.
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;
  // State field(s) for TextField widget.
  TextEditingController? textController6;
  String? Function(BuildContext, String?)? textController6Validator;

  TextEditingController? textController7;
  String? Function(BuildContext, String?)? textController7Validator;

  TextEditingController? textController8;
  String? Function(BuildContext, String?)? textController8Validator;

  TextEditingController? textController9;
  String? Function(BuildContext, String?)? textController9Validator;

  TextEditingController? textController10;
  String? Function(BuildContext, String?)? textController10Validator;

  TextEditingController? textController11;
  String? Function(BuildContext, String?)? textController11Validator;

  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    textController4?.dispose();
    textController5?.dispose();
    textController6?.dispose();
    textController7?.dispose();
    textController8?.dispose();
    textController9?.dispose();
    textController10?.dispose();
    textController11?.dispose();
  }

/// Action blocks are added here.

/// Additional helper methods are added here.
}
