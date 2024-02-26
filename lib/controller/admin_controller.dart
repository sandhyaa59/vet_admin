
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vet_pharma/model/adminList_response.dart';
import 'package:vet_pharma/model/admin_add_request.dart';
import 'package:vet_pharma/model/update_admin_request.dart';
import 'package:vet_pharma/model/view_admin_response.dart';
import 'package:vet_pharma/services/admin_service.dart';

class AdminController extends GetxController {
  var isActive = false.obs;
  var isVisible=true.obs;
  var isLoading = false.obs;
  var adminList = AdminListResponse().obs;
  var isDeleted = false.obs;
  var viewAdminResponse = ViewAdminResponse().obs;
  var selectedAdmin=<Datum>[].obs;

  var  addAdmin=false.obs;


 TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController mobileNumberController = TextEditingController();
TextEditingController passwordController = TextEditingController();
  @override
  void onInit() {
   
    super.onInit();
    initData();
  }

  initData() async {
    await getAdminList();
  }

  Future<dynamic> getAdminList() async {
    try {
      isLoading.value = true;
      adminList.value = await AdminService.getAllAdmin();
            selectedAdmin.value=adminList.value.data??[];

    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> deactivate(int id) async {
    try {
      isLoading.value = true;
      return AdminService.deactivateAdmin(id);
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> activate(int id) async {
    try {
      isLoading.value = true;
      return AdminService.activateAdmin(id);
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> delete(int id) async {
    try {
      isLoading.value = true;
      return AdminService.deleteAdmin(id);
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> viewAdmin(int id) async {
    try {
       isLoading.value = true;
      viewAdminResponse.value = await AdminService.viewAdminDetails(id);
   
      return viewAdminResponse;
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> adminSearch(String keyword) async {
    try {
      isLoading.value = true;
      return AdminService.searchAdmin(keyword);
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

 Future<dynamic> saveAdmin(AdminAddRequest addRequest)async{
    try {
      isLoading.value=true;
      var res= await AdminService.addAdmins(addRequest);
      isLoading.value=false;
      return res;
    } catch (e) {
      isLoading.value=false;
    }finally
    {
      isLoading.value=false;
    }

  }




  Future<dynamic> getUpdateAdmin(UpdateAdminRequest updateAdminRequest)async{
  try{
    isLoading.value=true;
   var res= await AdminService.updateAdmin(updateAdminRequest);
isLoading.value=false;
return res;
  }
  catch(e){
isLoading.value=false;
  }
  }

}