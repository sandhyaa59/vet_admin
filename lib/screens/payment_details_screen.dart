import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/payment_controller.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/widgets/appbar.dart';

class PaymentDetailsScreen extends StatelessWidget {
  PaymentDetailsScreen({super.key});

  final controller = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars(context),
      body: LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(kPadding),
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Container(
                  width: Get.size.width*0.5,
                  padding: const EdgeInsets.all(kPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                 const     Center(
                        child:  Text(
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
                            child: RichText(
                                text: TextSpan(children: [
                              const TextSpan(
                                  text: "Added By : ",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color(0xff004792),
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: controller.selectedPayment.value.addedBy
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600))
                            ])),
                          ),
                          RichText(
                              text: TextSpan(children: [
                            const TextSpan(
                              text: "  ",
                            ),
                            TextSpan(
                                text: controller.selectedPayment.value.addedAt
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600))
                          ])),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                            text: "Bank Name : ",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff004792),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: controller.selectedPayment.value.bankName
                                .toString(),
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600))
                      ])),
                      const SizedBox(height: 10.0),
                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                            text: "Payment Method : ",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff004792),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: controller.selectedPayment.value.paymentMode
                                .toString(),
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600))
                      ])),
                      const SizedBox(height: 10.0),
                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                            text: "Payment Number : ",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff004792),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: controller.selectedPayment.value.paymentNumber
                                .toString(),
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600))
                      ])),
                      const SizedBox(height: 10.0),
                      // RichText(
                      //     text: TextSpan(children: [
                      //   const TextSpan(
                      //       text: "Mobile Number : ",
                      //       style: TextStyle(
                      //           fontSize: 16.0,
                      //           color: Color(0xff004792),
                      //           fontWeight: FontWeight.bold)),
                      //   TextSpan(
                      //       text: controller.selectedPayment.value.mobileNumber
                      //           .toString(),
                      //       style: const TextStyle(
                      //           fontSize: 16.0, fontWeight: FontWeight.w600))
                      // ])),
                      // const SizedBox(height: 10.0),
                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                            text: "Amount : ",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff004792),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: controller.selectedPayment.value.amount
                                .toString(),
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600))
                      ])),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
