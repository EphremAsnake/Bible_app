import 'package:get/get.dart';

import '../controller/configdatacontroller.dart';

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
