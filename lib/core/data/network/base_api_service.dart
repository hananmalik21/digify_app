import 'dart:io';

/// Base service call for calling api requests
abstract class BaseService {
  Future get({
    required String url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? customHeader,
    bool isKpcApp = true,
  });

  Future post({
    required String url,
    required Map<String, dynamic> body,
    Map<String, dynamic>? customHeader,
    List<MapEntry<String, File>>? files,
    bool isKpcApp = true,
  });

  Future put({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? customHeader,
    List<MapEntry<String, File>>? files,
    bool isKpcApp = true,
  });

  Future delete({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? customHeader,
    bool isKpcApp = true,
  });
}
