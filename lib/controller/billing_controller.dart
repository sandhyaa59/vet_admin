import 'package:get/get.dart';
import 'package:vet_pharma/model/bill_repsonse.dart';
import 'package:vet_pharma/model/bill_save_response.dart';
import 'package:vet_pharma/model/pagination_request.dart';

import 'package:vet_pharma/services/bill_services.dart';

class BillingController extends GetxController {
  var isLoading = false.obs;
  var billResponse = BillResponse().obs;
  var bill = <Bill>[].obs;
  var billDetail = Bill().obs;
  var currentPage = 1.obs;
  var pageSize = 3.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() async {
    try {
      isLoading.value = true;
      PaginationRequest request = preparePagination();
      billResponse.value = await BillService.billList(request);
      bill.value = billResponse.value.data ?? [];

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  loadMoreData() async {
    try {
      isLoading.value = true;
      currentPage++;
      if (billResponse.value.hasNext == true) {
        PaginationRequest request = preparePagination();
        billResponse.value = await BillService.billList(request);
        // bill.value = billResponse.value.data ?? [];
        bill.addAll(billResponse.value.data ?? []);
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

  Future<dynamic> saveBill(BillAddRequest addRequest) async {
    try {
      isLoading.value = true;
      var result = await BillService.addBill(addRequest);
      print(result);
      isLoading.value = false;
      return result;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
