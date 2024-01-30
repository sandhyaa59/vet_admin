import 'package:get/get.dart';
import 'package:vet_pharma/model/check_in_out_response.dart';
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/services/%20checkinout_service.dart';

class CheckInCheckOutController extends GetxController {
  var isLoading = false.obs;
  var checkInOutResponse = CheckInOutResponse().obs;
  var checkInOut = <CheckInOut>[].obs;
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
      checkInOutResponse.value =
          await CheckInOutService.checkinoutList(request);
      checkInOut.value = checkInOutResponse.value.data ?? [];
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
    
  }

  loadMore() async {
      try {
        isLoading.value = true;
        PaginationRequest request = preparePagination();
        checkInOutResponse.value =
            await CheckInOutService.checkinoutList(request);
        checkInOut.addAll(checkInOutResponse.value.data ?? []);
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
      }
    }

  PaginationRequest preparePagination() {
    PaginationRequest request = PaginationRequest();
    request.page = currentPage.value;
    request.pageSize = pageSize.value;
    request.sortParameter="checkoutAddedDateTime";
    return request;
  }
}
