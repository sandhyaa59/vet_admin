import 'package:get/get.dart';
import 'package:vet_pharma/model/employee_management_reponse.dart';
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/model/report_response.dart';
import 'package:vet_pharma/services/employee_management_services.dart';
import 'package:vet_pharma/services/report_service.dart';

class ReportController extends GetxController {
  var isLoading = false.obs;
  var reportList = ReportResponse().obs;
  var report = <Report>[].obs;
  var selectedData = Report().obs;
  var currentPage = 1.obs;
  var pageSize = 15.obs;
  var employee = <EmployeeDetails>[].obs;
  var selectedEmployee = EmployeeDetails().obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() async {
    try {
      isLoading.value = true;
      PaginationRequest request = preparePagination();
      reportList.value = await ReportService.reportList(request);
      report.value = reportList.value.data ?? [];
      selectedData.value=report.first;
      employee.value = await EmployeeManagementServices.getActiveEmployee();
      selectedEmployee.value = employee.first;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  loadMore() async {
    try {
      isLoading.value = true;
      PaginationRequest request = preparePagination();
      reportList.value = await ReportService.reportList(request);
      report.addAll(reportList.value.data ?? []);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<dynamic> getSelectedEmployee(int id) async {
    try {
      isLoading.value = true;
      reportList.value = await ReportService.reportListByEmployee(id);
      report.value = reportList.value.data ?? [];
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
}
