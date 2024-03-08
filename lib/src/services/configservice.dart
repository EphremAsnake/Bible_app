import 'package:holy_bible_app/src/utils/Strings.dart';

import 'http_client/htttp_attrib_options.dart';

class ConfigsHttpAttributes extends HttpClientAttributeOptions {
  ConfigsHttpAttributes()
      : super(
          baseUrl: Strings.baseurl,
          url: "/configs/configs.json",
          connectionTimeout: 30,
          contentType: 'application/json',
          method: HttpMethod.GET,
          retries: 3,
          isAuthorizationRequired: false,
        );
}
