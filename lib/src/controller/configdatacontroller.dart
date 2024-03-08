import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';

import '../model/configs/configs.dart';
import '../services/cachingservice.dart';
import '../services/http_client/http_service.dart';
import '../services/http_exeption_handler/http_exception_handler.dart';
import '../services/configservice.dart';
import '../utils/Strings.dart';
import '../utils/api_state_handler.dart';

class MasterDataController extends GetxController {
  var httpService = Get.find<HttpService>();
  CacheStorageService cacheStorageService = CacheStorageService();
  Configs? configs;
  final apiStateHandler = ApiStateHandler<Configs>();

  //get master data from API
  Future getMasterData() async {
    try {
      dynamic response =
          await httpService.sendHttpRequest(ConfigsHttpAttributes());
      final result = jsonDecode(response.body);
      //caching the data
      cacheStorageService.saveData(Strings.configsCacheKey, result);
      update();
    } on HttpException catch (ex) {
      HandleHttpException().getExceptionString(ex);
    }
  }

  //read master data from cache
  Future readMasterData() async {
    apiStateHandler.setLoading();
    try {
      dynamic cachedData =
          await cacheStorageService.getSavedData(Strings.configsCacheKey);

      if (cachedData != null) {
        configs = Configs.fromJson(cachedData);
        // Update state with success and response data
        apiStateHandler.setSuccess(configs!);
        update();
      }
    } catch (error) {
      // Update state with error message
      apiStateHandler.setError(error.toString());
      update();
    }
  }
}
