import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/report_controller.dart';
import 'package:vet_pharma/model/employee_management_reponse.dart';
import 'package:vet_pharma/model/report_response.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/widgets/appbar.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  final controller = Get.find<ReportController>();

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
                    child: reportTable(),
                  ));
            } else {
              return Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(kPadding),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Report ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff36082B6),
                                  fontSize: 18.0),
                            ),
                            Obx(() {
                              return Flexible(
                                child: DropdownButton<EmployeeDetails>(
                                  value: controller.selectedEmployee.value,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (EmployeeDetails? value) {
                                    controller.selectedEmployee.value =
                                        value ?? EmployeeDetails();
                                    controller.getSelectedEmployee(
                                        controller.selectedEmployee.value.id!);
                                  },
                                  items: controller.employee.map((value) {
                                    return DropdownMenuItem<EmployeeDetails>(
                                      value: value,
                                      child: Text(
                                        value.fullName ?? "",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 2.0,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)),
                            child: reportTable(),
                          ),
                        ),
                      ],
                    ),
                  ));
            }
          })),
        );
      }),
    );
  }

  Widget reportTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Report ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff36082B6),
                      fontSize: 18.0),
                ),
                SizedBox(width: 30.0),
                Obx(() {
                  return Align(
                    alignment: Alignment.topRight,
                    child: DropdownButton<EmployeeDetails>(
                      value: controller.selectedEmployee.value,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (EmployeeDetails? value) {
                        controller.selectedEmployee.value =
                            value ?? EmployeeDetails();
                        controller.getSelectedEmployee(
                            controller.selectedEmployee.value.id!);
                      },
                      items: controller.employee.map((value) {
                        return DropdownMenuItem<EmployeeDetails>(
                          value: value,
                          child: Text(
                            value.fullName ?? "",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 20.0),
            SizedBox(
                width: Get.size.width,
                child: PaginatedDataTable(
                  // header: const Text("Employee"),
                  source: MyDataSource(controller.report,
                      controller.reportList.value.totalData ?? 0),
                  initialFirstRowIndex: 0,
                  rowsPerPage: controller.pageSize.value,
                  // showFirstLastButtons: true,
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
                        'Customer',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Date Time',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Location',
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
              ),
            
          ],
        ));
  }
}

class MyDataSource extends DataTableSource {
  final List<Report> report;
  final int totalData;

  MyDataSource(
    this.report,
    this.totalData,
  );
  ReportController controller = ReportController();

  @override
  DataRow? getRow(int index) {
    if (index >= report.length) {
      return null;
    }
    return DataRow(
      cells: <DataCell>[
        DataCell(
            Align(alignment: Alignment.center, child: Text('${index + 1}'))),
        DataCell(Align(
            alignment: Alignment.center,
            child: Text(report[index].employeeName ?? ""))),
        DataCell(Align(
            alignment: Alignment.center,
            child: Text(report[index].customerName ?? ""))),
        DataCell(
          Align(
              alignment: Alignment.center,
              child: Text(report[index].description ?? "")),
        ),
        DataCell(Align(
            alignment: Alignment.center,
            child: Text(report[index].addedDateTime ?? ""))),
        DataCell(Align(
            alignment: Alignment.center,
            child: Text(report[index].address ?? ""))),
        DataCell(
          Align(
              alignment: Alignment.center,
              child: IconButton(
                  onPressed: () {
                    controller.selectedReport.value = report[index];
                    Get.toNamed(Routes.REPORT_DETAILS);
                    controller.isLoading.value = false;
                  },
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Color(0xff596cff),
                  ))),
        )
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
}
