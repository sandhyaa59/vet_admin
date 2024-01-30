import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/model/customer_add_request.dart';
import 'package:vet_pharma/model/customer_list_response.dart';
import 'package:vet_pharma/model/customer_update_request.dart';
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/services/customer_services.dart';

class CustomerController extends GetxController{
  
  var isLoading=false.obs;
var customerListResponse=CustomerListResponse().obs;
var customerList=<CustomerList>[].obs;
var selectedCustomerList=CustomerList().obs;
var currentPage = 1.obs;
  var pageSize = 15.obs;

TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
    TextEditingController shopNameController = TextEditingController();
      TextEditingController panNumberController = TextEditingController();

  @override
  void onInit() {
    
    super.onInit();
    initData();
  }

  initData()async{
try {
  isLoading.value=true;
   PaginationRequest request = preparePagination();
  customerListResponse.value=await CustomerService.customerList(request);
  customerList.value=customerListResponse.value.data??[];
  isLoading.value=false;
} catch (e) {
  isLoading.value=false;
}
  }

  loadMoreData() async {
    try {
      isLoading.value = true;
      currentPage++;
      if (customerListResponse.value.hasNext == true) {
        PaginationRequest request = preparePagination();
        customerListResponse.value = await CustomerService.customerList(request);
        // bill.value = billResponse.value.data ?? [];
        customerList.addAll(customerListResponse.value.data ?? []);
      }

      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
    }
  }



  Future<dynamic> activateCustomers(int id)async{
    try {
      isLoading.value=true;
      var res= await CustomerService.activateCustomer(id);
      isLoading.value=false;
      update();
      return res;
    } catch (e) {
       isLoading.value=false;
    }
  }

PaginationRequest preparePagination() {
    PaginationRequest request = PaginationRequest();
    request.page = currentPage.value;
    request.pageSize = pageSize.value;
    return request;
  }
  Future <dynamic> deactivateCustomers(int id) async{
    try {
      isLoading.value=true;
     var res=await CustomerService.deactivateCustomer(id);
      isLoading.value=false;
      update();
      return res;
    } catch (e) {
        isLoading.value=false;
    }
  }
   Future <dynamic> deleteCustomers(int id) async{
    try {
      isLoading.value=true;
      var res= await CustomerService.deleteCustomer(id);
      isLoading.value=false;
      update();
      return res;
    } catch (e) {
        isLoading.value=false;
    }
  }

  Future <dynamic> addCustomers(CustomerAddRequest customerAddRequest) async{
    try {
      isLoading.value=true;
   var result=await CustomerService.addCustomer(customerAddRequest);
     isLoading.value=false;
return result;
    } catch (e) {
        isLoading.value=false;
    }
  }


  Future <dynamic> updateCustomers(CustomerUpdateRequest customerUpdateRequest) async{
    try {
      isLoading.value=true;
   var result=await CustomerService.updateCustomer(customerUpdateRequest);
     isLoading.value=false;
     update();
return result;
    } catch (e) {
        isLoading.value=false;
    }
  }
}