import 'package:get/get.dart';
import 'package:vet_pharma/model/bill_details_response.dart';
import 'package:vet_pharma/model/bill_repsonse.dart';

import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/model/payment_repsone.dart';
import 'package:vet_pharma/model/payment_save_request.dart';

import 'package:vet_pharma/services/payment_services.dart';

class PaymentController extends GetxController {
  var isLoading = false.obs;
  var paymentListRes = PaymentListResponse().obs;
  var paymentList = <PaymentList>[].obs;
  var selectedPaymentData = PaymentList().obs;
  var currentPage = 1.obs;
  var pageSize = 15.obs;
  var selectedPaymentMethod = 'Cash'.obs;
  var billDetails = BillDetailsResponse().obs;
  var bill = Bill().obs;
  var billList = <Bill>[].obs;
  var billResponse = BillResponse().obs;
  var selectedBill = Bill().obs;
  // var billList = <BillOrderResponse>[].obs;

// final billController=BillDetailsController();

  @override
  void onInit() {
    super.onInit();
    paymentLists();
  }

  paymentLists() async {
    try {
      isLoading.value = true;
      PaginationRequest request = preparePagination();
      paymentListRes.value = await PaymentServices.getPaymentList(request);
      paymentList.value = paymentListRes.value.data ?? [];
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  loadMore() async {
    try {
      isLoading.value = true;
      PaginationRequest request = preparePagination();
      paymentListRes.value = await PaymentServices.getPaymentList(request);
      paymentList.addAll(paymentListRes.value.data ?? []);

      isLoading.value = false;
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

  Future<dynamic> savePayment(PaymentSaveRequest saveRequest) async {
    try {
      isLoading.value = true;

      var res = await PaymentServices.savePaymentList(saveRequest);
      isLoading.value = false;
      return res;
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> billSearch(String keyword) async {
    try {
      isLoading.value = true;
      billList.value = await PaymentServices.searchBill(keyword);
      isLoading.value = false;
      return billList;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
