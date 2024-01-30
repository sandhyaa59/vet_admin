import 'package:get/get.dart';
import 'package:vet_pharma/model/bill_details_response.dart';
import 'package:vet_pharma/services/bill_services.dart';

class PaymentDetailController extends GetxController{
  var isLoading=false.obs;

   var billDetails = BillDetailsResponse().obs;
   var billList=<BillOrderResponse>[].obs;
   @override
  void onInit() {
   
    super.onInit();
    initData();
  }

initData()async{
  try {
     isLoading.value=true;
       billDetails.value = await BillService.billDetails(Get.arguments);
       billList.value = billDetails.value.orderResponse!.responses ?? [];
isLoading.value=false;
  } catch (e) {
    isLoading.value=false;
  }
}
}