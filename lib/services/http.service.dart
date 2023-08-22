//ignore_for_file: depend_on_referenced_packages
import 'package:anywheretest/constants/api.dart';
import 'package:dio/dio.dart';

class HttpService {
  static String host = Api.baseUrl;
  static Dio dio = Dio();

  //for get api calls
  static Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    //preparing the api uri/url
    String uri = "$host$url";
    return dio.get(
      uri,
    );
  }
}
