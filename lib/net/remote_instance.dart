// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ui_sample/net/failure.dart';

abstract class RemoteInstance {
  Future<dynamic> GET(String url,
      {Map<String, dynamic>? query, showLog = false, retries = 3});
  Future<dynamic> POST(String url, Map<String, dynamic>? data,
      {showLog = false, retries = 3});
  Future<dynamic> PUT(String url, Map<String, dynamic>? data,
      {showLog = false, retries = 3});
  Future<dynamic> DELETE(String url,
      {Map<String, dynamic>? data, showLog = false, retries = 3});
}

class RemoteInstanceImpl implements RemoteInstance {
  final Dio dio;

  RemoteInstanceImpl({required this.dio}) {
    const baseUrl = "";
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {'Content-Type': 'application/json'},
    );
  }

  @override
  Future<dynamic> GET(String url,
      {Map<String, dynamic>? query, showLog = false, retries = 3}) async {
    try {
      _dioRequestLog("GET", url, query, null, showLog);
      final Response response = await dio.get(url,
          options: Options(headers: await _getHeader()),
          queryParameters: query);
      _dioResponseLog(response, showLog);
      return response.data["data"];
    } on DioException catch (e) {
      _dioErrorLog(e, showLog);
      throw ServerException(_dioThrow(e));
    } on SocketException {
      //TODO: Localization
      throw const ServerException("Tidak dapat berkomunikasi dengan server");
    }
  }

  @override
  Future<dynamic> DELETE(String url,
      {Map<String, dynamic>? data, showLog = false, retries = 3}) async {
    try {
      _dioRequestLog("DELETE", url, null, data, showLog);
      final Response response = await dio.delete(url,
          options: Options(headers: await _getHeader()), data: data);
      _dioResponseLog(response, showLog);
      return response.data["data"];
    } on DioException catch (e) {
      _dioErrorLog(e, showLog);
      throw ServerException(_dioThrow(e));
    } on SocketException {
      //TODO: Localization
      throw const ServerException("Tidak dapat berkomunikasi dengan server");
    }
  }

  @override
  Future<dynamic> POST(String url, Map<String, dynamic>? data,
      {showLog = false, retries = 3}) async {
    try {
      _dioRequestLog("POST", url, null, data, showLog);
      final Response response = await dio.post(url,
          options: Options(headers: await _getHeader()), data: data);
      _dioResponseLog(response, showLog);
      return response.data["data"];
    } on DioException catch (e) {
      _dioErrorLog(e, showLog);
      throw ServerException(_dioThrow(e));
    } on SocketException {
      //TODO: Localization
      throw const ServerException("Tidak dapat berkomunikasi dengan server");
    }
  }

  @override
  Future<dynamic> PUT(String url, Map<String, dynamic>? data,
      {showLog = false, retries = 3}) async {
    try {
      _dioRequestLog("PUT", url, null, data, showLog);
      final Response response = await dio.put(url,
          options: Options(headers: await _getHeader()), data: data);
      _dioResponseLog(response, showLog);
      return response.data["data"];
    } on DioException catch (e) {
      _dioErrorLog(e, showLog);
      throw ServerException(_dioThrow(e));
    } on SocketException {
      //TODO: Localization
      throw const ServerException("Tidak dapat berkomunikasi dengan server");
    }
  }

  Future<Map<String, String>> _getHeader() async {
    final Map<String, String> map = {};
    var platform = "";

    map["Content-Type"] = "application/json";
    map["os"] = platform;
    return map;
  }

  String _dioThrow(DioException e) {
    // TODO: Localization
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "Waktu permintaan habis, silahkan coba lagi.";
      case DioExceptionType.sendTimeout:
        return "Waktu permintaan habis, silahkan coba lagi.";
      default:
        late String msg;
        try {
          msg = e.response?.data["msg"];
          if (msg.isEmpty) {
            msg = e.message.toString();
          }
        } on Exception {
          msg = "Terjadi gangguan, mohon coba lagi";
        }
        return msg;
    }
  }

  void _dioRequestLog(String method, String url, Map<String, dynamic>? query,
      Map<String, dynamic>? data, bool showLog) {
    if (showLog) {
      log('REQUEST[$method] => PATH:  $url');
      if (query != null) {
        log('REQUEST["QUERY"] => ${query}');
      }
      if (data != null) log('REQUEST["DATA"] => $data');
    }
  }

  void _dioResponseLog(Response response, bool showLog) {
    if (showLog) {
      log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.uri}');
      log('RESPONSE[${"BODY"}] => ${response.data}');
    }
  }

  void _dioErrorLog(DioException err, bool showLog) {
    if (showLog) {
      log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}');
      log('RESPONSE[${"BODY"}] => ${err.response}');
    }
  }
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST[${options.method}] => PATH:  ${options.uri}');
    if (options.queryParameters.isNotEmpty) {
      log('REQUEST["QUERY"] => ${options.queryParameters}');
    }
    if (options.data != null) log('REQUEST["DATA"] => ${options.data}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.uri}');
    log('RESPONSE[${"BODY"}] => ${response.data}');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}');
    log('RESPONSE[${"BODY"}] => ${err.response}');
    return super.onError(err, handler);
  }
}
