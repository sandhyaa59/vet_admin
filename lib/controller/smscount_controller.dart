import 'package:get/get.dart';
import 'package:vet_pharma/model/customer_list_response.dart';
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/model/sms_Count_request.dart';
import 'package:vet_pharma/services/customer_services.dart';
import 'package:vet_pharma/services/sms_count_services.dart';

class SmsNotificationCountController extends GetxController {
  var isLoading = false.obs;
  var mobileNumber = SmsCountRequest().obs;
  var customerListResponse = CustomerListResponse().obs;
  var customerList = <CustomerList>[].obs;
  var currentPage = 1.obs;
  var pageSize = 20.obs;
  var selectedCustomer = <CustomerList>[].obs;

  @override
  void onInit() {
    super.onInit();
    getInitData();
  }

  getInitData() async {
    try {
      isLoading.value = true;
      PaginationRequest request = preparePagination();
      customerListResponse.value = await CustomerService.customerList(request);
      if((customerListResponse.value.data??[]).isNotEmpty){
    customerList.value=customerListResponse.value.data??[];
  }
      customerList.value = customerListResponse.value.data ?? [];
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  loadMoreData() async {
    try {
      isLoading.value = true;
      currentPage++;
      if (customerListResponse.value.hasNext == true) {
        PaginationRequest request = preparePagination();
        customerListResponse.value =
            await CustomerService.customerList(request);
        // bill.value = billResponse.value.data ?? [];
        customerList.addAll(customerListResponse.value.data ?? []);
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

  Future<dynamic> sendSms(SmsCountRequest request) async {
    try {
      isLoading.value = true;
      var res = await SmsCountServices.sendSms(request);
      isLoading.value = false;
      return res;
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> customerSearch(String keyword) async {
    try {
      isLoading.value = true;
    customerListResponse.value =
          await SmsCountServices.searchCustomer(keyword);
      if ((customerListResponse.value.data ?? []).isNotEmpty) {
        customerList.value = customerListResponse.value.data ?? [];
      }
      isLoading.value = false;
      update();
      return customerList;
    } catch (e) {
      isLoading.value = false;
    }
  }
}