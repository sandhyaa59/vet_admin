import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/home_controller.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/widgets/appbar.dart';
import 'package:vet_pharma/widgets/organization.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBars(context),
        drawer: MyDrawer(),
        body: Obx((() {
          return LoadingOverlay(
            isLoading: controller.isLoading.value,
            child: SingleChildScrollView(
              child: LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return Container(
                    padding: const EdgeInsets.all(kPadding),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        organizationDetails(),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Get.size.width * 0.45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Check In - Check Out ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.0),
                                      ),
                                      const SizedBox(width: 10.0),
                                      TextButton(
                                          onPressed: () {
                                            Get.toNamed(Routes.CHECKINCHECKOUT);
                                          },
                                          child: const Text(
                                            "View All ",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.0),
                                          )),
                                    ],
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    elevation: 2.0,
                                    child: LayoutBuilder(
                                        builder: (context, constraints) {
                                      return Container(
                                          width: Get.size.width * 0.45,
                                          padding: const EdgeInsets.all(12),
                                          child: checkInCheckOutTable(
                                              constraints));
                                    }),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: Get.size.width * 0.45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Orders",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.0),
                                      ),
                                      const SizedBox(width: 10.0),
                                      TextButton(
                                          onPressed: () {
                                            Get.toNamed(Routes.ORDER);
                                          },
                                          child: const Text(
                                            "View All ",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.0),
                                          )),
                                    ],
                                  ),
                                  Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      elevation: 2.0,
                                      child: LayoutBuilder(
                                          builder: (context, constraints) {
                                        return Container(
                                            width: Get.size.width * 0.45,
                                            padding: const EdgeInsets.all(12),
                                            child: orderTable(constraints));
                                      })),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(child: organizationDetails()),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Check In Check Out ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.CHECKINCHECKOUT);
                                      },
                                      child: const Text(
                                        "View All ",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0),
                                      )),
                                ],
                              ),
                            ),
                            Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                elevation: 2.0,
                                child: Container(
                                    width: double.maxFinite,
                                    child: checkInCheckOutTable(constraints))),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SingleChildScrollView(
                          child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Orders",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.ORDER);
                                  },
                                  child: const Text(
                                    "View All ",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0),
                                  )),
                            ],
                          ),
                        ),
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 2.0,
                            child: Container(
                                width: double.maxFinite,
                                padding: const EdgeInsets.all(12),
                                child: orderTable(constraints))),
                      ]))
                    ],
                  );
                }
              }),
            ),
          );
        })));
  }

  Widget checkInCheckOutTable(BoxConstraints constraints) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'SN',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Employee Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'CheckIn DateTime',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'CheckOut Time',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: List.generate(controller.checkInOut.length, (index) {
              return DataRow(cells: <DataCell>[
                DataCell(Text('${index + 1}')),
                DataCell(SizedBox(
                    // width: constraints.maxWidth * 0.3,
                    child: SingleChildScrollView(
                        child: Text(
                      controller.checkInOut[index].employeeName ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )))),
                DataCell(Text(controller.checkInOut[index].checkInTime ?? "")),
                DataCell(SizedBox(
                    width: constraints.maxWidth * 0.25,
                    child: InkWell(
                      onTap: () {
                        Get.dialog(checkInOutDescription(
                            controller.checkInOut[index].checkInDescription ??
                                ""));
                      },
                      child: Text(
                        controller.checkInOut[index].checkInDescription ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))),
                DataCell(Text(controller.checkInOut[index].checkoutTime ?? "")),
                DataCell(
                  SizedBox(
                      width: constraints.maxWidth * 0.25,
                      child: InkWell(
                        onTap: () {
                          Get.dialog(checkInOutDescription(controller
                                  .checkInOut[index].checkoutDescription ??
                              ""));
                        },
                        child: Text(
                          controller.checkInOut[index].checkoutDescription ??
                              "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                )
              ]);
            })));
  }

  Widget checkInOutDescription(String descritption) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      title: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xff596cff),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Description",
                textAlign: TextAlign.center,
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
      content:SizedBox(
             width: Get.size.width * 0.2,
            height:  Get.size.height * 0.15,
            child: SingleChildScrollView( scrollDirection: Axis.vertical,child: Text(descritption))),
    );
  }

  Widget orderTable(BoxConstraints constraints) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'SN',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  child: Text(
                    'Employee Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Customer',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Date Time',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Status',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: List.generate(controller.orderList.length, (index) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(SizedBox(child: Text('${index + 1}'))),
                  DataCell(SizedBox(
                      width: constraints.maxWidth * 0.25,
                      child: Text(
                        controller.orderList[index].employeeName ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ))),
                  DataCell(SizedBox(
                    width: constraints.maxWidth * 0.25,
                    child: Text(
                      controller.orderList[index].customerName ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
                  DataCell(Text(
                    controller.orderList[index].addedDateTime ?? "",
                  )),
                  DataCell(Text(
                    controller.orderList[index].status ?? "",
                  )),
                ],
              );
            })));
  }
}
