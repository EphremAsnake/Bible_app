import 'package:bible_book_app/app/core/http_client/http_service.dart';
import 'package:bible_book_app/app/core/http_client/http_service_impl.dart';
import 'package:bible_book_app/app/core/shared_controllers/master_data_controller.dart';
import 'package:get/get.dart';

class CoreDependencyCreator {
  static init() {
    Get.put<HttpService>(HttpServiceImpl());
    //injecting master data(configs)
    Get.lazyPut<MasterDataController>(() => MasterDataController());
  }
}
