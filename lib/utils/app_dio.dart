
import 'package:dio/dio.dart';
import 'package:task33_complete_from_my_frien/database/shared_prefrences.dart';
import 'package:task33_complete_from_my_frien/models/app_endpoints.dart';

class AppDio {
  static Dio? _dio;
  static Dio _instance() {
    return _dio ??= Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
      ),
    );
  }
  static void init() {
    _dio = _instance();
  }
  static Future<Response<dynamic>> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio!.get(
      endPoint,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          'lang': 'en',
          'Content-Type': 'application/json',
          'Authorization': PreferenceUtils.getString(PrefKeys.apiToken),
        },
      ),
    );
  }
  static Future<Response<dynamic>> post({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) {
    return _dio!.post(
      endPoint,
      queryParameters: queryParameters,
      data: body,
      options: Options(
        headers: {
          'lang': 'en',
          'Content-Type': 'application/json',
          'Authorization': PreferenceUtils.getString(PrefKeys.apiToken),
        },
      ),
    );
  }
  static Future<Response<dynamic>> put({
  required String endPoint,
  Map<String, dynamic>? queryParameters,
  Map<String, dynamic>? body,

}) {
return _dio!.put(
endPoint,
queryParameters: queryParameters,
data: body,
options: Options(
headers: {
'lang': 'en',
'Content-Type': 'application/json',
'Authorization': PreferenceUtils.getString(PrefKeys.apiToken),
},
),
);
}
static Future<Response<dynamic>> delete({
required String endPoint,
Map<String, dynamic>? queryParameters,
Map<String, dynamic>? body,
}) {
return _dio!.delete(
endPoint,
queryParameters: queryParameters,
options: Options(
headers: {
'lang': 'en',
'Content-Type': 'application/json',
'Authorization': PreferenceUtils.getString(PrefKeys.apiToken),
},
),
);
}
}