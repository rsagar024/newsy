import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:newsy_app/core/enums/remote_enum/request_methods.dart';
import 'package:newsy_app/core/remote/rest_client.dart';

abstract class RestServiceBase extends RestClient {
  static const int _maxRetryAttempts = 3;

  RestServiceBase();

  Future<T> executeRequestAsync<T>(RestRequest restRequest, T Function(Map<String, dynamic>) fromJson, {int retryCount = 0}) async {
    try {
      Response<dynamic> response = await _sendRequest(restRequest);
      _handleResponse(response);
      final jsonResponse = response.data;

      if (jsonResponse is T) {
        return jsonResponse;
      } else if (jsonResponse is Map<String, dynamic>) {
        return fromJson(jsonResponse);
      } else {
        throw ArgumentError('Invalid response format for type $T');
      }
    } on DioException catch (error) {
      debugPrint(error.toString());
      final content = error.response?.data?.toString() ?? '';
      // final actionCode = _getActionCode(content);
      if (error.response?.statusCode == 401 && retryCount < _maxRetryAttempts) {
        return await _retryWithRefreshToken(restRequest, fromJson, retryCount + 1);
      } else {
        _handleDioError(error);
        rethrow;
      }
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  Future<Response<dynamic>> _sendRequest(RestRequest restRequest) {
    return dio.request<dynamic>(
      restRequest.path,
      data: restRequest.body,
      options: Options(
        method: _mapRequestMethodToString(restRequest.requestMethod),
        headers: restRequest.headers,
      ),
    );
  }

  String _mapRequestMethodToString(RequestMethod? method) {
    switch (method) {
      case RequestMethod.get:
        return 'GET';
      case RequestMethod.post:
        return 'POST';
      case RequestMethod.put:
        return 'PUT';
      case RequestMethod.delete:
        return 'DELETE';
      default:
        throw Exception("Unknown Method");
    }
  }

  Future<T> _retryWithRefreshToken<T>(RestRequest originalRequest, T Function(Map<String, dynamic>) fromJson, int retryCount) async {
    try {
      final newToken = await _refreshToken();
      if (newToken != null) {
        return await executeRequestAsync<T>(originalRequest, fromJson, retryCount: retryCount);
      } else {
        // throw RestTokenInvalidException();
        throw Exception('Rest Token Invalid!');
      }
    } catch (e) {
      throw Exception('Rest Token Invalid!');
    }
  }

  Future<String?> _refreshToken() async {
    // final authTokenRepository = getIt<AuthTokenRepository>();
    // final result = await authTokenRepository.getRefreshToken();
    // return result?.idToken;
  }

  void _handleResponse(Response<dynamic> response) {
    final statusCode = response.statusCode;
    if (statusCode == null) {
      throw Exception('No status code found');
    }

    if (statusCode == 200) return;
    if (statusCode == 401) return _handleUnauthorized(response);
    if (statusCode == 403) throw Exception('User don\'t have permission to access this content');
    if (statusCode == 404) {
      throw Exception('Resource not found');
    }
    if (statusCode == 204) throw Exception('No content returned');
    if (statusCode >= 500) throw Exception('Server error');
  }

  void _handleUnauthorized(Response<dynamic> response) {
    /*final content = response.data?.toString() ?? '';
    final actionCode = _getActionCode(content);

    if (content.contains("User Not Active")) {
      // _logout();
      throw "Your account is inactive. Please contact admin for assistance.";
    } else if (actionCode == ErrorActionCode.refresh.code) {
      throw RestTokenInvalidException();
    } else if ((actionCode == ErrorActionCode.logout.code || content.contains("Password has been changed")) && response.requestOptions.path != "api/mobile/tokens") {
      _logout();
    } else {
      throw response.data?['exception'] ?? "something went wrong";
    }*/
  }

  void _handleDioError(DioException error) {
    final statusCode = error.response?.statusCode;
    if (statusCode == null) {
      throw Exception('No status code found');
    }
    if (statusCode == 401) return _handleUnauthorized(error.response!);
    if (statusCode == 403) throw Exception('User don\'t have permission to access this content');
    if (statusCode == 404) throw Exception('Resource not found');
    if (statusCode == 204) throw Exception('No content returned');
    if (statusCode >= 500) {
      final errorMessage = error.response?.data['messages'][0] ?? error.message;
      throw errorMessage;
    }
    throw Exception(error.message);
  }

  int _getActionCode(String content) {
    try {
      final actionCodeRegex = RegExp(r'actionCode\s*:\s*(\d+)');
      final match = actionCodeRegex.firstMatch(content);
      if (match != null) {
        return int.parse(match.group(1)!);
      }
      return 100;
    } catch (e) {
      debugPrint(e.toString());
      return 100;
    }
  }

  RestRequest createGetRequest(String resource, {dynamic body}) => RestRequest(resource, body, method: RequestMethod.get);

  RestRequest createPostRequest(String resource, {dynamic body}) => RestRequest(resource, body, method: RequestMethod.post);

  RestRequest createPutRequest(String resource, {dynamic body}) => RestRequest(resource, body, method: RequestMethod.put);

  RestRequest createDeleteRequest(String resource, {dynamic body}) => RestRequest(resource, body, method: RequestMethod.delete);
}
