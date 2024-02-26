import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/payment_controller.dart';
import 'package:vet_pharma/model/bill_repsonse.dart';
import 'package:vet_pharma/model/payment_repsone.dart';
import 'package:vet_pharma/model/payment_save_request.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/utils/theme.dart';
import 'package:vet_pharma/widgets/appbar.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});

  final controller = Get.find<PaymentController>();

  final formkey = GlobalKey<FormState>();

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
      body: SingleChildScrollView(child: Obx(() {
        return LoadingOverlay(
          isLoading: controller.isLoading.value,
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // organizationDetails(),

                    SizedBox(
                      // width: 80,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.dialog(paymentForm(context, constraints));
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
                              'Make Payment',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff596cff),
                              ),
                            ),
                          )),
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
                    padding: const EdgeInsets.only(top: 8.0, left: 8),
                    child: SizedBox(
                      // width: 80,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.dialog(paymentForm(context, constraints));
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
                            'Make Payment',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xff596cff),
                            ),
                          ),
                        ),
                      ),
                    ),
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

  Widget paymentForm(BuildContext context, BoxConstraints constraints) {
    String getLabelText(String paymentMethod) {
      switch (paymentMethod) {
        case 'Cash':
          return 'Cash Number';

        case 'Cheque':
          return 'Cheque Number';
        case 'Voucher':
          return 'Voucher Number';
        default:
          return 'Payment Number';
      }
    }

    return  AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xff596cff),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Make Payment",
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
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  TypeAheadField<Bill>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: searchController,
                      decoration: customInputDecoration(
                        hintText: 'Search bill...',
                        iconButton: IconButton(
                          onPressed: () async {
                            if (searchController.text.isNotEmpty) {
                              await controller
                                  .billSearch(searchController.text.trim());
                              searchController.text =
                                  "${searchController.text} ";
                            }
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      return controller.billList.value;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion.billNo ?? ""),
                        trailing: Text(suggestion.createdAt ?? ""),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      controller.selectedBill.value = suggestion;
                      controller.update();
                    },
                  ),
                    GetBuilder<PaymentController>(
                      init: controller,
                      initState: (_) {},
                      builder: (_) {
                        return(controller.selectedBill.value.id != null)? Card(
                          child: ListTile(
                            title: Text(
                              controller.selectedBill.value.billNo ?? "",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            trailing: Text(
                                "Received : ${controller.selectedBill.value.received.toString()}"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5.0),
                                Text(
                                  "Due : ${controller.selectedBill.value.due.toString()}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ):Container();
                      },
                    ),

                  // TextFormField(
                  //   // autofillHints: [
                  //   //   controller.bill.value.billNo.toString()
                  //   // ],
                  //   controller: searchController,
                  //   onFieldSubmitted: (v) {
                  //     if (searchController.text.isNotEmpty) {
                  //       controller.billSearch(searchController.text);
                  //     }
                  //   },
                  //   decoration: customInputDecoration(
                  //     hintText: 'Search bill...',
                  //     iconButton: IconButton(
                  //         onPressed: () {
                  //           if (searchController.text.isNotEmpty) {
                  //             controller.billSearch(searchController.text);
                  //           }
                  //         },
                  //         icon: const Icon(Icons.search)),
                  //   ),
                  // ),

                  //  Expanded(
                  //    child: Column(
                  //      children: [
                  //        Obx(() {
                  //           return  ListView.builder(
                  //               // shrinkWrap: true,
                  //               scrollDirection: Axis.vertical,
                  //               physics:const ScrollPhysics(),
                  //                 itemCount: controller.billList.length,
                  //                 itemBuilder: (context, index) {
                  //                   return ListTile(
                  //                     title: Text(controller
                  //                         .billList[index].billNo
                  //                         .toString()),
                  //                     subtitle: Text(controller
                  //                         .billList[index].createdAt
                  //                         .toString()),
                  //                   );
                  //                 },
                  //           );
                  //         }),
                  //      ],
                  //    ),
                  //  ),
                  //     : SizedBox(),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter amount';
                      } else {
                        return null;
                      }
                    },
                    decoration: customInputDecoration(labelText: "Amount"),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonFormField<String>(
                      value: controller.selectedPaymentMethod.value,
                      onChanged: (String? newValue) {
                        controller.selectedPaymentMethod.value = newValue!;
                      },
                      items: ['Cash', 'Cheque', 'Bank Deposit']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: customInputDecoration()),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: paymentNumberController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter payment number';
                      } else {
                        return null;
                      }
                    },
                    decoration: customInputDecoration(
                      labelText: getLabelText("Payment Number"),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: contactController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter contact details';
                      } else {
                        return null;
                      }
                    },
                    decoration: customInputDecoration(labelText: "Contact No"),
                  ),
                  const SizedBox(height: 10.0),
                  Obx(() => Visibility(
                        visible:
                            controller.selectedPaymentMethod.value != 'Cash',
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: bankNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter bank name';
                            } else {
                              return null;
                            }
                          },
                          decoration:
                              customInputDecoration(labelText: "Bank Name"),
                        ),
                      )),
                  const SizedBox(height: 20.0),
                  Center(
                    child: SizedBox(
                      width:  (constraints.maxWidth > 600)?Get.size.width * 0.3:null,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              if (controller.selectedBill.value.id == null) {
                      showToastMessage(Colors.red, "select bill", "Error");
                      return;
                    }
                              if (controller.isLoading.value == false) {
                                controller.isLoading.value = true;
                                PaymentSaveRequest saveRequest =
                                    PaymentSaveRequest();
                                saveRequest.amount = amountController.text;
                                saveRequest.bankName = bankNameController.text;
                                saveRequest.paymentMethod =
                                    controller.selectedPaymentMethod.value;
                                saveRequest.mobileNumber =
                                    contactController.text;
                                saveRequest.paymentNumber =
                                    paymentNumberController.text;
                                // saveRequest.employeeId = controller
                                //     .billDetails.value.orderResponse?.employeeId!;
                                saveRequest.billId =controller.selectedBill.value.id!;

                                var res =
                                    await controller.savePayment(saveRequest);
                                Get.back();
                                if (res != null) {
                                  Get.offAndToNamed(Routes.PAYMENT);
                                }
                                formkey.currentState!.reset();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff596cff),
                          ),
                          child: const Text(
                            "Make Payment",
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
      //  else {
      //   return AlertDialog(
      //     titlePadding: const EdgeInsets.all(0),
      //     title: Container(
      //       padding: const EdgeInsets.all(12),
      //       decoration: const BoxDecoration(
      //         color: Color(0xff596cff),
      //       ),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           const Text("Make Payment",
      //               style: TextStyle(
      //                   color: Colors.white,
      //                   fontWeight: FontWeight.w800,
      //                   fontSize: 18.0)),
      //           CircleAvatar(
      //               backgroundColor: const Color(0xff596cff),
      //               child: IconButton(
      //                   onPressed: () {
      //                     Get.back();
      //                   },
      //                   icon: const Icon(
      //                     Icons.close,
      //                     color: Colors.white,
      //                   ))),
      //         ],
      //       ),
      //     ),
      //     content: Form(
      //       key: formkey,
      //       child: SingleChildScrollView(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             const SizedBox(height: 10.0),
      //             TextFormField(
      //               controller: searchController,
      //               onFieldSubmitted: (v) {
      //                 if (searchController.text.isNotEmpty) {
      //                   controller.billSearch(searchController.text);
      //                 }
      //               },
      //               onChanged: (v) {
      //                 if (searchController.text.isEmpty) {
      //                   controller.bill.value =
      //                       (controller.billResponse.value.data ?? []) as Bill;
      //                 }
      //               },
      //               decoration: customInputDecoration(
      //                 hintText: 'Search bill...',
      //                 iconButton: IconButton(
      //                     onPressed: () {
      //                       if (searchController.text.isNotEmpty) {
      //                         controller.billSearch(searchController.text);
      //                       }
      //                     },
      //                     icon: const Icon(Icons.search)),
      //               ),
      //             ),
      //             const SizedBox(
      //               height: 20.0,
      //             ),
      //             TextFormField(
      //               controller: searchController,
      //               decoration: customInputDecoration(
      //                   labelText: "Search ",
      //                   iconButton: IconButton(
      //                       onPressed: () {}, icon: const Icon(Icons.search))),
      //             ),
      //             const SizedBox(
      //               height: 20.0,
      //             ),
      //             TextFormField(
      //               controller: amountController,
      //               keyboardType: TextInputType.number,
      //               inputFormatters: <TextInputFormatter>[
      //                 FilteringTextInputFormatter.digitsOnly
      //               ],
      //               textInputAction: TextInputAction.next,
      //               validator: (value) {
      //                 if (value!.isEmpty) {
      //                   return 'Enter amount';
      //                 } else {
      //                   return null;
      //                 }
      //               },
      //               decoration: customInputDecoration(labelText: "Amount"),
      //             ),
      //             const SizedBox(height: 20.0),
      //             DropdownButtonFormField<String>(
      //                 value: controller.selectedPaymentMethod.value,
      //                 onChanged: (String? newValue) {
      //                   controller.selectedPaymentMethod.value = newValue!;
      //                 },
      //                 items: ['Cash', 'Cheque', 'Bank Deposit']
      //                     .map<DropdownMenuItem<String>>((String value) {
      //                   return DropdownMenuItem<String>(
      //                     value: value,
      //                     child: Text(value),
      //                   );
      //                 }).toList(),
      //                 decoration: customInputDecoration()),
      //             const SizedBox(height: 20.0),
      //             TextFormField(
      //               controller: paymentNumberController,
      //               validator: (value) {
      //                 if (value!.isEmpty) {
      //                   return 'Enter payment number';
      //                 } else {
      //                   return null;
      //                 }
      //               },
      //               decoration: customInputDecoration(
      //                 labelText:
      //                     getLabelText(controller.selectedPaymentMethod.value),
      //               ),
      //             ),
      //             const SizedBox(height: 20.0),
      //             TextFormField(
      //               controller: contactController,
      //               keyboardType: TextInputType.number,
      //               inputFormatters: <TextInputFormatter>[
      //                 FilteringTextInputFormatter.digitsOnly
      //               ],
      //               textInputAction: TextInputAction.next,
      //               validator: (value) {
      //                 if (value!.isEmpty) {
      //                   return 'Enter contact details';
      //                 } else {
      //                   return null;
      //                 }
      //               },
      //               decoration: customInputDecoration(labelText: "Contact No"),
      //             ),
      //             const SizedBox(height: 10.0),
      //             Obx(() => Visibility(
      //                   visible:
      //                       controller.selectedPaymentMethod.value != 'Cash',
      //                   child: TextFormField(
      //                     textInputAction: TextInputAction.done,
      //                     controller: bankNameController,
      //                     validator: (value) {
      //                       if (value!.isEmpty) {
      //                         return 'Enter bank name';
      //                       } else {
      //                         return null;
      //                       }
      //                     },
      //                     decoration:
      //                         customInputDecoration(labelText: "Bank Name"),
      //                   ),
      //                 )),
      //             const SizedBox(height: 20.0),
      //             Center(
      //               child: SizedBox(
      //                 // width: Get.size.width * 0.3,
      //                 height: 50,
      //                 child: ElevatedButton(
      //                     onPressed: () async {
      //                       if (formkey.currentState!.validate()) {
      //                         if (controller.isLoading.value == false) {
      //                           controller.isLoading.value = true;
      //                           PaymentSaveRequest saveRequest =
      //                               PaymentSaveRequest();
      //                           saveRequest.amount = amountController.text;
      //                           saveRequest.bankName = bankNameController.text;
      //                           saveRequest.paymentMethod =
      //                               controller.selectedPaymentMethod.value;
      //                           saveRequest.mobileNumber =
      //                               contactController.text;
      //                           saveRequest.paymentNumber =
      //                               paymentNumberController.text;
      //                           // saveRequest.employeeId = controller.billDetails
      //                           //     .value.orderResponse?.employeeId!;
      //                           saveRequest.billId =
      //                               controller.billDetails.value.id!;

      //                           var res =
      //                               await controller.savePayment(saveRequest);
      //                           Get.back();
      //                           if (res != null) {
      //                             Get.offAndToNamed(Routes.PAYMENT);
      //                           }
      //                           formkey.currentState!.reset();
      //                         }
      //                       }
      //                     },
      //                     style: ElevatedButton.styleFrom(
      //                       backgroundColor: const Color(0xff596cff),
      //                     ),
      //                     child: const Text(
      //                       "Make Payment",
      //                       style: TextStyle(fontSize: 18.0),
      //                     )),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   );
      // }

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
