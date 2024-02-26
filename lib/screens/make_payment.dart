import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/payment_controller.dart';
import 'package:vet_pharma/model/payment_save_request.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/utils/theme.dart';

class MakePayment extends StatelessWidget {
   MakePayment({super.key});
final _formKey = GlobalKey<FormState>();
  final controller = Get.find<PaymentController>();
 final TextEditingController amountController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController paymentNumberController = TextEditingController();

  final TextEditingController contactController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double cardHeight =
                constraints.maxHeight > 400 ? 400 : constraints.maxWidth * 0.8;
            double cardWidth =
                constraints.maxWidth > 400 ? 400 : constraints.maxWidth * 0.8;

            return SingleChildScrollView(
              child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(16),
                  child: Container(
                    width: cardWidth,
                    height: cardHeight,
                    padding: const EdgeInsets.all(16),
                    child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              // TypeAheadField<Bill>(
              //   textFieldConfiguration: TextFieldConfiguration(
              //     controller: searchController,
              //     decoration: customInputDecoration(
              //       hintText: 'Search bill...',
              //       iconButton: IconButton(
              //         onPressed: () {
              //           if (searchController.text.isNotEmpty) {
              //             controller.billSearch(searchController.text);
              //           }
              //         },
              //         icon: const Icon(Icons.search),
              //       ),
              //     ),
              //   ),
              //   suggestionsCallback: (pattern) async {
              //     return await controller.billList;
              //   },
              //   itemBuilder: (context, suggestion) {
              //     return ListTile(
              //       title: Text(suggestion.billNo ?? ""),
              //     );
              //   },
              //   onSuggestionSelected: (suggestion) {
              //     controller.selectedBill.value = suggestion;
              //   },
              // ),

              TextFormField(
                // autofillHints: [
                //   controller.bill.value.billNo.toString()
                // ],
                controller: searchController,
                onFieldSubmitted: (v) {
                  if (searchController.text.isNotEmpty) {
                    controller.billSearch(searchController.text);
                  }
                },
                decoration: customInputDecoration(
                  hintText: 'Search bill...',
                  iconButton: IconButton(
                      onPressed: () {
                        if (searchController.text.isNotEmpty) {
                          controller.billSearch(searchController.text);
                        }
                      },
                      icon: const Icon(Icons.search)),
                ),
              ),
              
      
             
              //     ? Obx(() {
              //         return SizedBox(
              //           height: 50,
              //           child: ListView.builder(
              //               itemCount: controller.billList.length,
              //               itemBuilder: (context, index) {
              //                 return ListTile(
              //                   title: Text(controller
              //                       .billList[index].billNo
              //                       .toString()),
              //                   subtitle: Text(controller
              //                       .billList[index].createdAt
              //                       .toString()),
              //                 );
              //               }),
              //         );
              //       })
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
                  labelText:"Payment Number",
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
                    visible: controller.selectedPaymentMethod.value != 'Cash',
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
                      decoration: customInputDecoration(labelText: "Bank Name"),
                    ),
                  )),
              const SizedBox(height: 20.0),
              Center(
                child: SizedBox(
                  width:
                    Get.size.width * 0.3 ,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (controller.isLoading.value == false) {
                            controller.isLoading.value = true;
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

                            var res = await controller.savePayment(saveRequest);
                            Get.back();
                            if (res != null) {
                              Get.offAndToNamed(Routes.PAYMENT);
                            }
                            _formKey.currentState!.reset();
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
                  )),
            );
          },
        ),
      ),
    );
  }
}