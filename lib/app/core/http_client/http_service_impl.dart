import 'package:american_bible/app/core/http_client/http_service.dart';
import 'package:american_bible/app/core/http_client/htttp_attrib_options.dart';
import 'package:american_bible/app/core/http_client/process_http_request.dart';
import 'package:american_bible/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:american_bible/app/utils/shared_widgets/snack_bar.dart';
import 'package:dio/dio.dart';

class HttpServiceImpl implements HttpService {
  @override
  Future<dynamic> sendHttpRequest(
      HttpClientAttributeOptions httpAttribOptions) async {
    try {
      //instantiating response object
      Response<dynamic>? response;
      //instantiating http processor class
      ProcessHttpRequest processHttpRequest = ProcessHttpRequest();

      switch (httpAttribOptions.method) {
        case HttpMethod.GET:
          response =
              await processHttpRequest.processGetRequest(httpAttribOptions);
          if (response.statusCode == 200) {
            return response;
          }
          break;
        default:
          break;
      }
    } on Exception catch (e) {
      String message = await HandleHttpException().getExceptionString(e);
      customSnackBar(title: 'Error', body: message);
    }
    return null;
  }
}
