import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:vet_pharma/controller/report_controller.dart';
import 'package:vet_pharma/model/report_response.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';

class ReportDetailsScreen extends StatefulWidget {
  ReportDetailsScreen({super.key});

  @override
  State<ReportDetailsScreen> createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  final controller = Get.find<ReportController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff596cff),
        title: Text("Report Details"),
      ),
      body:Obx( () {
          return LoadingOverlay(
            isLoading: controller.isLoading.value,
            child: SingleChildScrollView(
              child: 
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(kPadding),
                      width: Get.size.width * 0.5,
                      child: Card(
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                          padding: const EdgeInsets.all(kPadding),
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              employeeDetails(),
                              const Divider(),
                              const SizedBox(height: 20.0),
                              customerDetails(), const Divider(),
                              const SizedBox(height: 10.0),
                              listStockTable(
                                  controller.selectedReport.value.responses ?? []),
                   const SizedBox(height: 20.0),
                                   Align(
                                    alignment: Alignment.bottomRight,
                                     child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:const  Color(0xff596cff),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0)
                                        )
                                      ),
                                                     onPressed: () async {
                                                       openMap(controller.selectedReport.value.latitude ?? 22.00,
                                                           controller.selectedReport.value.latitude ?? 22.00);
                                                     },
                                                     child: const Text("Open Map")),
                                   )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      
                 
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     'Current Location: ${currentLocation.latitude}, ${currentLocation.longitude}',
                  //     style: TextStyle(fontSize: 16.0),
                  //   ),
                  // ),
               
              // ),
            ),
          );
        }
      ),
    );
  }

  Widget customerDetails() {
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
                      text: controller.selectedReport.value.customerName
                          .toString(),
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600))
                ])),
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
                      text: controller.selectedReport.value.address.toString(),
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600))
                ])),
                const SizedBox(height: 10.0),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Description: ",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff004792),
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: controller.selectedReport.value.description
                          .toString(),
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600))
                ])),
                const Divider()
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                        text: "Added Date: ",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff004792),
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: controller.selectedReport.value.addedDateTime
                            .toString(),
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600))
                  ]),
                ),
                const SizedBox(height: 10.0),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Latitude: ",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff004792),
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: controller.selectedReport.value.latitude.toString(),
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600)),
                ])),
                const SizedBox(height: 10.0),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Longitude: ",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff004792),
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          controller.selectedReport.value.longitude.toString(),
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600)),
                ])),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }

  Widget employeeDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          const TextSpan(
              text: "Employee Name : ",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff004792),
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: controller.selectedReport.value.employeeName.toString(),
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600))
        ])),
        const SizedBox(height: 8.0),
        RichText(
            text: TextSpan(children: [
          const TextSpan(
              text: "Place of Visit : ",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff004792),
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: controller.selectedReport.value.placeOfVisit.toString(),
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600))
        ])),
      ],
    );
  }

  listStockTable(List<StockInHand> inHand) {
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
            ],
            rows: List.generate(inHand.length, (index) {
              return DataRow(cells: <DataCell>[
                DataCell(Align(
                    alignment: Alignment.center,
                    child: Text(inHand[index].title ?? ""))),
                DataCell(Align(
                    alignment: Alignment.center,
                    child: Text(inHand[index].quantity.toString()))),
              ]);
            })),
      ],
    );
  }
}
