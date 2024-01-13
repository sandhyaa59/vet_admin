import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/checkin_checkout_controller.dart';
import 'package:vet_pharma/model/check_in_out_response.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/widgets/appbar.dart';

class CheckInCheckOutScreen extends StatelessWidget {
  CheckInCheckOutScreen({super.key});

  final controller = Get.find<CheckInCheckOutController>();
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
                    alignment: Alignment.center, child: checkInCheckOutTable()),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Align(
                    alignment: Alignment.center, child: checkInCheckOutTable()),
              );
            }
          })),
        );
      }),
    );
  }

  Widget checkInCheckOutTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: Get.size.width,
          child: PaginatedDataTable(
            header: const Text(
              "CheckIn - Check Out",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            source: MyDataSource(controller.checkInOut,
                controller.checkInOutResponse.value.totalData ?? 0),
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
                  'CheckIn DateTime',
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
                  'CheckOut Time',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }
}

class MyDataSource extends DataTableSource {
  final List<CheckInOut> check;
  final int totalData;

  MyDataSource(
    this.check,
    this.totalData,
  );
  CheckInCheckOutController controller = CheckInCheckOutController();

  @override
  DataRow? getRow(int index) {
    if (index >= check.length) {
      return null;
    }
    return DataRow(
      cells: <DataCell>[
        DataCell(
         Text('${index + 1}')),
        
        DataCell(
          Text(check[index].employeeName ?? "")),
        
        DataCell(
          Text(check[index].checkInTime ?? "")),
        
        DataCell(
          Text(check[index].checkInDescription ?? "")),
 
        DataCell(
          Text(check[index].checkoutTime ?? "")),

        DataCell( Text(check[index].checkoutDescription ?? ""),
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
