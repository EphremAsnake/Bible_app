import 'htttp_attrib_options.dart';

abstract class HttpService {
  Future<dynamic> sendHttpRequest(
      HttpClientAttributeOptions httpAttribOptions);
}