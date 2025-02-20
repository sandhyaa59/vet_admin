
import 'package:get/get.dart';
import 'package:vet_pharma/model/category.dart';
import 'package:vet_pharma/model/category_list_response.dart';
import 'package:vet_pharma/services/category_service.dart';

class CategoryController extends GetxController {
  var isLoading = false.obs;
  var categories = <CategoryListResponse>[].obs;
  var selectedCategory = <CategoryListResponse>[].obs;
  var parentCategory=CategoryListResponse().obs;

  final CategoryService categoryService = CategoryService();

  @override
  void onInit() {
  
    super.onInit();
      fetchCategories();
  }

   fetchCategories() async {
    try {
      isLoading(true);
       selectedCategory.value = await categoryService.fetchCategories();
      if (selectedCategory.isNotEmpty) {
        categories.value = selectedCategory;
        parentCategory.value=selectedCategory.first;
        
      }
           

    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<dynamic> addCategory(CategoryRequest catgeory) async {
    try {
      isLoading.value=true;
      var res= await categoryService.addCategory(catgeory);
      isLoading.value=false;
       return res;
      
    } catch (e) {
      print('Error adding category: $e');
    } finally {
      isLoading.value=false;
    }
  }

  Future<dynamic> addSubCategory(String title, String description, int parentCategoryId) async {
    try {
      isLoading(true);
      await categoryService.addSubCategory(title, description, parentCategoryId);
      
       fetchCategories(); // Refresh the categories list
       
        // parentCategory.value = selectedCategory.first;
    } catch (e) {
      print('Error adding sub-category: $e');
    } finally {
      isLoading(false);
    }
  }




  Future<dynamic> activateCategory(int id)async{
    try {
      isLoading.value=true;
     await CategoryService.activateCategory(id);
     isLoading.value=false;
      update();
     return "success";
    } catch (e) {
       isLoading.value=false;
      
    }
  }

  Future <dynamic> deactivate(int id) async{
    try {
      isLoading.value=true;
       await CategoryService.deactivateCategory(id);
       update();
      isLoading.value=false;
     return "success";
    } catch (e) {
        isLoading.value=false;
    }
  }


  Future<dynamic> updateCategory( categoryUpdate)async{
  try{
    isLoading.value=true;
var result=await CategoryService.updateCategory(categoryUpdate);
 isLoading.value=false;
 return result;
  }
  catch(e){
isLoading.value=false;
  }
  }
}
