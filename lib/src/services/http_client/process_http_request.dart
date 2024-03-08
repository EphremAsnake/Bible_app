import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import 'htttp_attrib_options.dart';

class ProcessHttpRequest {
  Future<Response> processGetRequest(
      HttpClientAttributeOptions httpAttribOptions) async {
    String url = httpAttribOptions.baseUrl + httpAttribOptions.url;
    final Dio dio = Dio();
    DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
    Options catchOptions = buildCacheOptions(
      const Duration(days: 365),
      forceRefresh: true,
    );
    dio.interceptors.add(dioCacheManager.interceptor);
    return await dio
        .get(
          url,
          options: catchOptions,
        )
        .timeout(
          Duration(seconds: httpAttribOptions.connectionTimeout),
        );
  }
}
