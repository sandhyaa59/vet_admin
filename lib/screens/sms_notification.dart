// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:vet_pharma/controller/customer_controller.dart';
import 'package:vet_pharma/controller/smscount_controller.dart';
import 'package:vet_pharma/model/customer_list_response.dart';
import 'package:vet_pharma/model/sms_Count_request.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/utils/theme.dart';
import 'package:vet_pharma/widgets/appbar.dart';

class SmsNoificationCount extends StatelessWidget {
  SmsNoificationCount({super.key});
  final TextEditingController messageController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final controller = Get.find<SmsNotificationCountController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBars(context),
            drawer: MyDrawer(),
            body: Obx(() {
              return LoadingOverlay(
                isLoading: controller.isLoading.value,
                child: SingleChildScrollView(
                  child: LayoutBuilder(builder: (context, constraints) {
                    if (constraints.maxWidth > 600) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: Get.size.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      // width: Get.size.width * 0.35,
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Form(
                                                key: formKey,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                        height: 10.0),
                                                    TextFormField(
                                                      controller:
                                                          searchController,
                                                      decoration:
                                                          customInputDecoration(
                                                        labelText:
                                                            "Search Here..",
                                                        iconButton: IconButton(
                                                            onPressed:
                                                                () async {
                                                              if (searchController
                                                                  .text
                                                                  .isNotEmpty) {
                                                                await controller
                                                                    .customerSearch(
                                                                        searchController
                                                                            .text
                                                                            .trim());
                                                                searchController
                                                                        .text =
                                                                    "${searchController.text} ";
                                                              }
                                                              searchController
                                                                  .clear();
                                                            },
                                                            icon: const Icon(
                                                                Icons.search)),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height: 10.0),
                                                    const SizedBox(
                                                        height: 20.0),
                                                    TextFormField(
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        // autofocus: true,
                                                        controller:
                                                            messageController,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return "Enter Message";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        maxLines: 4,
                                                        decoration:
                                                            customInputDecoration(
                                                                labelText:
                                                                    'Message')),
                                                    const SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Center(
                                                      child: SizedBox(
                                                        width:
                                                            Get.size.width * 0.3,
                                                        height: 50,
                                                        child: ElevatedButton(
                                                            onPressed: () async {
                                                              if (formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                if (controller
                                                                    .selectedCustomer
                                                                    .isEmpty) {
                                                                  showToastMessage(
                                                                      Colors.red,
                                                                      "select customer",
                                                                      "Error");
                                                                  return;
                                                                }
                                                                if (controller
                                                                        .isLoading
                                                                        .value ==
                                                                    false) {
                                                                  controller
                                                                      .isLoading
                                                                      .value = true;
                                                                  SmsCountRequest
                                                                      smsCountRequest =
                                                                      SmsCountRequest();
                                                                  smsCountRequest
                                                                          .message =
                                                                      messageController
                                                                          .text;
                                                                  List<String>
                                                                      mobileNumber =
                                                                      <String>[];
                                                                  for (var element
                                                                      in controller
                                                                          .selectedCustomer) {
                                                                    mobileNumber
                                                                        .add(element
                                                                            .mobileNumber!);
                                                                  }
                                                                  smsCountRequest
                                                                          .mobileNumber =
                                                                      mobileNumber;
                                                                  var res =
                                                                      await controller
                                                                          .sendSms(
                                                                              smsCountRequest);
                                                                  if (res !=
                                                                      null) {
                                                                    // await controller.initData();
                                                                    Get.offAndToNamed(
                                                                        Routes
                                                                            .EMPLOYEE_MANAGEMENT);
                                                                  }
                                                                  formKey
                                                                      .currentState!
                                                                      .reset();
                                                                }
                                                                formKey
                                                                    .currentState!
                                                                    .reset();
                                                              }
                                                            },
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xff596cff),
                                                            ),
                                                            child: const Text(
                                                              "Send",
                                                              style: TextStyle(
                                                                  fontSize: 18.0),
                                                            )),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    SizedBox(
                                      height: Get.size.height,
                                      child: Obx(() => ListView.builder(
                                            itemCount: controller
                                                .selectedCustomer.length,
                                            shrinkWrap: true,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text(controller
                                                        .selectedCustomer[index]
                                                        .shopName ??
                                                    ""),
                                                subtitle: Text(controller
                                                        .selectedCustomer[index]
                                                        .mobileNumber ??
                                                    ""),
                                              );
                                            },
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width: Get.size.width * 0.55,
                                  child: customerTable())
                            ],
                          ));
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Form(
                                  key: formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10.0),
                                      TextFormField(
                                        controller: searchController,
                                        decoration: customInputDecoration(
                                          labelText: "Search Here..",
                                          iconButton: IconButton(
                                              onPressed: () async {
                                                if (searchController
                                                    .text.isNotEmpty) {
                                                  await controller
                                                      .customerSearch(
                                                          searchController.text
                                                              .trim());
                                                  searchController.text =
                                                      "${searchController.text} ";
                                                }
                                                searchController.clear();
                                              },
                                              icon: const Icon(Icons.search)),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      const SizedBox(height: 20.0),
                                      TextFormField(
                                          textInputAction: TextInputAction.next,
                                          // autofocus: true,
                                          controller: messageController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter Message";
                                            } else {
                                              return null;
                                            }
                                          },
                                          maxLines: 4,
                                          decoration: customInputDecoration(
                                              labelText: 'Message')),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      Center(
                                        child: SizedBox(
                                          width: Get.size.width * 0.3,
                                          height: 50,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  if (controller
                                                      .selectedCustomer.isEmpty) {
                                                    showToastMessage(
                                                        Colors.red,
                                                        "select customer",
                                                        "Error");
                                                    return;
                                                  }
                                                  if (controller
                                                          .isLoading.value ==
                                                      false) {
                                                    controller.isLoading.value =
                                                        true;
                                                    SmsCountRequest
                                                        smsCountRequest =
                                                        SmsCountRequest();
                                                    smsCountRequest.message =
                                                        messageController.text;
                                                    List<String> mobileNumber =
                                                        <String>[];
                                                    for (var element in controller
                                                        .selectedCustomer) {
                                                      mobileNumber.add(
                                                          element.mobileNumber!);
                                                    }
                                                    smsCountRequest.mobileNumber =
                                                        mobileNumber;
                                                    var res = await controller
                                                        .sendSms(smsCountRequest);
                                                    if (res != null) {
                                                      // await controller.initData();
                                                      Get.offAndToNamed(Routes
                                                          .EMPLOYEE_MANAGEMENT);
                                                    }
                                                    formKey.currentState!.reset();
                                                  }
                                                  formKey.currentState!.reset();
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xff596cff),
                                              ),
                                              child: const Text(
                                                "Send",
                                                style: TextStyle(fontSize: 18.0),
                                              )),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),

                                      
                                    ],
                                  ),
                                ),
                                 SizedBox(
                                      height: Get.size.height*0.1,
                                      child: Obx(() => ListView.builder(
                                            itemCount: controller
                                                .selectedCustomer.length,
                                            shrinkWrap: true,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text(controller
                                                        .selectedCustomer[index]
                                                        .shopName ??
                                                    ""),
                                                subtitle: Text(controller
                                                        .selectedCustomer[index]
                                                        .mobileNumber ??
                                                    ""),
                                              );
                                            },
                                          )),
                                    ),
                                customerTable()
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                ),
              );
            })));
  }

  Widget customerTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: Get.size.width,
          child: GetBuilder<SmsNotificationCountController>(
            init: controller,
            initState: (_) {},
            builder: (_) {
              return PaginatedDataTable(
                header: const Text(
                  "Customers",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                source: MyDataSource(controller.customerList,
                    controller.customerListResponse.value.totalData ?? 0),
                initialFirstRowIndex: 0,
                rowsPerPage: controller.pageSize.value,
                // showFirstLastButtons: true,
                onPageChanged: (newPage) async {
                  await controller.loadMoreData();
                },
                columnSpacing: 20,
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
                      'Email',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Shop Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Address',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Contact',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Select',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}

class MyDataSource extends DataTableSource {
  final List<CustomerList> customerLists;
  final int totalData;

  MyDataSource(
    this.customerLists,
    this.totalData,
  );

  final controller = Get.find<SmsNotificationCountController>();

  @override
  DataRow? getRow(int index) {
    if (index >= customerLists.length) {
      return null;
    }
    return DataRow(
      cells: <DataCell>[
        DataCell(Text('${index + 1}')),
        DataCell(SizedBox(
          //width: Get.width * 0.2,
          child: Text(
            customerLists[index].name ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )),
        DataCell(SizedBox(
          //  width: Get.width * 0.18,
          child: Text(
            customerLists[index].email ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )),
        DataCell(SizedBox(
          //width: Get.width * 0.2,
          child: Text(
            customerLists[index].shopName ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )),
        DataCell(SizedBox(
          child: Text(
            customerLists[index].address ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )),
        DataCell(Text(customerLists[index].mobileNumber ?? "")),
        DataCell(GetBuilder<SmsNotificationCountController>(
            init: controller,
            builder: (_) {
              return ElevatedButton(
                  onPressed: () {
                    if (customerLists[index].isSelected == false) {
                      customerLists[index].isSelected = true;
                      if (!controller.selectedCustomer
                          .contains(customerLists[index])) {
                        controller.selectedCustomer.add(customerLists[index]);
                      }
                    } else {
                      customerLists[index].isSelected = false;
                      if (controller.selectedCustomer
                          .contains(customerLists[index])) {
                        controller.selectedCustomer
                            .remove(customerLists[index]);
                      }
                    }
                    controller.update();
                  },
                  //  customerLists[index].isSelected=true;
                  //   controller.selectedCustomer.add(customerLists[index]);
                  // },
                  child: Obx(() => customerLists[index].isSelected == false
                      ? const Text("Select")
                      : const Text("Selected")));
            }))
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

  // final formKey = GlobalKey<FormState>();
}
