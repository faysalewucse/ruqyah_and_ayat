import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/toast.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';
import 'package:rukiyah_and_ayat/services/category_service.dart';

class CategoryController extends GetxController {

  final getCategoriesLoading = false.obs;
  final categories = <Category>[].obs;

  Future<void> getAllCategories({required int categoryIndex}) async {
    try{
      getCategoriesLoading(true);
      final response = await CategoryService.getAllCategories(categoryIndex: categoryIndex);

      List<Category> responseCategories = [];
      for(var category in response.data["categories"]){
        responseCategories.add(Category.fromJson(category));
      }
      categories(responseCategories);
    }
    catch(e){
      print(e);
    }
    finally{
      getCategoriesLoading(false);
    }
  }
}