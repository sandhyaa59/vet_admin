import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/bill_details_controller.dart';
import 'package:vet_pharma/model/bill_details_response.dart';
import 'package:vet_pharma/model/payment_save_request.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/utils/theme.dart';
import 'package:vet_pharma/widgets/appbar.dart';

class BillDetailsScreen extends StatelessWidget {
  BillDetailsScreen({super.key});
  final controller = Get.find<BillDetailsController>();

  final formkey = GlobalKey<FormState>();

  final TextEditingController amountController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController paymentNumberController = TextEditingController();

  final TextEditingController contactController = TextEditingController();
    String selectedPaymentMethod = 'Cash'; 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars(context),
      body: Obx(() {
        return LoadingOverlay(
          isLoading: controller.isLoading.value,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(kPadding),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.billDetails.value.orderResponse!.status ==
                            "BILLED"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: SizedBox(
                                  // width: 80,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return paymentForm(context);
                                          },
                                        );
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
                                    onPressed: () async{
                                       await controller.cancel(
                                       controller.billDetails.value.orderResponse!.id!
                                      );
                    await controller.initData( controller.billDetails.value.orderResponse!.id!);
                    Get.toNamed(Routes.BILL_DETAILS);
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
                                        'Cancel Payment',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.red,
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.center,
                      child: Card(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Container(
                            width: Get.width * 0.5,
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
                                const SizedBox(height: 20.0),
                                billListable(controller.billList)
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget billCustomerDetails() {
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
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Customer Name : ",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff004792),
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          controller.billDetails.value.customerName.toString(),
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600))
                ])),
                const SizedBox(height: 8.0),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Email : ",
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xff004792),
                          fontWeight: FontWeight.w800)),
                  TextSpan(
                      text:
                          controller.billDetails.value.customerEmail.toString(),
                      style: const TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w600))
                ])),
                const SizedBox(height: 8.0),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Description : ",
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xff004792),
                          fontWeight: FontWeight.w800)),
                  TextSpan(
                      text: controller
                              .billDetails.value.orderResponse!.description ??
                          "",
                      style: const TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w600))
                ])),
                const SizedBox(height: 8.0),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Bill No : ",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff004792),
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: controller.billDetails.value.billNo.toString(),
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600))
                ])),
              ],
            ),
            RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: " Contact : ",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xff004792),
                      fontWeight: FontWeight.w600)),
              TextSpan(
                  text: controller.billDetails.value.customerMobileNo ?? "",
                  style: const TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.w600))
            ])),
            const SizedBox(height: 8.0),
          ],
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }

  Widget orderStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          const TextSpan(
              text: "Order Status: ",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff004792),
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: controller.billDetails.value.orderResponse!.status ?? "",
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600))
        ])),
        const SizedBox(height: 10.0),
      ],
    );
  }

  Widget billEmployeeDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: RichText(
              text: TextSpan(children: [
            const TextSpan(
                text: "Employee Name : ",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff004792),
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    controller.billDetails.value.orderResponse!.employeeName ??
                        "",
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w600))
          ])),
        ),
        Flexible(
          child: RichText(
              text: TextSpan(children: [
            const TextSpan(
                text: "Added Date: ",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff004792),
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    controller.billDetails.value.orderResponse!.addedDateTime ??
                        "",
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w600))
          ])),
        ),
      ],
    );
  }

  billListable(List<BillOrderResponse> inHand) {
    return Column(
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
        DataTable(
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
              DataColumn(
                  label: Text(
                "Price",
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
            ],
            rows: List.generate(inHand.length, (index) {
              return DataRow(cells: <DataCell>[
                DataCell(Align(
                    alignment: Alignment.center,
                    child: Text(inHand[index].title ?? ""))),
                DataCell(Align(
                    alignment: Alignment.center,
                    child: Text(inHand[index].quantity.toString()))),
                DataCell(Align(
                    alignment: Alignment.center,
                    child: Text(inHand[index].price.toString()))),
              ]);
            })),
        Container(
          alignment: AlignmentDirectional.bottomEnd,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: "Sub Total : ",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff004792),
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: controller.billDetails.value.subTotal.toString(),
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w600))
              ])),
              const SizedBox(height: 8.0),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: "Discounts : ",
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xff004792),
                        fontWeight: FontWeight.w800)),
                TextSpan(
                    text: controller.billDetails.value.discounts.toString(),
                    style: const TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.w800))
              ])),
              const SizedBox(height: 8.0),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: "Tax : ",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff004792),
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: controller.billDetails.value.tax.toString(),
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w600))
              ])),
              const SizedBox(height: 8.0),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: "Grand Total : ",
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xff004792),
                        fontWeight: FontWeight.w800)),
                TextSpan(
                    text: controller.billDetails.value.grandTotal.toString(),
                    style: const TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.w800))
              ])),
            ],
          ),
        ),
      ],
    );
  }

  Widget paymentForm(BuildContext context) {
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
              TextFormField(
                readOnly: selectedPaymentMethod=='cash'?true:false,
                controller: bankNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter bank name';
                  } else {
                    return null;
                  }
                },
                decoration: customInputDecoration(labelText: "Bank Name"),
              ),
              const SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
              value: selectedPaymentMethod,
              onChanged: (String? newValue) {
                  selectedPaymentMethod = newValue!;
              },
              items: ['Cash', 'Cheque','Voucher']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: customInputDecoration()
            ),
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
                decoration: customInputDecoration(labelText: "Payment Number"),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: contactController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter contact details';
                  } else {
                    return null;
                  }
                },
                decoration: customInputDecoration(labelText: "Contact No"),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      if (controller.paymentController.isLoading.value ==
                          false) {
                        controller.paymentController.isLoading.value = true;
                        PaymentSaveRequest saveRequest = PaymentSaveRequest();
                        saveRequest.amount = amountController.text;
                        saveRequest.bankName = bankNameController.text;
                        saveRequest.paymentMethod =selectedPaymentMethod;
                        saveRequest.mobileNumber = contactController.text;
                        saveRequest.paymentNumber =
                            paymentNumberController.text;
                        saveRequest.employeeId = controller
                            .billDetails.value.orderResponse!.employeeId!;
                        saveRequest.billId = controller.billDetails.value.id!;

                        var res = await controller.paymentController
                            .savePayment(saveRequest);
                        if (res != null) {
                          Get.back();
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
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 18.0),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
