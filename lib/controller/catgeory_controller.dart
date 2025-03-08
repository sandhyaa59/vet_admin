import 'package:get/get.dart';
import 'package:vet_pharma/model/category.dart';
import 'package:vet_pharma/model/category_list_response.dart';
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/services/category_service.dart';

class CategoryController extends GetxController {
  var isLoading = false.obs;
  // var categories = <CategoryResponse>[].obs;
  // var selectedCategory = <CategoryResponse>[].obs;
  // var parentCategory=CategoryResponse().obs;

  var currentPage = 1.obs;
  var pageSize = 15.obs;
  final CategoryService categoryService = CategoryService();

  var categoryList = CategoryResponse().obs;
  var dataList = <CategoryData>[].obs;
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() async {
    try {
      isLoading.value = true;
      PaginationRequest request = preparePagination();
      dataList.clear();

      categoryList.value = await CategoryService.fetchCategories(request);
      dataList.value = categoryList.value.data ?? [];

      update();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  loadMoreData() async {
    try {
      isLoading.value = true;
      currentPage++;
      if (categoryList.value.hasNext == true) {
        PaginationRequest request = preparePagination();
        categoryList.value = await CategoryService.fetchCategories(request);
        // bill.value = billResponse.value.data ?? [];
        dataList.addAll(categoryList.value.data ?? []);
      }

      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
    }
  }

  PaginationRequest preparePagination() {
    PaginationRequest request = PaginationRequest();
    request.page = currentPage.value;
    request.pageSize = pageSize.value;
    return request;
  }

  //  fetchCategories() async {
  //   try {
  //     isLoading(true);
  //      selectedCategory.value = await categoryService.fetchCategories();
  //     if (selectedCategory.isNotEmpty) {
  //       categories.value = selectedCategory;
  //       parentCategory.value=selectedCategory.first;

  //     }

  //   } catch (e) {
  //     print('Error fetching categories: $e');
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future<dynamic> addCategory(CategoryRequest catgeory) async {
    try {
      isLoading.value = true;
      var res = await categoryService.addCategory(catgeory);
      isLoading.value = false;
      return res;
    } catch (e) {
      print('Error adding category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> activateCategory(int id) async {
    try {
      isLoading.value = true;
      await CategoryService.activateCategory(id);
      isLoading.value = false;
      update();
      return "success";
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<dynamic> deactivate(int id) async {
    try {
      isLoading.value = true;
      await CategoryService.deactivateCategory(id);
      update();
      isLoading.value = false;
      return "success";
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<dynamic> updateCategory(categoryUpdate) async {
    try {
      isLoading.value = true;
      var result = await CategoryService.updateCategory(categoryUpdate);
      isLoading.value = false;
      return result;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
