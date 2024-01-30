import 'package:get/get.dart';

import 'package:vet_pharma/model/organization_detail_response.dart';

import 'package:vet_pharma/services/organization_services.dart';

class OrganizationController extends GetxController{

  var isLoading=false.obs;
  var organizationDetail=OrganizationDetailResponse().obs;

  @override
  void onInit() {
    super.onInit();
    organizationLists();
  }

  organizationLists()async{
    try {
      isLoading.value=true;
  organizationDetail.value= await  OrganizationServices.getOrganizationList();
isLoading.value=false;
  return organizationDetail.value;
    
    } catch (e) {
      isLoading.value=false;
    }
  }
   
}