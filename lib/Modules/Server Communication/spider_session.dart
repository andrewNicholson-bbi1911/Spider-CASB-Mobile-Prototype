import 'dart:developer';
import 'dart:io';
import '../../Config/config.dart';

import 'package:dio/dio.dart';

class SpiderCASBSession{

  static SpiderCASBSession get instance {
    _instance ??= SpiderCASBSession();
    return _instance!;
  }
  static SpiderCASBSession? _instance;

  late int userId;
  late String userName;

  String? _token;
  final dio = Dio();


  SpiderCASBSession(){
    log("creating new instance of Session");
  }

  static void SetToken(String token){
    instance._token = token;
    log("token set: ${instance._token}");
  }

  static Future<dynamic> get(
      String pathUrl, {
        Map<String, dynamic>? params,
        Map<String, dynamic>? extraHeaders,
      }) async
  {
    try{
      var url = "${Config.SpiderCasbAPIBaseURL}/$pathUrl?${_getQueryParams(params)}";
      extraHeaders = _setAuthHeader(extraHeaders);
      print("Sending GET to ${url} : ${extraHeaders}");

      final response = await instance.dio.get(
        url,
        options: Options(
          headers: extraHeaders,
        ),
      );
      log("$url ${response.headers.toString()}\n${response.data.toString()}");
      return response;
    }catch(_){
      if(_ is DioException){
        return (_ as DioException).response;
      }
    }

  }


  static Future<dynamic> post(
      String pathUrl, {
        dynamic body = const {},
        Map<String, dynamic>? params,
        Map<String, dynamic>? extraHeaders,
      }) async
  {
    try {
      var url = "${Config.SpiderCasbAPIBaseURL}/$pathUrl?${_getQueryParams(
          params)}";
      print("Setting POST URL as ${url}");
      extraHeaders = _setAuthHeader(extraHeaders);
      print("Sending POST");

      final response = await instance.dio.post(
        url,
        data: body,
        options: Options(
          headers: extraHeaders,
        ),
      );
      //log("$url ${response.headers.toString()}\n${response.data.toString()}");
      return response;
    }catch(_){
      if(_ is DioException){
        return (_ as DioException).response;
      }
    }
  }


  static Future<dynamic> put(
      String pathUrl, {
        body = const {},
        Map<String, dynamic>? params,
        Map<String, dynamic>? extraHeaders,
      }) async
  {
    try {
      var url = "${Config.SpiderCasbAPIBaseURL}/$pathUrl?${_getQueryParams(
          params)}";
      print("Sending PUT to ${url}");
      extraHeaders = _setAuthHeader(extraHeaders);

      final response = await instance.dio.put(
        url,
        data: body,
        options: Options(
          headers: extraHeaders,
        ),
      );
      //log("$url ${response.headers.toString()}\n${response.data.toString()}");
      return response;
    }catch(_){
      if(_ is DioException){
        return (_ as DioException).response;
      }
    }
  }

  static bool isRequestSuccessful(Response<dynamic>? request){
    return request!=null && request.statusCode != null && (request.statusCode! >= 200 && request.statusCode! <= 299);
  }


  static Map<String, dynamic> _setAuthHeader(Map<String, dynamic>? headers){
    headers ??= {};

    try {
      log("setting auth header with token ${instance._token}");
      headers.addAll({HttpHeaders.authorizationHeader:"Bearer ${instance._token}"});
    }catch(_){
      log(_.toString());
    }
    return headers;

  }

  static String _getQueryParams(Map<String, dynamic>? params) {
    if(params == null){
      return "";
    }

    String result = "";
    params.forEach((key, value) {
      result += "$key=${Uri.encodeComponent(value.toString())}&";
    });
    return result;
  }
}