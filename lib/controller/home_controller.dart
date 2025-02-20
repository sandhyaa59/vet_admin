import 'package:get/get.dart';
import 'package:vet_pharma/model/check_in_out_response.dart';
import 'package:vet_pharma/model/order_response.dart';
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/model/report_stat_response.dart';
import 'package:vet_pharma/services/%20checkinout_service.dart';
import 'package:vet_pharma/services/order_service.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var checkInOutResponse = CheckInOutResponse().obs;
  var checkInOut = <CheckInOut>[].obs;
  var orderResponse = OrderResponse().obs;
  var orderList = <Order>[].obs;
  var mostorderList = <MostOrderedItem>[].obs;
  var reportStat = ReportStatResponse().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
  }

  initData() async {
    try {
      isLoading.value = true;
      PaginationRequest request = preparePagination();
      checkInOutResponse.value =
          await CheckInOutService.checkinoutList(request);
      orderResponse.value = await OrderService.orderList(request);
      checkInOut.addAll(checkInOutResponse.value.data ?? []);
      orderList.value = orderResponse.value.data ?? [];
      mostorderList.value = reportStat.value.mostOrderedItems ?? [];
      await fetchReportStat(DateTime.now().toIso8601String().split('T')[0], DateTime.now().toIso8601String().split('T')[0]);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  PaginationRequest preparePagination() {
    PaginationRequest request = PaginationRequest();
    request.page = 1;
    request.pageSize = 10;
    return request;
  }

  Future<void> fetchReportStat(String from,
  String end) async {
    isLoading(true);
    try {
      // Hit the API
      final response = await OrderService.getOrderReport(from, end);
      
      if (response!=null) {
        
        reportStat.value = reportStatResponseFromJson(response);
      } else {
        Get.snackbar("Error", "Failed to load report stats.");
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error", "Failed to load data. Please try again.");
    } finally {
      isLoading(false);
    }
  }
}
