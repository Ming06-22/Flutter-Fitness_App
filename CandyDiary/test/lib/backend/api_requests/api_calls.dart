import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

var url = Uri.https('1de3-60-250-225-148.ngrok-free.app', '/image');

class UploadImageCall {
  static Future<ApiCallResponse> call({
    FFUploadedFile? image,
    String? name = 'photo',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'upload image',
      apiUrl: url.toString(),
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'image': image,
        'name': name,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
  static dynamic calorie(dynamic response) => getJsonField(
    response,
    r'''$.calorie''',
  );
  static dynamic name(dynamic response) => getJsonField(
    response,
    r'''$.name''',
  );
  static dynamic fat(dynamic response) => getJsonField(
    response,
    r'''$.fat''',
  );
  static dynamic carbon(dynamic response) => getJsonField(
    response,
    r'''$.carbon''',
  );
  static dynamic protein(dynamic response) => getJsonField(
    response,
    r'''$.protein''',
  );
  static dynamic saturatedFat(dynamic response) => getJsonField(
    response,
    r'''$.saturated_fat''',
  );
  static dynamic unsaturatedFat(dynamic response) => getJsonField(
    response,
    r'''$.unsaturated_fat''',
  );
  static dynamic sugar(dynamic response) => getJsonField(
    response,
    r'''$.sugar''',
  );
  static dynamic na(dynamic response) => getJsonField(
    response,
    r'''$.na''',
  );
  static dynamic ca(dynamic response) => getJsonField(
    response,
    r'''$.ca''',
  );
  static dynamic k(dynamic response) => getJsonField(
    response,
    r'''$.k''',
  );
  static dynamic num(dynamic response) => getJsonField(
    response,
    r'''$.num''',
  );
  static dynamic unit(dynamic response) => getJsonField(
    response,
    r'''$.unit''',
  );
  static dynamic getFoods(dynamic response) => getJsonField(
    response,
    r'''$.food''',
    true,
  );

}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
