import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/keeper_controller.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(KeeperController());
  }
}
