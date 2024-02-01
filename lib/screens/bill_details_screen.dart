import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/bill_details_controller.dart';
import 'package:vet_pharma/model/bill_details_response.dart';
import 'package:vet_pharma/model/payment_save_request.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/utils/theme.dart';
import 'package:vet_pharma/widgets/cancel.dart';
import 'package:vet_pharma/widgets/text.dart';

// ignore: must_be_immutable
class BillDetailsScreen extends StatelessWidget {
  BillDetailsScreen({super.key});
  final controller = Get.find<BillDetailsController>();

  final formkey = GlobalKey<FormState>();

  final TextEditingController amountController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController paymentNumberController = TextEditingController();

  final TextEditingController contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff596cff),
        title: const Text("Bill Details"),
      ),
      body: Obx(() {
        return LoadingOverlay(
          isLoading: controller.isLoading.value,
          child: SingleChildScrollView(
            child:  Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.billDetails.value.isVoid == false
                        ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: SizedBox(
                                    // width: 80,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Get.dialog(paymentForm(context));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                ),
                                const SizedBox(width: 20.0),
                                SizedBox(
                                  // width: 80,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        Get.dialog(askConfirmation(
                                            "Are you sure you want to cancel bill ?",
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text("No")),
                                            TextButton(
                                                onPressed: () async {
                                                  var res = await controller
                                                      .cancel(controller
                                                          .billDetails.value.id!);
                                                          Get.back();
                                                  if (res != null) {
                                                    
                        
                                                    Get.offAllNamed(
                                                        Routes.BILLING);
                                                  }
                                                },
                                                child: const Text("Yes"))));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: const BorderSide(
                                                  color: Colors.red))),
                                      child: const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Text(
                                          'Cancel Bill',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                        )
                        : const SizedBox(),
                    const SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.center,
                      child: Card(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: LayoutBuilder(builder: (context, constraints) {
                            if (constraints.maxWidth > 600) {
                              return Container(
                                width: Get.width * 0.85,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0)),
                                padding: const EdgeInsets.all(kPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    billEmployeeDetails(),
                                    const Divider(),
                                    const SizedBox(height: 10.0),
                                    billCustomerDetails(),
                                    const Divider(),
                                    const SizedBox(height: 10.0),
                                    orderStatus(),
                                    const Divider(),
                                    const SizedBox(height: 10.0),
                                    billDetails(true),
                                    const Divider(),
                                    billListable(controller.billList)
                                  ],
                                ),
                              );
                            } else {
                              return Container(
                                padding: const EdgeInsets.all(kPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    billEmployeeDetails(),
                                    const Divider(),
                                    const SizedBox(height: 10.0),
                                    billCustomerDetails(),
                                    const Divider(),
                                    const SizedBox(height: 10.0),
                                    orderStatus(),
                                    const Divider(),
                                    const SizedBox(height: 10.0),
                                    billDetails(false),
                                    const Divider(),
                                    const SizedBox(height: 10.0),
                                    billListable(controller.billList)
                                  ],
                                ),
                              );
                            }
                          })),
                    ),
                  ],
                
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget billCustomerDetails() {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showTitleContent(
                      "Customer Name : ",
                      controller.billDetails.value.customerName??"",
                    ),
                    const SizedBox(height: 8.0),
                    showTitleContent(
                      "Email : ",
                      controller.billDetails.value.customerEmail??"",
                    ),
                    const SizedBox(height: 8.0),
                    showTitleContent(
                      "Shop Name : ",
                      controller.billDetails.value.orderResponse?.shopName ??""
                          "",
                      // controller.billDetails.value.??"",
                    ),const SizedBox(height: 8.0),
                    showTitleContent(
                      "Customer Pan : ",
                      controller.billDetails.value.orderResponse?.customerPan??"",
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: showTitleContent(
                    "Contact : ",
                    controller.billDetails.value.customerMobileNo??"",
                  ),
                ),
              ],
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showTitleContent(
              "Customer Name : ",
              controller.billDetails.value.customerName.toString(),
            ),
            const SizedBox(height: 8.0),
            showTitleContent(
              "Contact : ",
              controller.billDetails.value.customerMobileNo.toString(),
            ),
            const SizedBox(height: 10.0),
            showTitleContent(
              "Email : ",
              controller.billDetails.value.customerEmail.toString(),
            ),
            const SizedBox(height: 10.0),
            showTitleContent(
              "Shop Name : ",
              controller.billDetails.value.orderResponse?.shopName ?? "",
            ),const SizedBox(height: 10.0),
             showTitleContent(
                      "Customer Pan : ",
                     controller.billDetails.value.orderResponse?.customerPan??"",
                    ),
          ],
        );
      }
    });
  }

  Widget orderStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: showTitleContent(
            "Order Status : ",
            controller.billDetails.value.orderResponse?.status ?? "",
          ),
        ),
        Flexible(
          child: showTitleContent(
            "Order date : ",
            controller.billDetails.value.orderResponse?.addedDateTime ?? "",
          ),
        ),
      ],
    );
  }

  Widget billEmployeeDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: showTitleContent(
            "Employee Name : ",
            controller.billDetails.value.orderResponse?.employeeName ?? "",
          ),
        ),
      ],
    );
  }

  Widget billDetails(bool flag) {
    return flag
        ? Row(children: [
            Row(children: [
              showTitleContent(
                "Bill No : ",
                controller.billDetails.value.billNo.toString(),
              ),
              const SizedBox(width: 20.0),
              (controller.billDetails.value.isVoid == true)
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6.0)),
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "Void",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    )
                  : Container(),
            ]),
            const Expanded(
              child: SizedBox(
                width: 5.0,
              ),
            ),
            showTitleContent(
              "Bill date : ",
              controller.billDetails.value.createdAt ?? "",
            ),
          ])
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                showTitleContent(
                  "Bill No : ",
                  controller.billDetails.value.billNo.toString(),
                ),
                const SizedBox(width: 20.0),
                (controller.billDetails.value.isVoid == true)
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6.0)),
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          "Void",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      )
                    : Container(),
              ]),
              showTitleContent(
                "Bill date : ",
                controller.billDetails.value.createdAt ?? "",
              ),
            ],
          );
  }

  billListable(List<BillOrderResponse> inHand) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            "Ordered Items",
            style: TextStyle(
                color: Color(0xff004792),
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8.0),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff004792),
                    ),
                    borderRadius: BorderRadius.circular(12)),
                columns: const [
                  DataColumn(
                      label: Text(
                    "Title",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataColumn(
                      label: Text(
                    "Quantity",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ],
                rows: List.generate(inHand.length, (index) {
                  return DataRow(cells: <DataCell>[
                    DataCell(Text(inHand[index].title ?? "")),
                    DataCell(Text(inHand[index].quantity.toString())),
                  ]);
                })),
          ),
        ),
        const SizedBox(height: 10.0),
        const Text("Description ",
            style: TextStyle(
                fontSize: 16.0,
                color: Color(0xff004792),
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade200,
              ),
              borderRadius: BorderRadius.circular(8.0)),
          child: Text(
              controller.billDetails.value.orderResponse?.description ?? "",
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
        ),
        Container(
          alignment: AlignmentDirectional.bottomEnd,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showTitleContent("Sub Total : ",
                  controller.billDetails.value.subTotal.toString()),
              const SizedBox(height: 8.0),
              showTitleContent("Discount : ",
                  controller.billDetails.value.discounts.toString()),
              const SizedBox(height: 8.0),
              showTitleContent(
                  "Tax : ", controller.billDetails.value.tax.toString()),
              const SizedBox(height: 8.0),
              showTitleContent("Grand Total : ",
                  controller.billDetails.value.grandTotal.toString()),
            ],
          ),
        ),
      ],
    );
  }

  Widget paymentForm(BuildContext context) {
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
                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.next,
                          autofocus: true,
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
                      items: ['Cash', 'Cheque', 'Voucher']
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
                          autofocus: true,
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
                  SizedBox(
                    width: Get.size.width * 0.3,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            if (controller.paymentController.isLoading.value ==
                                false) {
                              controller.paymentController.isLoading.value =
                                  true;
                              PaymentSaveRequest saveRequest =
                                  PaymentSaveRequest();
                              saveRequest.amount = amountController.text;
                              saveRequest.bankName = bankNameController.text;
                              saveRequest.paymentMethod =
                                  controller.selectedPaymentMethod.value;
                              saveRequest.mobileNumber = contactController.text;
                              saveRequest.paymentNumber =
                                  paymentNumberController.text;
                              // saveRequest.employeeId = controller
                              //     .billDetails.value.orderResponse?.employeeId!;
                              saveRequest.billId =
                                  controller.billDetails.value.id!;

                              var res = await controller.paymentController
                                  .savePayment(saveRequest);
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
                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.next,
                          autofocus: true,
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
                      items: ['Cash', 'Cheque', 'Voucher']
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
                      labelText:
                          getLabelText(controller.selectedPaymentMethod.value),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: contactController,keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.next,
                          autofocus: true,
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
                        child: TextFormField(textInputAction: TextInputAction.done,
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
                      // width: Get.size.width * 0.3,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              if (controller
                                      .paymentController.isLoading.value ==
                                  false) {
                                controller.paymentController.isLoading.value =
                                    true;
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
                                // saveRequest.employeeId = controller.billDetails
                                //     .value.orderResponse?.employeeId!;
                                saveRequest.billId =
                                    controller.billDetails.value.id!;

                                var res = await controller.paymentController
                                    .savePayment(saveRequest);
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
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
