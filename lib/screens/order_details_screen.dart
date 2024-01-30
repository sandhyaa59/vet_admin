import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:vet_pharma/controller/order_controller.dart';
import 'package:vet_pharma/model/bill_save_response.dart';
import 'package:vet_pharma/model/order_response.dart';

import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/utils/theme.dart';
import 'package:vet_pharma/widgets/cancel.dart';
import 'package:vet_pharma/widgets/text.dart';

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
          child: OrientationBuilder(builder: (context, orientaion) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: buttons(context),
                  ),
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
                                    employeeDetails(true),
                                    const Divider(),
                                    const SizedBox(height: 8.0),
                                    customerOrderDetails(constraints, true),
                                    const Divider(),
                                    const SizedBox(height: 8.0),
                                    orderStatus(true),
                                    const Divider(),
                                    const SizedBox(height: 8.0),
                                    orderListStockTable(controller
                                            .selectedOrder.value.responses ??
                                        [])
                                  ],
                                ),
                              );
                            } else {
                              return Container(
                                width: Get.size.width,
                                padding: const EdgeInsets.all(kPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    employeeDetails(false),
                                    const Divider(),
                                    const SizedBox(height: 8.0),
                                    customerOrderDetails(constraints, false),
                                    const Divider(),
                                    const SizedBox(height: 8.0),
                                    orderStatus(false),
                                    const Divider(),
                                    const SizedBox(height: 8.0),
                                    orderListStockTable(controller
                                            .selectedOrder.value.responses ??
                                        [])
                                  ],
                                ),
                              );
                            }
                          }))),
                ],
              ),
            );
          }),
        );
      }),
    );
  }

  Widget buttons(BuildContext context) {
    return controller.selectedOrder.value.status == "PENDING"
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: ElevatedButton(
                    onPressed: () {
                      Get.dialog(createBillForm(context));
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
                        'Create Bill',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff596cff),
                        ),
                      ),
                    )),
              ),
              const SizedBox(width: 20.0),
              SizedBox(
                // width: 80,
                child: ElevatedButton(
                    onPressed: () async {
                      Get.dialog(askConfirmation(
                          "Are you sure you want to cancel order ?",
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("No")),
                          TextButton(
                              onPressed: () async {
                              var res=  await controller.cancel(controller.selectedOrder.value.id!);
                              
                                if(res!=null){Get.back();
                                  Get.offAllNamed(Routes.ORDER);
                                }
                              },
                              child: const Text("Yes"))));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.red))),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Cancel Order',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.red,
                        ),
                      ),
                    )),
              ),
            ],
          )
        : const SizedBox();
  }

  Widget employeeDetails(bool flag) {
    return flag
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              showTitleContent("Employee Name : ",
                  controller.selectedOrder.value.employeeName ?? ""),
              showTitleContent("Place of Visit : ",
                  controller.selectedOrder.value.placeOfVisit ?? "")
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showTitleContent("Employee Name : ",
                  controller.selectedOrder.value.employeeName.toString()),
              const SizedBox(height: 10.0),
              showTitleContent("Place of Visit : ",
                  controller.selectedOrder.value.placeOfVisit.toString())
            ],
          );
  }

  Widget customerOrderDetails(BoxConstraints constraints, bool flag) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showTitleContent("Customer Name : ",
            controller.selectedOrder.value.customerName ?? ""),
        const SizedBox(height: 10.0),
        showTitleContent("Customer Address : ",
            controller.selectedOrder.value.customerAddress ?? ""),
            const SizedBox(height: 10.0),
        showTitleContent("Shop Name : ", controller.selectedOrder.value.shopName ??""),
        const SizedBox(height: 10.0),
        showTitleContent("Customer Pan : ", controller.selectedOrder.value.customerPan ??"")
            // controller.selectedOrder.value. ?? ""),
      ],
    );
  }

  Widget orderStatus(bool flag) {
    return flag
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              showTitleContent("Order Status : ",
                  controller.selectedOrder.value.status ?? ""),
              showTitleContent("Added Date : ",
                  controller.selectedOrder.value.addedDateTime ?? ""),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showTitleContent("Added Date : ",
                  controller.selectedOrder.value.addedDateTime ?? ""),
              const SizedBox(height: 8.0),
              showTitleContent("Order Status : ",
                  controller.selectedOrder.value.status ?? ""),
            ],
          );
  }

  orderListStockTable(List<OrderedItem> inHand) {
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
        const Text("Description: ",
            style: TextStyle(
                fontSize: 16.0,
                color: Color(0xff004792),
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 6.0),
        Container(
          // height: 70,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
              border: Border.all(
                color:const Color(0xff004792),
              ),
              borderRadius: BorderRadius.circular(8.0)),
          child: Text(controller.selectedOrder.value.description ?? "",
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  BillAddRequest addRequest = BillAddRequest();
  Widget createBillForm(BuildContext context) {
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
                    child: TextFormField(
                      controller: billController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Bill Number";
                        }
                      },
                      decoration:
                          customInputDecoration(labelText: "Bill Number"),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.next,
                          // autofocus: true,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Sub Total";
                        }
                      },
                      controller: subtotalController,
                      decoration: customInputDecoration(labelText: "Sub Total"),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    child: TextFormField(keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.next,
                          // autofocus: true,
                      controller: taxController,
                      decoration: customInputDecoration(labelText: "Tax"),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    child: TextFormField(keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.next,
                          // autofocus: true,
                      controller: discountController,
                      decoration: customInputDecoration(labelText: "Discount"),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    child: TextFormField(keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.next,
                          // autofocus: true,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Grand Total";
                        }
                      },
                      controller: grandTotalController,
                      decoration:
                          customInputDecoration(labelText: "Grand Total"),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: Get.size.width * 0.3,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            if (controller.billingController.isLoading.value ==
                                false) {
                              controller.billingController.isLoading.value =
                                  true;
                              BillAddRequest addRequest = BillAddRequest();
                              addRequest.customer = nameController.text;
                              addRequest.grandTotal = grandTotalController.text;
                              addRequest.subTotal = subtotalController.text;
                              addRequest.tax = taxController.text;
                              addRequest.billNo = billController.text;
                              addRequest.discounts = discountController.text;
                              addRequest.orderId =
                                  controller.selectedOrder.value.id;
                              var res = await controller.billingController.saveBill(addRequest);
                               Get.back();
                              if (res != null) {
                               
                                // await controller.initData();
                                Get.offAndToNamed(Routes.ORDER);
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
                    child: TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Bill Number";
                        }
                      },
                      controller: billController,
                      decoration:
                          customInputDecoration(labelText: "Bill Number"),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    child: TextFormField(keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.next,
                          // autofocus: true,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Sub Total";
                        }
                      },
                      controller: subtotalController,
                      decoration: customInputDecoration(labelText: "Sub Total"),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    child: TextFormField(keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.next,
                          // autofocus: true,
                      controller: taxController,
                      decoration: customInputDecoration(labelText: "Tax"),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    child: TextFormField(keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.next,
                          // autofocus: true,
                      controller: discountController,
                      decoration: customInputDecoration(labelText: "Discount"),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    child: TextFormField(keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.next,
                          // autofocus: true,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Grand Total";
                        }
                      },
                      controller: grandTotalController,
                      decoration:
                          customInputDecoration(labelText: "Grand Total"),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: SizedBox(
                      height: 50.0,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              if (controller
                                      .billingController.isLoading.value ==
                                  false) {
                                controller.billingController.isLoading.value =
                                    true;
                                BillAddRequest addRequest = BillAddRequest();
                                addRequest.customer = nameController.text;
                                addRequest.grandTotal =
                                    grandTotalController.text;
                                addRequest.subTotal = subtotalController.text;
                                addRequest.tax = taxController.text;
                                addRequest.billNo = billController.text;
                                addRequest.discounts = discountController.text;
                                addRequest.orderId =
                                    controller.selectedOrder.value.id;
                                var res = await controller.billingController
                                    .saveBill(addRequest);
                                print(res);  Get.back();
                                if (res != null) {
                                  // await controller.initData();
                                  Get.offAndToNamed(Routes.ORDER);
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