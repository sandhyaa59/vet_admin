import 'package:get/get.dart';
import 'package:vet_pharma/controller/report_controller.dart';
import 'package:vet_pharma/model/employee_management_reponse.dart';
import 'package:vet_pharma/model/pagination_request.dart';

import 'package:vet_pharma/model/save_task_request.dart';
import 'package:vet_pharma/model/task_list_response.dart';
import 'package:vet_pharma/services/employee_management_services.dart';

import 'package:vet_pharma/services/task_services.dart';

class TaskController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
  }

  var isLoading = false.obs;
  var currentPage = 1.obs;
  var pageSize = 15.obs;
  final reportController = ReportController();
  var employee = <EmployeeDetails>[].obs;
  var employeeDetailList = <EmployeeDetails>[].obs;
  var selectedEmployeeDetail = EmployeeDetails().obs;

  var task = TaskListResponse().obs;
  var taskList = <TaskList>[].obs;

  Future initData() async {
    try {
      isLoading.value = true;
      PaginationRequest request = preparePagination();
      task.value = await TaskServices.taskList(request);
      taskList.value = task.value.data ?? [];

      employeeDetailList.value =
          await EmployeeManagementServices.getActiveEmployee();
      if (employeeDetailList.isNotEmpty) {
        selectedEmployeeDetail.value = employeeDetailList.first;
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  loadMore() async {
    try {
      isLoading.value = true;
      PaginationRequest request = preparePagination();
      task.value = await TaskServices.taskList(request);
      taskList.addAll(task.value.data ?? []);
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

  Future<dynamic> taskSave(SaveTaskRequest saveRequest) async {
    try {
      isLoading.value = true;
      var res = await TaskServices.saveTask(saveRequest);
      isLoading.value = false;
      return res;
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> updateTasks(String status, int id) async {
    try {
      isLoading.value = true;
      var res = await TaskServices.updateTask(status, id);
      isLoading.value = false;
      return res;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
