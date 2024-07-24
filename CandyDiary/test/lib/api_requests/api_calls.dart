import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class UploadImageCall {
  static Future<ApiCallResponse> call({
    FFUploadedFile? image,
    String? name = 'photo',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'upload image',
      apiUrl: '1de3-60-250-225-148.ngrok-free.app',
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
  static dynamic getFoods(dynamic response) => getJsonField(
        response,
        r'''$.food''',
        true,
      );
}

class UploadImageCopyCall {
  static Future<ApiCallResponse> call({
    String? name = 'photo',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'upload image Copy',
      apiUrl: '1de3-60-250-225-148.ngrok-free.app/image',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'name': name,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
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
