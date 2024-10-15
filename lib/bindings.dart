import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/article_controller.dart';
import 'package:rukiyah_and_ayat/features/audio/controllers/audio_controller.dart';
import 'package:rukiyah_and_ayat/controllers/category_controller.dart';
import 'package:rukiyah_and_ayat/controllers/data_controller.dart';
import 'package:rukiyah_and_ayat/controllers/hijama_controller.dart';
import 'package:rukiyah_and_ayat/controllers/keeper_controller.dart';
import 'package:rukiyah_and_ayat/controllers/masnun_dua_controller.dart';
import 'package:rukiyah_and_ayat/controllers/nirapottar_dua_controller.dart';
import 'package:rukiyah_and_ayat/controllers/network_controller.dart';
import 'package:rukiyah_and_ayat/controllers/storage_controller.dart';
import 'package:rukiyah_and_ayat/features/ayat/controllers/verses_controller.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    // Initialize NetworkController first
    Get.put(StorageController());
    Get.put(NetworkController());

    // Put DataController asynchronously and trigger the remaining controllers after DataController is ready
    Get.putAsync<DataController>(() async {
      final networkController = Get.find<NetworkController>();
      await networkController.getConnectionType();
      return DataController();
    }).then((dataController) {
      // Remaining controllers are initialized only after DataController is initialized
      Get.put(KeeperController());
      Get.put(CategoryController());
      Get.put(VersesController());
      Get.put(RuqyahController());
      Get.put(HijamaController());
      Get.put(MasnunDuaController());
      Get.put(NirapottarDuaController());
      Get.put(AudioController());
    });
  }
}
