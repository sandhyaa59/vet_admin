import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vet_pharma/controller/discount_controller.dart';
import 'package:vet_pharma/model/discount_request.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/utils/theme.dart';
import 'package:vet_pharma/widgets/appbar.dart';

class DiscountList extends StatelessWidget {
  DiscountList({super.key});

  final controllers = Get.find<DiscountController>();
  // final controller = Get.find<PaymentController>();

  final formKeys = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController discountTypeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBars(context),
      body: SingleChildScrollView(
        child: Obx(() {
          return LoadingOverlay(
            isLoading: controllers.isLoading.value,
            child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.dialog(addDiscountForm(context));
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
                              'Add Discount',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff596cff),
                              ),
                            ),
                          ),
                        ),
                      ),
                      discountTable(context)
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
                        child: ElevatedButton(
                          onPressed: () {
                            Get.dialog(addDiscountForm(context));
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
                              'Add Discount',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff596cff),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    discountTable(context)
                  ],
                );
              }
            }),
          );
        }),
      ),
    );
  }

  Widget discountTable(BuildContext context) {
    return Obx(() {
      if (controllers.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: Get.size.width,
            child: DataTable(
              columnSpacing: 15.0, // A
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'SN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Discount Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Discount Amount',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Type',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Action',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              // Define the number of rows per page
              rows: List.generate(
                  controllers.dis.length,
                  (index) => DataRow(
                        cells: <DataCell>[
                          DataCell(Text('${index + 1}')),
                          DataCell(Text(controllers.dis[index].name!)),
                          DataCell(
                              Text(controllers.dis[index].amount.toString())),
                          DataCell(
                              Text(controllers.dis[index].type.toString())),
                          DataCell(
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                                size: 16.0,
                              ),
                              onPressed: () async {
                                controllers.discountList.value =
                                    controllers.dis[index];
                                nameController.text =
                                    controllers.discountList.value.name ?? "";

                                amountController.text = controllers
                                    .discountList.value.amount
                                    .toString();

                                Get.dialog(updateDiscountForm(context));

                                // var context;
                                // Get.dialog(updateEmployeeForm(context));
                              },
                            ),
                          ),
                        ],
                      )),
            ),
          ),
        );
      }
    });
  }

  Widget addDiscountForm(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
              const Text(
                "Add Discount",
                textAlign: TextAlign.center,
              ),
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
          key: formKeys,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFormField(
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Name';
                        } else {
                          return null;
                        }
                      },
                      decoration: customInputDecoration(
                        labelText: "Name",
                      )),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // DropdownButtonFormField<String>(
                //     value: controllers.selectedDiscountType.value,
                //     onChanged: (String? newValue) {
                //       controllers.selectedDiscountType.value = newValue!;
                //     },
                //     items: ['PERCENTAGE', 'FLAT']
                //         .map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     decoration: customInputDecoration()),
                // const SizedBox(
                //   height: 20.0,
                // ),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFormField(
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      controller: amountController,
                      decoration: customInputDecoration(
                        labelText: "Amount",
                      )),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                buildSubmitButton(context, constraints),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildSubmitButton(BuildContext context, BoxConstraints constraints) {
    return SizedBox(
      width: constraints.maxWidth > 600 ? Get.size.width * 0.3 : null,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (formKeys.currentState!.validate()) {
            if (controllers.isLoading.value == false) {
              Get.back();
              controllers.isLoading.value = true;

              DiscountRequest discountRequest = DiscountRequest();
              discountRequest.name = nameController.text;
              discountRequest.amount = int.parse(amountController.text);
              discountRequest.discountType = 'PERCENTAGE';
              var res = await controllers.addDiscount(discountRequest);

              if (res != null) {
                controllers.fetchDiscounts();

                Get.offAllNamed(Routes.DISCOUNT);
              }
              controllers.fetchDiscounts();
              formKeys.currentState!.reset();
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff596cff),
        ),
        child: const Text(
          "Add Discount",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }

  Widget updateDiscountForm(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
              const Text(
                "Update Discount",
                textAlign: TextAlign.center,
              ),
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
          key: formKeys,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFormField(
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Name';
                        } else {
                          return null;
                        }
                      },
                      decoration: customInputDecoration(
                        labelText: "Name",
                      )),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // DropdownButtonFormField<String>(
                //     value: controllers.selectedDiscountType.value,
                //     onChanged: (String? newValue) {
                //       controllers.selectedDiscountType.value = newValue!;
                //     },
                //     items: ['PERCENTAGE', 'FLAT']
                //         .map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     decoration: customInputDecoration()),
                // const SizedBox(
                //   height: 20.0,
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: amountController,
                      decoration: customInputDecoration(
                        labelText: "Amount",
                      )),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKeys.currentState!.validate()) {
                        if (controllers.isLoading.value == false) {
                          Get.back();
                          controllers.isLoading.value = true;

                          DiscountRequest discountRequest = DiscountRequest();
                          discountRequest.name = nameController.text;
                          discountRequest.amount =
                              int.parse(amountController.text);
                          discountRequest.discountType = 'PERCENTAGE';
                          discountRequest.id =
                              controllers.discountList.value.id;

                          var res = await controllers.updateDiscount(
                              discountRequest,
                              controllers.discountList.value.id);

                          if (res != null) {
                            Get.offAllNamed(Routes.DISCOUNT);
                          }

                          formKeys.currentState!.reset();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff596cff),
                    ),
                    child: const Text(
                      "Update Discount",
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

// Widget buildUpdateButton(BuildContext context, BoxConstraints constraints) {
//   return SizedBox(
//     width: constraints.maxWidth > 600 ? Get.size.width * 0.3 : null,
//     height: 50,
//     child: ElevatedButton(
//       onPressed: () async {
//         if (formKeys.currentState!.validate()) {
//           if (controllers.isLoading.value ==
//                                 false) {
//                                   Get.back();
//                               controllers.isLoading.value =
//                                   true;

//             DiscountRequest discountRequest=DiscountRequest();
//             discountRequest.name=nameController.text;
//             discountRequest.amount= int.parse (  amountController.text);
//             discountRequest.discountType=   'PERCENTAGE';
//             discountRequest.id = controller.selectedEmployeeDetail.value.id!;
//             var res = await controllers.updateDiscount(discountRequest);

//             if (res != null) {

//               Get.offAllNamed(Routes.DISCOUNT);
//             }

//             formKeys.currentState!.reset();
//           }
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xff596cff),
//       ),
//       child: const Text(
//         "Update Discount",
//         style: TextStyle(fontSize: 18.0,color: Colors.white),
//       ),
//     ),
//   );
// }
}
