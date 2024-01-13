import 'package:get/get.dart';
import 'package:vet_pharma/controller/payment_controller.dart';
import 'package:vet_pharma/model/bill_details_response.dart';
import 'package:vet_pharma/model/bill_repsonse.dart';
import 'package:vet_pharma/services/bill_services.dart';

class BillDetailsController extends GetxController {
  var isLoading = false.obs;
  var billDetails = BillDetailsResponse().obs;
  var billList = <BillOrderResponse>[].obs;
  var orderResponse = OrderResponse().obs;
  var orderListResponse = OrderResponse().obs;
  final paymentController = PaymentController();


  @override
  void onInit() {
    super.onInit();
    var id = Get.arguments;
    initData(id);
  }

  initData(int id) async {
    try {
      isLoading.value = true;
      billDetails.value = await BillService.billDetails(id);

      billList.value = billDetails.value.orderResponse!.responses ?? [];
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future <dynamic> cancel(int id) async{
    try {
      isLoading.value=true;
      return await BillService.billCancel(id);
    } catch (e) {
        isLoading.value=false;
    }
  }
}
