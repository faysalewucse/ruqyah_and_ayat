import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/toast.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';
import 'package:rukiyah_and_ayat/services/verses_service.dart';

class VersesController extends GetxController {

  final getVersesByCategoryLoading = false.obs;

  Future<List<Verse>> getVersesByCategory({required String categoryId}) async {
    try{
      getVersesByCategoryLoading(true);
      final response = await VersesService.getVersesByCategory(categoryId: categoryId);

      List<Verse> responseVerses = [];
      for(var verse in response.data["verses"]){
        responseVerses.add(Verse.fromJson(verse));
      }

      return responseVerses;
    }
    catch(e){
      print(e);
      return [];
    }
    finally{
      getVersesByCategoryLoading(false);
    }
  }
}