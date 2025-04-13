import 'package:dio/dio.dart';
import 'package:newsy_app/core/enums/remote_enum/request_methods.dart';

class RestClient {
  Dio dio = Dio();

  RestClient() {
    if (dio.options.baseUrl.isEmpty) {
      const baseUrl = 'https://newsapi.org/v2/everything';
      if (baseUrl == null) throw Exception('Base url not found!');
      dio.options.baseUrl = baseUrl;
    }
  }
}

class RestRequest extends Options {
  final String path;
  final dynamic body;
  RequestMethod? requestMethod = RequestMethod.get;

  RestRequest(this.path, this.body, {RequestMethod? method, dynamic}) {
    requestMethod = method;
  }

  setRequestHeaders(Map<String, dynamic>? headers) {
    super.headers = headers;
  }
}