import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/payment_controller.dart';
import 'package:vet_pharma/controller/payment_detail_controller.dart';
import 'package:vet_pharma/model/bill_details_response.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/widgets/appbar.dart';
import 'package:vet_pharma/widgets/text.dart';

class PaymentDetailsScreen extends StatelessWidget {
  PaymentDetailsScreen({super.key});

  final controller = Get.find<PaymentDetailController>();

  final paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff596cff),
          title: const Text("Payment Details"),
        ),
        body: Obx(() {
          return LoadingOverlay(
              isLoading: controller.isLoading.value,
              child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.center,
                    child: Card(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        child: LayoutBuilder(builder: (context, constraints) {
                          if (constraints.maxWidth > 600) {
                            return Container(
                                width: Get.size.width * 0.85,
                                padding: const EdgeInsets.all(kPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    billEmployeeDetails(),
                                    const Divider(),
                                    const SizedBox(height: 10.0),
                                    customerDetails(),
                                    const Divider(),
                                    const SizedBox(height: 10.0),
                                    orderStatus(),
                                    const Divider(),
                                    const SizedBox(height: 20.0),
                                    paymentDetail(),
                                    const Divider(),
                                    const SizedBox(height: 20.0),
                                    billListable(controller.billList),
                                    const SizedBox(height: 10.0),
                                  ],
                                ));
                          } else {
                            return Container(
                                padding: const EdgeInsets.all(kPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    billEmployeeDetails(),
                                    const Divider(),
                                    const SizedBox(height: 10.0),
                                    customerDetails(),
                                    const Divider(),
                                    const SizedBox(height: 10.0),
                                    orderStatus(),
                                    const Divider(),
                                    const SizedBox(height: 20.0),
                                    paymentDetail(),
                                    const Divider(),
                                    const SizedBox(height: 20.0),
                                    billListable(controller.billList),
                                    const SizedBox(height: 10.0),
                                  ],
                                ));
                          }
                        }))),
              ));
        }));
  }

  Widget paymentDetail() {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Payment Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Color(0xff004792),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: showTitleContent(
                    "Added By : ",
                    paymentController.selectedPaymentData.value.addedBy
                        .toString(),
                  ),
                ),
                showTitleContent(
                  "Added At : ",
                  paymentController.selectedPaymentData.value.addedAt
                      .toString(),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            showTitleContent(
              "Bank Name : ",
              paymentController.selectedPaymentData.value.bankName.toString(),
            ),
            const SizedBox(height: 10.0),
            showTitleContent(
              "Payment Method : ",
              paymentController.selectedPaymentData.value.paymentMode
                  .toString(),
            ),
            const SizedBox(height: 10.0),
            showTitleContent(
              "Payment Number : ",
              paymentController.selectedPaymentData.value.paymentNumber
                  .toString(),
            ),
            const SizedBox(height: 10.0),
            showTitleContent(
              "Amount : ",
              paymentController.selectedPaymentData.value.amount.toString(),
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Payment Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Color(0xff004792),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            showTitleContent(
              "Added By : ",
              paymentController.selectedPaymentData.value.addedBy.toString(),
            ),
            const SizedBox(height: 10.0),
            showTitleContent(
              "Added At : ",
              paymentController.selectedPaymentData.value.addedAt.toString(),
            ),
            const SizedBox(height: 10.0),
            showTitleContent(
              "Bank Name : ",
              paymentController.selectedPaymentData.value.bankName.toString(),
            ),
            const SizedBox(height: 10.0),
            showTitleContent(
              "Payment Method : ",
              paymentController.selectedPaymentData.value.paymentMode
                  .toString(),
            ),
            const SizedBox(height: 10.0),
            showTitleContent(
              "Payment Number : ",
              paymentController.selectedPaymentData.value.paymentNumber
                  .toString(),
            ),
            const SizedBox(height: 10.0),
            showTitleContent(
              "Amount : ",
              paymentController.selectedPaymentData.value.amount.toString(),
            ),
          ],
        );
      }
    });
  }

  Widget customerDetails() {
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
                        controller.billDetails.value.orderResponse
                                ?.customerName ??
                            ""),
                    const SizedBox(height: 8.0),
                    showTitleContent("Email : ",
                        controller.billDetails.value.customerEmail ?? ""),
                    const SizedBox(height: 8.0),
                     showTitleContent("Shop Name : ",
                        controller.billDetails.value.orderResponse?.shopName ?? ""),
                    const SizedBox(height: 8.0),
                     showTitleContent("Customer Pan : ",
                        controller.billDetails.value.orderResponse?.customerPan ?? ""),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showTitleContent(
                        "Added Date : ",
                        controller.billDetails.value.orderResponse
                                ?.addedDateTime ??
                            ""),
                    const SizedBox(height: 8.0),
                    showTitleContent("Contact : ",
                        controller.billDetails.value.customerMobileNo ?? ""),

                  ],
                )
              ],
            ),
            const SizedBox(height: 10.0),
          ],
        );
      } else {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          showTitleContent("Customer Name : ",
              controller.billDetails.value.orderResponse?.customerName ?? ""),
          const SizedBox(height: 8.0),
          showTitleContent("Added Date : ",
              controller.billDetails.value.orderResponse?.addedDateTime ?? ""),
          const SizedBox(height: 8.0),
          showTitleContent("Contact : ",
              controller.billDetails.value.customerMobileNo ?? ""),
          const SizedBox(height: 8.0),
          
          showTitleContent(
              "Email : ", controller.billDetails.value.customerEmail ?? ""),
          const SizedBox(height: 8.0),
          showTitleContent("Shop Name : ",
                        controller.billDetails.value.orderResponse?.shopName ?? ""),
                         const SizedBox(height: 8.0),
                     showTitleContent("Customer Pan : ",
                         controller.billDetails.value.orderResponse?.shopName ?? ""),
        ]);
      }
    });
  }

  Widget orderStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        showTitleContent(
          "Bill No : ",
          controller.billDetails.value.billNo.toString(),
        ),
        const SizedBox(height: 10.0),
        showTitleContent(
          "Order Status: ",
          controller.billDetails.value.orderResponse?.status ?? "",
        ),
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
            child: showTitleContent(
              "Employee Name : ",
              controller.billDetails.value.orderResponse?.employeeName ?? "",
            ),
          )
        ]);
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
        SingleChildScrollView(
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
        const SizedBox(height: 15.0),
        Container(
          alignment: AlignmentDirectional.bottomEnd,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showTitleContent(
                "Sub Total : ",
                controller.billDetails.value.subTotal.toString(),
              ),
              const SizedBox(height: 8.0),
              showTitleContent(
                "Discounts : ",
                controller.billDetails.value.discounts.toString(),
              ),
              const SizedBox(height: 8.0),
              showTitleContent(
                "Tax : ",
                controller.billDetails.value.tax.toString(),
              ),
              const SizedBox(height: 8.0),
              showTitleContent(
                "Grand Total : ",
                controller.billDetails.value.grandTotal.toString(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
