import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/task_controller.dart';
import 'package:vet_pharma/controller/employee_management_controller.dart';
import 'package:vet_pharma/model/employee_management_reponse.dart';
import 'package:vet_pharma/model/save_task_request.dart';
import 'package:vet_pharma/model/task_list_response.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/utils/theme.dart';
import 'package:vet_pharma/widgets/appbar.dart';
import 'package:vet_pharma/widgets/cancel.dart';

class Task extends StatelessWidget {
  Task({super.key});

  final controller = Get.find<TaskController>();
  final formKey = GlobalKey<FormState>();

  TextEditingController employeeNameController = TextEditingController();
  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBars(context),
      body: Obx(() {
        return LoadingOverlay(
          isLoading: controller.isLoading.value,
          child: SingleChildScrollView(
              child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Get.dialog(addTaskForm());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                    color: Color(0xff596cff),
                                  ))),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Add Task',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff596cff),
                              ),
                            ),
                          )),
                      const SizedBox(height: 20.0),
                      taskListTable(),
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Get.dialog(addTaskForm());
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                  color: Color(0xff596cff),
                                ))),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Add Task',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xff596cff),
                            ),
                          ),
                        )),
                  ),
                  taskListTable(),
                ],
              );
            }
          })),
        );
      }),
    );
  }

  Widget taskListTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: Get.size.width,
          child: PaginatedDataTable(
            header: const Text(
              "Assigned Task List",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            source: MyDataSource(
                controller.taskList, controller.task.value.totalData ?? 0),
            initialFirstRowIndex: 0,
            rowsPerPage: controller.pageSize.value,
            showFirstLastButtons: true,
            onPageChanged: (newPage) async {
              await controller.loadMore();
            },
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'SN',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Employee Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Employee Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Assigned Task ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Added Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Status',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Action',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }

  Widget addTaskForm() {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xff596cff),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Add Task",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0)),
                CircleAvatar(
                    backgroundColor: const Color(0xff596cff),
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ))),
              ],
            ),
          ),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  Obx(() => DropdownButtonFormField<EmployeeDetails>(
                      value: controller.selectedEmployeeDetail.value,
                      onChanged: (EmployeeDetails? value) {
                        controller.selectedEmployeeDetail.value =
                            value ?? EmployeeDetails();
                      },
                      items: controller.employeeDetailList.map((value) {
                        return DropdownMenuItem<EmployeeDetails>(
                          value: value,
                          child: Text(
                            value.fullName ?? "",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      decoration: customInputDecoration())),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    // width: Get.size.width * 0.3,
                    child: TextFormField(
                        maxLines: 5,
                        maxLength: 6200,
                        controller: taskController,
                        // validator: (value) {},
                        decoration: customInputDecoration(
                          labelText: "Task",
                        )),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: SizedBox(
                      width: Get.size.width * 0.3,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (controller.isLoading.value == false) {
                                controller.isLoading.value = true;
                                SaveTaskRequest saveTaskRequest =
                                    SaveTaskRequest();
                                saveTaskRequest.id =
                                    controller.selectedEmployeeDetail.value.id;
                                saveTaskRequest.task = taskController.text;
                                var res =
                                    await controller.taskSave(saveTaskRequest);
                               Get.back();
                                 if (res != null) {
                                    Get.offAllNamed(Routes.ADD_TASK);
                                }
                                formKey.currentState!.reset();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff596cff),
                          ),
                          child: const Text(
                            "Add Task",
                            style: TextStyle(fontSize: 18.0),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      } else {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xff596cff),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Add Task",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0)),
                CircleAvatar(
                    backgroundColor: const Color(0xff596cff),
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ))),
              ],
            ),
          ),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  Obx(() => DropdownButtonFormField<EmployeeDetails>(
                      value: controller.selectedEmployeeDetail.value,
                      onChanged: (EmployeeDetails? value) {
                        controller.selectedEmployeeDetail.value =
                            value ?? EmployeeDetails();
                      },
                      items: controller.employeeDetailList.map((value) {
                        return DropdownMenuItem<EmployeeDetails>(
                          value: value,
                          child: Text(
                            value.fullName ?? "",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      decoration: customInputDecoration())),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    // width: Get.size.width * 0.3,
                    child: TextFormField(
                        controller: taskController,
                        maxLines: 5,
                        maxLength: 6200,
                        decoration: customInputDecoration(
                          labelText: "Task",
                        )),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: SizedBox(
                      // width: Get.size.width * 0.3,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (controller.isLoading.value == false) {
                                controller.isLoading.value = true;
                                SaveTaskRequest saveTaskRequest =
                                    SaveTaskRequest();
                                saveTaskRequest.id =
                                    controller.selectedEmployeeDetail.value.id;
                                saveTaskRequest.task = taskController.text;
                                var res =
                                    await controller.taskSave(saveTaskRequest);
                                      Get.back();
                                if (res != null) {
                                
                                  Get.offAllNamed(Routes.ADD_TASK);
                                }
                                formKey.currentState!.reset();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff596cff),
                          ),
                          child: const Text(
                            "Add Task",
                            style: TextStyle(fontSize: 18.0),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}

class MyDataSource extends DataTableSource {
  final List<TaskList> tasklist;
  final int totalData;

  MyDataSource(
    this.tasklist,
    this.totalData,
  );

  TaskController controller = Get.find<TaskController>();

  @override
  DataRow? getRow(int index) {
    if (index >= tasklist.length) {
      return null;
    }
    return DataRow(
      cells: <DataCell>[
        DataCell(Text('${index + 1}')),
        DataCell(SizedBox(
          // width: Get.width * 0.15,
          child: Text(
            tasklist[index].employeeName ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )),
        DataCell(SizedBox(
          // width: Get.width * 0.15,
          child: Text(
            tasklist[index].employeeEmail ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )),
        DataCell(
          SizedBox(
              width: Get.size.width * 0.15,
              child: InkWell(
                onTap: () {
                  Get.dialog(task(controller.taskList[index].task ?? ""));
                },
                child: Text(
                  // controller.checkInOut[index].checkoutDescription ??
                  tasklist[index].task ?? "",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
        ),
        DataCell(
          Text(
            tasklist[index].addedDateTime ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        DataCell(taskStatus(index)),
        DataCell(controller.taskList[index].status != 'CANCELLED'
            ? Row(
                children: [
                  InkWell(
                    onTap: () async {
                      Get.dialog(askConfirmation(
                          "Are you sure you want to cancel task ?",
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("No")),
                          TextButton(
                              onPressed: () async {
                                controller.isLoading.value = true;
                                var getStatus = "CANCELLED";
                                var getStatusId = controller.taskList[index].id;
                                var res = await controller.updateTasks(
                                    getStatus, getStatusId!);
                                Get.back();
                                if (res != null) {
                                  await controller.initData();
                                }
                                controller.isLoading.value = false;
                              },
                              child: const Text("Yes"))));
                    },
                    child: Container(
                        // height: 6.0,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(18.0)),
                        child: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 14.0,
                        )),
                  ),
                  const SizedBox(width: 5.0),
                  if (controller.taskList[index].status == 'COMPLETED')
                    InkWell(
                      onTap: () async {
                      Get.dialog(askConfirmation(
                          "Are you sure you want to approve task ?",
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("No")),
                          TextButton(
                              onPressed: () async {
                                controller.isLoading.value = true;
                        var getStatus = "APPROVED";
                        var getStatusId = controller.taskList[index].id;
                        var res =await controller.updateTasks(getStatus, getStatusId!);
                        Get.back(); 
                                if (res != null) {
                                  controller.initData();
                        controller.isLoading.value = false;
                                }
                                controller.isLoading.value = false;
                              },
                              child: const Text("Yes"))));
                    },
                      // onTap: () async {
                      // },
                      child: Container(
                          // height: 6.0,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(18.0)),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 14.0,
                          )
                          // const Text(
                          //   "Approve",
                          //   style: TextStyle(fontSize: 13.0, color: Colors.white),
                          // ),
                          ),
                    )
                ],
              )
            : const Text("")),
      ],
    );
  }

  @override
  int get rowCount {
    return totalData;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  final formKey = GlobalKey<FormState>();

  Widget task(String task) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      title: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Color(0xff596cff),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Assigned Task",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 18.0)),
            CircleAvatar(
                backgroundColor: const Color(0xff596cff),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ))),
          ],
        ),
      ),
      content:  SizedBox(
             width: Get.size.width * 0.2,
            height:  Get.size.height * 0.15,
            child: SingleChildScrollView( scrollDirection: Axis.vertical,child: Text(task))),
      
    );
  }

  Widget taskStatus(int index) {
    if (tasklist[index].status == "ASSIGNED") {
      return InkWell(
        onTap: () async {},
        child: Container(
          // height: 6.0,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(18.0)),
          child: const Text(
            "ASSIGNED",
            style: TextStyle(fontSize: 13.0, color: Colors.white),
          ),
        ),
      );
    } else if (tasklist[index].status == "COMPLETED") {
      return InkWell(
        onTap: () async {},
        child: Container(
          // height: 6.0,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color:
                  // (customerLists[index].isActive ?? false)?
                  Colors.green,
              //     : Colors.red,
              borderRadius: BorderRadius.circular(18.0)),
          child: const Text(
            "COMPLETED",
            // (customerLists[index].isActive ?? false) ?
            //  "Active" : "InActive",
            style: TextStyle(fontSize: 13.0, color: Colors.white),
          ),
        ),
      );
    } else if (tasklist[index].status == "CANCELLED") {
      return InkWell(
        onTap: () async {},
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(18.0)),
          child: const Text(
            "CANCELLED",
            style: TextStyle(fontSize: 13.0, color: Colors.white),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () async {},
        child: Container(
          // height: 6.0,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: const Color(0xff596cff),
              borderRadius: BorderRadius.circular(18.0)),
          child: const Text(
            "APPROVED",
            // (customerLists[index].isActive ?? false) ?
            //  "Active" : "InActive",
            style: TextStyle(fontSize: 13.0, color: Colors.white),
          ),
        ),
      );
    }
  }
}
