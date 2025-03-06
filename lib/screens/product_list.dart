import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/product_controller.dart';
import 'package:vet_pharma/model/product_list_response.dart';
import 'package:vet_pharma/screens/addProduct.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/widgets/appbar.dart';
import 'package:vet_pharma/widgets/cancel.dart';

class ProductList extends StatelessWidget {
  ProductList({super.key});

  final controller = Get.find<ProductController>();

  final formKey = GlobalKey<FormState>();

  final TextEditingController amountController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController paymentNumberController = TextEditingController();

  final TextEditingController contactController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

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
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => ProductAddForm());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                    color: Color(0xff596cff),
                                  ),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Add Product',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xff596cff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          productTable()
                        ],
                      ),
                    ));
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8),
                      child: SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => ProductAddForm());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: Color(0xff596cff),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Add Product',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff596cff),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    productTable()
                  ],
                );
              }
            }),
          ),
        );
      }),
    );
  }

  Widget productTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: Get.size.width,
        child: PaginatedDataTable(
          columnSpacing: 20,
          header: const Text(
            "Product List",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          source: MyDataSource(controller.dataList as List<Datum>,
              controller.productList.value.totalData ?? 0),
          initialFirstRowIndex: 0,
          rowsPerPage: controller.pageSize.value,
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'SN',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                "Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Category',
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
                'Discount',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Unit',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Brand',
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
                "Action",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDataSource extends DataTableSource {
  final List<Datum> datum;
  final int totalData;

  MyDataSource(
    this.datum,
    this.totalData,
  );
  ProductController controller = Get.find<ProductController>();

  @override
  DataRow? getRow(int index) {
    if (index >= datum.length) {
      return null;
    }
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(
          '${index + 1}',
        )),
        DataCell(Text(datum[index].title ?? "")),
        DataCell(Text(datum[index].categoryName ?? "")),
        DataCell(Text(datum[index].price.toString())),
        DataCell(Text(
          datum[index].discountPercentage.toString(),
        )),
        DataCell(Text(
          datum[index].unit.toString(),
        )),
        DataCell(Text(
          datum[index].brand.toString(),
        )),
        DataCell(InkWell(
          onTap: () async {
            if (datum[index].isActive == true) {
              await Get.dialog(askConfirmation(
                  "Are you sure you want to deactivate product ?",
                  TextButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: const Text('No')),
                  TextButton(
                      onPressed: () async {
                        var res =
                            await controller.deactivate(datum[index].id ?? 0);
                        Get.back();
                        if (res != null) {
                          await controller.initData();
                        }
                      },
                      child: const Text('Yes'))));
            } else {
              await Get.dialog(askConfirmation(
                  "Are you sure you want to activate product ?",
                  TextButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: const Text('No')),
                  TextButton(
                      onPressed: () async {
                        var res =
                            await controller.activate(datum[index].id ?? 0);
                        Get.back();
                        if (res != null) {
                          await controller.initData();
                        }
                      },
                      child: const Text('Yes'))));
            }
            Get.offAllNamed(Routes.PRODUCT);
          },
          child: Obx(() => Container(
                // height: 6.0,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: (datum[index].isActive ?? false)
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.circular(18.0)),

                child: Text(
                  (datum[index].isActive ?? false) ? "Active" : "In-Active",
                  style: const TextStyle(fontSize: 13.0, color: Colors.white),
                ),
              )),
        )),
        DataCell(
          Row(
            children: [
              IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 16.0,
                  ),
                  onPressed: () async {
                    // await Get.dialog(askConfirmation(
                    //     "Are you sure you want to delete employee ?",
                    //     TextButton(
                    //         onPressed: () async {
                    //           Get.back();
                    //         },
                    //         child: const Text('No')),
                    //     TextButton(
                    //         onPressed: () async {
                    //           // var res = await controller
                    //           //     .delete(employeeDetails[index].id ?? 0);

                    //           // Get.back();
                    //           // if (res != null) {
                    //           //   Get.offAllNamed(Routes.EMPLOYEE_MANAGEMENT);
                    //           // }
                    //         },
                    //         child: const Text('Yes'))));
                  }

                  // Get.toNamed(Routes.EMPLOYEE_MANAGEMENT);

                  ),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 16.0,
                ),
                onPressed: () async {
                  Get.to(() => ProductAddForm(productData: {
                        'id': datum[index].id,
                        'title': datum[index].title,
                        'category': datum[index].categoryName,
                        'stock': datum[index].stock,
                        'unit': datum[index].unit,
                        'price': datum[index].price,
                        'brand': datum[index].brand,
                        'description': datum[index].description,
                        'costPrice': datum[index].costPrice,

                        // 'address': customer.address,
                        // 'email': customer.email,
                        // 'phone': customer.phone,
                        // 'panNumber': customer.panNumber
                      }));
                  // controller.selectedEmployeeDetail.value =
                  //     employeeDetails[index];
                  // controller.nameController.text =
                  //     controller.selectedEmployeeDetail.value.fullName ?? "";
                  // controller.emailController.text =
                  //     controller.selectedEmployeeDetail.value.email ?? "";
                  // controller.mobileNumberController.text =
                  //     controller.selectedEmployeeDetail.value.mobileNumber ??
                  //         "";
                  // controller.jobTitleController.text =
                  //     controller.selectedEmployeeDetail.value.jobTitle ?? "";

                  // Get.dialog(employeeUpdateForm());

                  // var context;
                  // Get.dialog(updateEmployeeForm(context));
                },
              ),
            ],
          ),
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
