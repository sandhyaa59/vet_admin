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
              return Align(
                  alignment: Alignment.center, child: checkInCheckOutTable());
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
                label: SizedBox(
                  child: Text(
                    'SN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
                  'CheckIn At',
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
                  'CheckOut At',
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
  CheckInCheckOutController controller = Get.find<CheckInCheckOutController>();

  @override
  DataRow? getRow(int index) {
    
    if (index >= check.length) {
      return null;
    }
   
    return DataRow(
     
      cells: <DataCell>[
        DataCell(Text('${index + 1}')),
        DataCell(Text(check[index].employeeName ?? "")),
        DataCell(Text(check[index].checkInTime ?? "")),
        DataCell( SizedBox(width: Get.size.width * 0.2,
          child: InkWell(
                onTap: () {
                  Get.dialog(checkInOutDescription(
                      check[index].checkInDescription ?? ""));
                },
                child: Text(check[index].checkInDescription??"")),
        ),
        ),
        DataCell(Text(check[index].checkoutTime ?? "")),
        DataCell(
          SizedBox(
              width: Get.size.width * 0.2,
              child: InkWell(
                  onTap: () {
                    Get.dialog(checkInOutDescription(
                        check[index].checkoutDescription ?? ""));
                  },
                  child: Text(check[index].checkoutDescription ?? ""))),
        )
      ],
    );
  }

  Widget checkInOutDescription(String descritption) {
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
            const Text("Description",
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
            child: SingleChildScrollView( scrollDirection: Axis.vertical,child: Text(descritption))),
      
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
