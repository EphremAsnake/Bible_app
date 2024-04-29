import 'dart:convert';
import 'dart:io';
import 'package:american_bible/app/core/cache/local_storage.dart';
import 'package:american_bible/app/core/http_client/http_service.dart';
import 'package:american_bible/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:american_bible/app/core/shared_controllers/master_data_http_attribuites.dart';
import 'package:american_bible/app/data/models/configs/configs.dart';
import 'package:american_bible/app/utils/helpers/api_state_handler.dart';
import 'package:american_bible/app/utils/keys/keys.dart';
import 'package:get/get.dart';

class MasterDataController extends GetxController {
  var httpService = Get.find<HttpService>();
  CacheStorageService cacheStorageService = CacheStorageService();
  Configs? configs;
  final apiStateHandler = ApiStateHandler<Configs>();

  //get master data from API
  Future getMasterData() async {
    try {
      dynamic response =
          await httpService.sendHttpRequest(MasterDataHttpAttributes());
      final result = jsonDecode(response.body);
      //caching the data
      cacheStorageService.saveData(Keys.configsCacheKey, result);
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
          await cacheStorageService.getSavedData(Keys.configsCacheKey);

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
