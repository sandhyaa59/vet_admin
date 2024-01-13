

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/model/employee_add_request.dart';
import 'package:vet_pharma/model/employee_management_reponse.dart';
import 'package:vet_pharma/model/employee_update_request.dart';
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/services/employee_management_services.dart';

class EmployeeManagementController extends GetxController{
  
  var isLoading=false.obs;
  var isActive=false.obs;
  var currentPage = 1.obs;
  var pageSize = 3.obs;
  var employeeManagement=EmployeeManagementResponse().obs;
  var employeeDetailList=<EmployeeDetails>[].obs;
   var selectedEmployeeDetail=EmployeeDetails().obs;


 TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController mobileNumberController = TextEditingController();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
  }


  initData()async{
    try {
      isLoading.value=true;
       PaginationRequest request = preparePagination();
      employeeManagement.value=await EmployeeManagementServices.getEmployeeManagementList(request);
      employeeDetailList.value=employeeManagement.value.data??[];
      isLoading.value=false;
      
    } catch (e) {
      isLoading.value=false;
    }
  }

  loadMore() async {
      try {
        isLoading.value = true;
        PaginationRequest request = preparePagination();
        employeeManagement.value =
            await EmployeeManagementServices.getEmployeeManagementList(request);
        employeeDetailList.addAll(employeeManagement.value.data ?? []);
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
      }
    }
  

  Future<dynamic> activate(int id)async{
    try {
      isLoading.value=true;
      return await EmployeeManagementServices.activateEmployee(id);
    } catch (e) {
       isLoading.value=false;
      
    }
  }

  Future <dynamic> deactivate(int id) async{
    try {
      isLoading.value=true;
      return await EmployeeManagementServices.deactivateEmployee(id);
    } catch (e) {
        isLoading.value=false;
    }
  }


   Future <dynamic> delete(int id) async{
    try {
      isLoading.value=true;
      return await EmployeeManagementServices.deleteEmployee(id);
    } catch (e) {
        isLoading.value=false;
    }
  }


   Future<dynamic> saveEmployee(EmployeeAddRequest addRequest)async{
    try {
       isLoading.value=true;
       return await EmployeeManagementServices.addEmployee(addRequest);
    } catch (e) {
      isLoading.value=false;
    }finally
    {
      isLoading.value=false;
    }
}



  Future<dynamic> updateEmployee(EmployeeUpdateRequest employeeUpdateRequest)async{
  try{
    isLoading.value=true;
var result=await EmployeeManagementServices.updateEmployee(employeeUpdateRequest);
 isLoading.value=false;
 return result;
  }
  catch(e){
isLoading.value=false;
  }
  }
   PaginationRequest preparePagination(){
PaginationRequest request=PaginationRequest();
request.page=currentPage.value;
request.pageSize=pageSize.value;
return request;
  }
}