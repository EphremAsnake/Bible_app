import 'package:american_bible/app/core/http_client/htttp_attrib_options.dart';
import 'package:american_bible/app/utils/keys/keys.dart';

class ConfigsHttpAttributes extends HttpClientAttributeOptions {
  ConfigsHttpAttributes()
      : super(
          baseUrl: Keys.baseurl,
          url: "/configs/configs.json",
          connectionTimeout: 30,
          contentType: 'application/json',
          method: HttpMethod.GET,
          retries: 3,
          isAuthorizationRequired: false,
        );
}
