import 'package:get/get.dart';
import 'package:vet_pharma/controller/billing_controller.dart';
import 'package:vet_pharma/model/order_response.dart';
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/services/order_service.dart';

class OrderController extends GetxController {
  var isLoading = false.obs;
  var orderResponse = OrderResponse().obs;
  var orderList = <Order>[].obs;
  var selectedOrder = Order().obs;
  final billingController = BillingController();
  var currentPage = 1.obs;
  var pageSize = 15.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() async {
    try {
      isLoading.value = true;
       PaginationRequest request = preparePagination();
      orderResponse.value = await OrderService.orderList(request);
      orderList.value = orderResponse.value.data ?? [];
      // if (orderList.isNotEmpty) {
      //   selectedOrder.value = orderList.first;
      // }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  loadMore() async {
      try {
        isLoading.value = true;
        PaginationRequest request = preparePagination();
        orderResponse.value =
            await OrderService.orderList(request);
        orderList.addAll(orderResponse.value.data ?? []);
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
      }
    }

  Future <dynamic> cancel(int id) async{
    try {
      isLoading.value=true;
      return await OrderService.orderCancel(id);
    } catch (e) {
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
