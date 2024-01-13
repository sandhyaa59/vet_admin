import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/model/customer_add_request.dart';
import 'package:vet_pharma/model/customer_list_response.dart';
import 'package:vet_pharma/model/customer_update_request.dart';
import 'package:vet_pharma/services/customer_services.dart';

class CustomerController extends GetxController{
  
  var isLoading=false.obs;
var customerListResponse=CustomerListResponse().obs;
var customerList=<CustomerList>[].obs;
var selectedCustomerList=CustomerList().obs;

TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
    TextEditingController shopNameController = TextEditingController();

  @override
  void onInit() {
    
    super.onInit();
    initData();
  }

  initData()async{
try {
  isLoading.value=true;
  customerListResponse.value=await CustomerService.customerList();
  customerList.value=customerListResponse.value.data??[];
  isLoading.value=false;
} catch (e) {
  isLoading.value=false;
}
  }



  Future<dynamic> activateCustomers(int id)async{
    try {
      isLoading.value=true;
      return await CustomerService.activateCustomer(id);
    } catch (e) {
       isLoading.value=false;
      
    }
  }

  Future <dynamic> deactivateCustomers(int id) async{
    try {
      isLoading.value=true;
      return await CustomerService.deactivateCustomer(id);
    } catch (e) {
        isLoading.value=false;
    }
  }
   Future <dynamic> deleteCustomers(int id) async{
    try {
      isLoading.value=true;
      return await CustomerService.deleteCustomer(id);
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
return result;
    } catch (e) {
        isLoading.value=false;
    }
  }
}