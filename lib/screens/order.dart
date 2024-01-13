import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/order_controller.dart';
import 'package:vet_pharma/model/order_response.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/widgets/appbar.dart';
import 'package:vet_pharma/widgets/organization.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});

  final controller = Get.find<OrderController>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController billController = TextEditingController();
  final TextEditingController taxController = TextEditingController();
  final TextEditingController grandTotalController = TextEditingController();
  final TextEditingController subtotalController = TextEditingController();

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20.0),
                    Center(child: organizationDetails()),
                    const SizedBox(
                      height: 50.0,
                    ),
                    orderTable(),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: organizationDetails()),
                    const SizedBox(
                      height: 50.0,
                    ),
                     orderTable()
                  ],
                ),
              );
            }
          })),
        );
      }),
    );
  }

  Widget orderTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
           width: Get.size.width,
          child: PaginatedDataTable(
            header: const Text("Order",
             style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
            source: MyDataSource(controller.orderList,
                controller.orderResponse.value.totalData ?? 0),
            initialFirstRowIndex: 0,
            rowsPerPage: controller.pageSize.value,
            // showFirstLastButtons: true,
            onPageChanged: (newPage) async {
              await controller.loadMore();
            },
            columns: <DataColumn>[
              DataColumn(
                label: Container(
                  width: 20,
                  child: const Text(
                    'SN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const DataColumn(
                label: SizedBox(
                  width: 60,
                  child: Text(
                    overflow: TextOverflow.visible,
                    'Employee Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const DataColumn(
                label: Text(
                  'Customer',
                  overflow: TextOverflow.visible,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const DataColumn(
                label: Text(
                  'Date Time',
                  overflow: TextOverflow.visible,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const DataColumn(
                label: Text(
                  'Status',
                  overflow: TextOverflow.visible,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const DataColumn(
                label: Text(
                  'Ordered Item',
                  overflow: TextOverflow.visible,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const DataColumn(
                label: Text(
                  'Action',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }
}

class MyDataSource extends DataTableSource {
  final List<Order> orders;
  final int totalData;

  MyDataSource(
    this.orders,
    this.totalData,
  );
  OrderController controller = OrderController();

  @override
  DataRow? getRow(int index) {
    if (index >= orders.length) {
      return null;
    }
    return DataRow(
      cells: <DataCell>[
        DataCell(SizedBox(width: 10, child: Text('${index + 1}'))),
        DataCell(SizedBox(
            width: 70,
            child: Text(
              orders[index].employeeName ?? "",
              overflow: TextOverflow.visible,
            ))),
        DataCell(Text(
          orders[index].customerName ?? "",
          overflow: TextOverflow.visible,
        )),
        DataCell(Text(
          orders[index].addedDateTime ?? "",
          overflow: TextOverflow.visible,
        )),
        DataCell(Text(
          orders[index].status ?? "",
          overflow: TextOverflow.visible,
        )),
        DataCell(Text(
          orders[index].responses![index].title ?? "",
          overflow: TextOverflow.visible,
        )),
        DataCell(IconButton(
            onPressed: () {
              controller.selectedOrder.value = orders[index];
              Get.toNamed(Routes.ORDER_DETAILS);
            },
            icon: const Icon(
              Icons.visibility,
              size: 16.0,
              color: Color(0xff596cff),
            ))),
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
