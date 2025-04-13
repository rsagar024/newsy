import 'package:newsy_app/core/extensions/rest_request_extension.dart';
import 'package:newsy_app/core/remote/rest_client.dart';
import 'package:newsy_app/core/remote/rest_service_base.dart';

class NewsRestService extends RestServiceBase{
  @override
  RestRequest createGetRequest(String resource, {body}) {
    final request = super.createGetRequest(resource, body: body);
    request.addAuthorizationHeader();
    return request;
  }

  @override
  RestRequest createPostRequest(String resource, {body}) {
    final request = super.createPostRequest(resource, body: body);
    request.addAuthorizationHeader();
    return request;
  }

  @override
  RestRequest createPutRequest(String resource, {body}) {
    final request = super.createPutRequest(resource, body: body);
    request.addAuthorizationHeader();
    return request;
  }

  @override
  RestRequest createDeleteRequest(String resource, {body}) {
    final request = super.createDeleteRequest(resource, body: body);
    request.addAuthorizationHeader();
    return request;
  }

  @override
  Future<T> executeRequestAsync<T>(RestRequest restRequest, T Function(Map<String, dynamic>) fromJson, {int retryCount = 0}) async {
    return super.executeRequestAsync(restRequest, fromJson, retryCount: retryCount);
  }

  Future<String?> _refreshToken() async {
    return null;
  }
}