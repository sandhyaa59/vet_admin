import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/payment_controller.dart';
import 'package:vet_pharma/model/payment_repsone.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/widgets/appbar.dart';
import 'package:vet_pharma/widgets/organization.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});

  final controller = Get.find<PaymentController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBars(context),
      body: SingleChildScrollView(child: Obx(() {
        return LoadingOverlay(
          isLoading: controller.isLoading.value,
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    organizationDetails(),
                    const SizedBox(
                      height: 50.0,
                    ),
                    paymentTable()
                  ],
                ),
              );
            } else {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(child: organizationDetails()),
                    ),
                     paymentTable()
                  ],
              );
            }
          }),
        );
      })),
    );
  }

  Widget paymentTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: Get.size.width,
          child: PaginatedDataTable(
            header: const Text(
              "Payment",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            source: MyDataSource(controller.paymentList,
                controller.paymentListRes.value.totalData ?? 0),
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
                  "Added By",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Bank Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Payment Mode',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Payment Number',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Amount',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  "Added At",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  "Action ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }
}

class MyDataSource extends DataTableSource {
  final List<PaymentList> payment;
  final int totalData;

  MyDataSource(
    this.payment,
    this.totalData,
  );
  PaymentController controller = Get.find<PaymentController>();

  @override
  DataRow? getRow(int index) {
    if (index >= payment.length) {
      return null;
    }
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(
          '${index + 1}',
        )),
        DataCell(Text(payment[index].addedBy ?? "")),
        DataCell(Text(payment[index].bankName ?? "")),
        DataCell(Text(payment[index].paymentMode ?? "")),
        DataCell(Text(
          payment[index].paymentNumber ?? "",
        )),
        DataCell(Text(
          payment[index].amount.toString(),
        )),
        DataCell(Text(
          payment[index].addedAt ?? "",
        )),
        DataCell(IconButton(
            onPressed: () {
              controller.selectedPaymentData.value = payment[index];
              Get.toNamed(Routes.PAYMENT_DETAILS,
                  arguments: payment[index].billId);
              controller.isLoading.value = false;
            },
            icon: const Icon(
              Icons.visibility,
             size: 16.0,
              color: Color(0xff596cff),
            )))
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
