import 'package:bible_book_app/app/core/shared_controllers/master_data_controller.dart';
import 'package:get/get.dart';

class MasterDataHelper {
  MasterDataController controller = Get.find();
  getMasterData() async {
    try {
      await controller.readMasterData();
      if (controller.configs == null) {
        await controller.getMasterData();
      }
    } catch (ex) {}
  }
}
