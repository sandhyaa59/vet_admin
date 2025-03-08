import 'package:get/get.dart';
import 'package:vet_pharma/model/catgeory_list.dart';
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/model/product_list_response.dart';
import 'package:vet_pharma/model/productadd_request.dart';
import 'package:vet_pharma/services/category_service.dart';
import 'package:vet_pharma/services/product_service.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  // var categories = <Category>[].obs;
  var products = <ProductListResponse>[].obs;
  var isActive = false.obs;
  var currentPage = 1.obs;
  var pageSize = 15.obs;
  var productList = ProductListResponse().obs;
  var dataList = <Datum>[].obs;
  var selectedProduct = Datum().obs;
  ProductService productService = ProductService();

  var category = <CategoryLists>[].obs;
  var selectedCategory = CategoryLists().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
  }

  initData() async {
    try {
      isLoading.value = true;
      PaginationRequest request = preparePagination();
      dataList.clear();

      productList.value = await ProductService.getProductList(request);
      dataList.value = productList.value.data ?? [];

      update();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  fetchCategory() async {
    category.value = await CategoryService().fetchCategoriesOnly();
    if (category.isNotEmpty) {
      selectedCategory.value = category.first;
    }
  }

  saveProducts(ProductAddRequest addRequest) async {
    try {
      isLoading.value = true;
      var res = await productService.addProduct(addRequest);
      isLoading.value = false;
      return res;
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  PaginationRequest preparePagination() {
    PaginationRequest request = PaginationRequest();
    request.page = currentPage.value;
    request.pageSize = pageSize.value;
    return request;
  }

  Future<dynamic> updateProduct(productUpdateRequest) async {
    try {
      isLoading.value = true;
      var result = await ProductService.updateProduct(productUpdateRequest);
      isLoading.value = false;
      return result;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<dynamic> activate(int id) async {
    try {
      isLoading.value = true;
      await ProductService.activateProduct(id);
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
      await ProductService.deactivateProduct(id);
      update();
      isLoading.value = false;
      return "success";
    } catch (e) {
      isLoading.value = false;
    }
  }
}
