import 'package:bible_book_app/app/core/http_client/htttp_attrib_options.dart';
import 'package:bible_book_app/app/utils/keys/keys.dart';

class BibleHttpAttributes extends HttpClientAttributeOptions {
  BibleHttpAttributes()
      : super(
          baseUrl: Keys.baseurl,
          url: "/bibles/bible_list.json",
          connectionTimeout: 30,
          contentType: 'application/json',
          method: HttpMethod.GET,
          retries: 3,
          isAuthorizationRequired: false,
        );
}
