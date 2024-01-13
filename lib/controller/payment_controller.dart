import 'package:get/get.dart';

import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/model/payment_repsone.dart';
import 'package:vet_pharma/model/payment_save_request.dart';
import 'package:vet_pharma/services/payment_services.dart';

class PaymentController extends GetxController{
  var isLoading=false.obs;
  var paymentListRes=PaymentListResponse().obs;
  var paymentList=<PaymentList>[].obs;
  var selectedPayment=PaymentList().obs;
  var currentPage = 1.obs;
  var pageSize = 3.obs;

  @override
  void onInit() {

    super.onInit();
    paymentLists();
  }
  
  paymentLists()async{
    try {
      isLoading.value=true;
       PaginationRequest request = preparePagination();
      paymentListRes.value=await PaymentServices.getPaymentList(request);
      paymentList.value=paymentListRes.value.data??[];


      isLoading.value=false;
      
    } catch (e) {
      isLoading.value=false;
    }
  }

  loadMore() async {
      try {
        isLoading.value = true;
        PaginationRequest request = preparePagination();
        paymentListRes.value =
            await PaymentServices.getPaymentList(request);
        paymentList.addAll(paymentListRes.value.data ?? []);
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
      }
    }

  PaginationRequest preparePagination(){
PaginationRequest request=PaginationRequest();
request.page=currentPage.value;
request.pageSize=pageSize.value;
return request;
  }


Future<dynamic> savePayment(PaymentSaveRequest saveRequest)async{
    try {
       isLoading.value=true;
       return await PaymentServices.savePaymentList(saveRequest);
    } catch (e) {
      isLoading.value=false;
    }finally
    {
      isLoading.value=false;
    }
}
}