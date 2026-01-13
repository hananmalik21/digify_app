import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digify_app/core/data/app_exceptions.dart' show DioExceptionError;
import 'package:digify_app/core/utils/static_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'base_api_service.dart';

class NetworkApi extends BaseService {
  static final Dio _dio = Dio();

  NetworkApi() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _handleRequestInterceptor,
        onResponse: _handleResponseInterceptor,
        onError: _handleErrorInterceptor,
      ),
    );
  }

  void _handleRequestInterceptor(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // log("Requesting: ${options.method} ${options.uri}");
    handler.next(options);
  }

  void _handleResponseInterceptor(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    log("Response:Status Code ${response.statusCode}");

    if (response.statusCode == 401) {
      _navigateToLogin();
      return;
    }

    handler.next(response);
  }

  void _handleErrorInterceptor(
    DioException error,
    ErrorInterceptorHandler handler,
  ) {
    log("Error occurred HERE: ${error.response?.statusCode}");

    if (error.response?.statusCode == 401) {
      _navigateToLogin();
      if (error.response?.data["message"] != "Invalid credentials") {
        return;
      }
    }

    handler.next(error);
  }

  void _navigateToLogin() {
    // SharedPreferencesService().removeUserData();
    // Utils().showToast("Session expired.Please login again", success: false);
    // NavigationService.navigatorKey.currentContext!.pushAndRemoveUntil(
    //   LoginView(),
    // );
  }

  Future<bool> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return ConnectivityResult.none == connectivityResult;
    // return false;
  }

  @override
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? customHeader,
    bool isKpcApp = true,
  }) async {
    if (kDebugMode) log("URL IS $url");
    return _handleRequest(() async {
      return await _dio.get(
        url,
        queryParameters: params,
        options: await _buildDioOptions(customHeader),
      );
    });
  }

  @override
  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? customHeader,
    List<MapEntry<String, File>>? files,
    bool isKpcApp = true,
  }) async {
    if (kDebugMode) log("URL IS $url");
    return _handleRequest(() async {
      var data = files != null && files.isNotEmpty
          ? await _prepareFormData(body, files)
          : body;
      return await _dio.post(
        url,
        data: data,
        options: await _buildDioOptions(customHeader),
      );
    });
  }

  @override
  Future<dynamic> put({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? customHeader,
    List<MapEntry<String, File>>? files,
    bool isKpcApp = true,
  }) async {
    if (kDebugMode) log("URL IS $url");
    if (kDebugMode) log("body IS $body");
    return _handleRequest(() async {
      var data = files != null && files.isNotEmpty
          ? await _prepareFormData(body, files)
          : body;
      return await _dio.put(
        url,
        data: data,
        queryParameters: params,
        options: await _buildDioOptions(customHeader),
      );
    });
  }

  @override
  Future<dynamic> delete({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? customHeader,
    bool isKpcApp = true,
  }) async {
    if (kDebugMode) log("URL IS $url");
    if (kDebugMode) log("body IS $body");
    return _handleRequest(() async {
      return await _dio.delete(
        url,
        data: body,
        queryParameters: params,
        options: await _buildDioOptions(customHeader),
      );
    });
  }

  Future<dynamic> _handleRequest(
    Future<Response<dynamic>> Function() request,
  ) async {
    try {
      if (await checkConnectivity()) {
        throw "No Internet Connection";
      }
      final response = await request();
      log("code is ${response.statusMessage}");
      log("code is ${response.statusCode}");
      return _returnResponse(
        response.data,
        response.statusMessage,
        response.statusCode,
      );
    } on DioException catch (e) {
      throw DioExceptionError(_getDioExceptionErrorMessage(e.type, e.response));
    }
  }

  Future<Options> _buildDioOptions(Map<String, dynamic>? customHeader) async {
    String? token;
    token = StaticInfo.authToken;

    if (kDebugMode) {
      log("header is $customHeader");
      log("token is $token");
    }
    return Options(
      // headers: customHeader ?? header,
      headers: {
        if (customHeader != null) ...customHeader,
        'Authorization': 'Bearer $token',
      },
      sendTimeout: const Duration(milliseconds: 22000),
      receiveTimeout: const Duration(milliseconds: 22000),
    );
  }

  Future<FormData> _prepareFormData(
    Map<String, dynamic>? body,
    List<MapEntry<String, File>> files,
  ) async {
    FormData formData = FormData();
    body?.forEach((key, value) {
      formData.fields.add(MapEntry(key, value.toString()));
    });

    for (var fileEntry in files) {
      String fileName = fileEntry.value.path.split('/').last;
      log("Adding file: ${fileEntry.key} - ${fileEntry.value.path}");
      formData.files.add(
        MapEntry(
          fileEntry.key,
          await MultipartFile.fromFile(
            fileEntry.value.path,
            filename: fileName,
          ),
        ),
      );
    }
    if (kDebugMode) {
      print("fields are $formData");
    }
    if (kDebugMode) {
      print("fields length are ${formData.files.length}");
    }
    return formData;
  }

  String _getDioExceptionErrorMessage(
    DioExceptionType type,
    Response? response,
  ) {
    if (kDebugMode) {
      print("Exception Type: $type");
    }
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return response?.data["message"] ?? "Connection Timed Out";
      case DioExceptionType.receiveTimeout:
        return response?.data["message"] ?? "Receive Timed Out";
      case DioExceptionType.sendTimeout:
        return response?.data["message"] ?? "Send Timed Out";
      case DioExceptionType.badResponse:
        return response?.data["message"] ?? "Server Error";
      case DioExceptionType.connectionError:
        return response?.data["message"] ?? "Connection Error";
      case DioExceptionType.unknown:
        return "Something went wrong";
      default:
        return "Something went wrong";
    }
  }



  // dynamic _returnResponse(
  //   dynamic response,
  //   String? statusMessage,
  //   int? statusCode,
  // ) {
  //   try {
  //     // If response is a JSON string, decode it
  //     if (response is String) {
  //       response = jsonDecode(response);
  //     }
  //
  //     if (kDebugMode) {
  //       log("Decoded Response: $response");
  //       log("Status Message: $statusMessage");
  //       log("Status Code: $statusCode");
  //       log("Response type: ${response.runtimeType}");
  //     }
  //
  //     if (response is Map<String, dynamic>) {
  //       var status = response['status'] ;
  //
  //       if (status != null) {
  //         if (status is num) {
  //           switch (status) {
  //             case 200:
  //             case 201:
  //               return response;
  //             default:
  //               throw response['message'] ?? 'Unknown error';
  //           }
  //         } else if (status is String) {
  //           if (status.toLowerCase() == 'success') {
  //             return response;
  //           } else {
  //             throw response['message'] ?? 'Unknown error';
  //           }
  //         }
  //       } else if ((response['success'] ?? false) == true) {
  //         return response;
  //       } else if (statusMessage == "OK" && statusCode == 200) {
  //         if (kDebugMode) log("Fallback success based on status code.");
  //         return response;
  //       } else {
  //         throw response['message'] ?? 'Unknown error';
  //       }
  //     } else if (response is List) {
  //       if (kDebugMode) log("Returning list response.");
  //       return response; // Handle list response gracefully
  //     } else {
  //       throw 'Invalid response format — expected a Map or List but got ${response.runtimeType}';
  //     }
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
  dynamic _returnResponse(
      dynamic response,
      String? statusMessage,
      int? statusCode,
      ) {
    try {
      // Decode JSON string if necessary
      if (response is String) {
        response = jsonDecode(response);
      }

      if (kDebugMode) {
        log("Decoded Response: $response");
        log("Status Message: $statusMessage");
        log("Status Code: $statusCode");
        log("Response type: ${response.runtimeType}");
      }

      // If response is a Map
      if (response is Map<String, dynamic>) {
        // Check for 'status' key first
        var status = response['status'];
        if (status != null) {
          if (status is num) {
            if (status == 200 || status == 201) return response;
            throw response['message'] ?? 'Unknown error';
          } else if (status is String) {
            if (status.toLowerCase() == 'success') return response;
            throw response['message'] ?? 'Unknown error';
          }
        }

        // Fallback: check 'success' key
        if ((response['success'] ?? false) == true) return response;

        // Fallback: use statusCode from backend
        if (statusCode != null && statusCode >= 200 && statusCode < 300) {
          if (kDebugMode) log("Fallback success based on statusCode.");
          return response;
        }

        // If nothing works, throw message
        throw response['message'] ?? 'Unknown error';
      }
      // If response is a List
      else if (response is List) {
        if (kDebugMode) log("Returning list response.");
        return response;
      }
      // Unexpected type
      else {
        throw 'Invalid response format — expected a Map or List but got ${response.runtimeType}';
      }
    } catch (e) {
      throw e.toString();
    }
  }

}
