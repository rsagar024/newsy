import 'package:newsy_app/core/remote/rest_client.dart';

extension RestRequestExtension on RestRequest {
  Map<String, dynamic> addAuthorizationHeader() {
    return headers = {'X-Api-Key': 'af2621abe32543d481a8851d3a879a4e'};
  }

  RestRequest updateAuthorizationHeader() {
    headers?['X-Api-Key'] = 'af2621abe32543d481a8851d3a879a4e';
    // headers?['X-Api-Key'] = '0b756cd3ad61447994a67e0970eb44a9';
    return this;
  }
}
