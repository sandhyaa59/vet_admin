import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/billing_controller.dart';
import 'package:vet_pharma/model/bill_repsonse.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/widgets/appbar.dart';
import 'package:vet_pharma/widgets/organization.dart';

class BillingScreen extends StatelessWidget {
  BillingScreen({super.key});

  final controller = Get.find<BillingController>();

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
              return Container(
                padding: const EdgeInsets.all(kPadding),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: organizationDetails()),
                    const SizedBox(
                      height: 50.0,
                    ),
                    billingTable()
                    // Card(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(8)),
                    //     elevation: 2.0,
                    //     child: Container(
                    //         // width: double.maxFinite,
                    //         padding: const EdgeInsets.all(12),
                    //         child: billingTable())),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      organizationDetails(),
                      const SizedBox(
                        height: 50.0,
                      ),
                      billingTable()
                      // Card(
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(8)),
                      //     elevation: 2.0,
                      //     child: Container(
                      //         // width: double.maxFinite,
                      //         padding: const EdgeInsets.all(12),
                      //         child: billingTable())),
                    ],
                  ),
                ),
              );
            }
          })),
        );
      }),
    );
  }

  Widget billingTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
          width: Get.size.width,
          child: GetBuilder<BillingController>(
            init: controller,
            initState: (_) {},
            builder: (_) {
              return PaginatedDataTable(
                header: const Text("Bill", style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                source: MyDataSource(
                    controller.bill, controller.billResponse.value),
                initialFirstRowIndex: 0,
                rowsPerPage: controller.pageSize.value,
                // showFirstLastButtons: true,
                onPageChanged: (newPage) async {
                  await controller.loadMoreData();
        
                },
                // onRowsPerPageChanged: (value) {
                //   controller.pageSize.value=value!;
                // },
                // rowsPerPage: controller.billResponse.value.totalData??0,

                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'SN',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Customer Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Customer Email',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Customer Contact',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Tax',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Bill Number',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Sub Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Grand Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Discount',
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
              );
            },
          )),
    );
  }
}

class MyDataSource extends DataTableSource {
  final List<Bill> bills;
  final BillResponse billResponse;
  

  MyDataSource(this.bills, this.billResponse,);

  @override
  DataRow? getRow(int index) {
    if (index >= bills.length) {
      return null;
      
    }
    return DataRow(
      cells: <DataCell>[
        DataCell(
          Text("${index + 1}"),
        ),
        DataCell(Text(
          bills[index].customerName ?? "",
        )),
        DataCell(Text(bills[index].customerEmail ?? "")),
        DataCell(Text(bills[index].customerMobileNo ?? "")),
        DataCell(Text(bills[index].tax.toString())),
        DataCell(Text(bills[index].billNo.toString())),
        DataCell(Text(bills[index].subTotal.toString())),
        DataCell(Text(bills[index].grandTotal.toString())),
        DataCell(Text(bills[index].discounts.toString())),
        DataCell(
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.BILL_DETAILS, arguments: bills[index].id);
              },
              icon: const Icon(
                Icons.visibility,
                size: 14.0,
              )),
        ),
      ],
    );
  }

  @override
  int get rowCount {
    
  return billResponse.totalData ?? 0;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;




}
