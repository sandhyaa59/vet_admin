import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vet_pharma/controller/order_controller.dart';
import 'package:vet_pharma/model/bill_save_response.dart';
import 'package:vet_pharma/model/order_response.dart';

import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/utils/theme.dart';

class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({super.key});

  final controller = Get.find<OrderController>();
  // final billingController = Get.find<BillingController>();

  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController billController = TextEditingController();
  final TextEditingController taxController = TextEditingController();
  final TextEditingController grandTotalController = TextEditingController();
  final TextEditingController subtotalController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff596cff),
        title: const Text("Order Details"),
      ),
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
                    controller.selectedOrder.value.status == "PENDING"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                // width: 80,
                                child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return createBillForm(context);
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
                                        'Create Bill',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xff596cff),
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(width: 20.0),
                              SizedBox(
                                // width: 80,
                                child: ElevatedButton(
                                    onPressed: () async{
                                      await controller.cancel(
                                        controller.selectedOrder.value.id!
                                      );
                    await controller.initData();
                    Get.toNamed(Routes.ORDER_DETAILS);
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
                          )
                        : SizedBox(),
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
                                employeeDetails(),
                                const Divider(),
                                const SizedBox(height: 8.0),
                                customerOrderDetails(),
                                const SizedBox(height: 20.0),
                                orderStatus(),
                                const Divider(),
                                const SizedBox(height: 8.0),
                                orderListStockTable(
                                    controller.selectedOrder.value.responses ??
                                        [])
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

  Widget employeeDetails() {
    return RichText(
        text: TextSpan(children: [
      const TextSpan(
          text: "Employee Name : ",
          style: TextStyle(
              fontSize: 16.0,
              color: Color(0xff004792),
              fontWeight: FontWeight.bold)),
      TextSpan(
          text: controller.selectedOrder.value.employeeName.toString(),
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600))
    ]));
  }

  Widget customerOrderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text("Ordered By",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff004792),
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: "Customer Name : ",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff004792),
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        controller.selectedOrder.value.customerName.toString(),
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
                        controller.selectedOrder.value.addedDateTime.toString(),
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w600))
              ])),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        RichText(
            text: TextSpan(children: [
          const TextSpan(
              text: "Customer Address : ",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff004792),
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: controller.selectedOrder.value.placeOfVisit.toString(),
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600))
        ])),
        const SizedBox(height: 10.0),
        Container(
          height: 70,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff004792),
              ),
              borderRadius: BorderRadius.circular(8.0)),
          child: RichText(
              text: TextSpan(children: [
            const TextSpan(
                text: "Description: ",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff004792),
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: controller.selectedOrder.value.description ?? "",
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w600))
          ])),
        ),
        const Divider()
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
              text: controller.selectedOrder.value.status.toString(),
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600))
        ])),
        const SizedBox(height: 10.0),
      ],
    );
  }

  orderListStockTable(List<OrderedItem> inHand) {
    return Column(
      children: [
        const Center(
          child: Text(
            "Stock In Hand",
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
                  color: Color(0xff004792),
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
      ],
    );
  }

  BillAddRequest addRequest = BillAddRequest();
  Widget createBillForm(BuildContext context) {
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
            const Text("Create Bill",
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
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter some text";
                    }
                  },
                  controller: grandTotalController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: customInputDecoration(labelText: "Grand Total"),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextFormField(
                  controller: subtotalController,
                  decoration: customInputDecoration(labelText: "Sub Total"),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextFormField(
                  controller: taxController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: customInputDecoration(labelText: "Tax"),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextFormField(
                  controller: discountController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: customInputDecoration(labelText: "Discount"),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextFormField(
                  controller: billController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: customInputDecoration(labelText: "Bill Number"),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (controller.billingController.isLoading.value ==
                          false) {
                        controller.billingController.isLoading.value = true;
                        BillAddRequest addRequest = BillAddRequest();
                        addRequest.customer = nameController.text;
                        addRequest.grandTotal = grandTotalController.text;
                        addRequest.subTotal = subtotalController.text;
                        addRequest.tax = taxController.text;
                        addRequest.billNo = billController.text;
                        addRequest.discounts = discountController.text;
                        addRequest.orderId = controller.selectedOrder.value.id;
                        var res = await controller.billingController
                            .saveBill(addRequest);
                        print(res);
                        if (res != null) {
                          Get.back();
                          await controller.initData();
                          Get.offAndToNamed(Routes.ORDER_DETAILS);
                        }
                        formKey.currentState!.reset();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff596cff),
                  ),
                  child: const Text(
                    "Create Bill",
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
