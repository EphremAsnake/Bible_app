
import 'package:bible_book_app/app/core/http_client/htttp_attrib_options.dart';

abstract class HttpService {
  Future<dynamic> sendHttpRequest(
      HttpClientAttributeOptions httpAttribOptions);
}