import 'package:american_bible/app/core/http_client/htttp_attrib_options.dart';
import 'package:american_bible/app/utils/keys/keys.dart';

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
