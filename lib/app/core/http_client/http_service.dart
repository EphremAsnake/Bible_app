import 'package:american_bible/app/core/http_client/htttp_attrib_options.dart';

abstract class HttpService {
  Future<dynamic> sendHttpRequest(HttpClientAttributeOptions httpAttribOptions);
}
