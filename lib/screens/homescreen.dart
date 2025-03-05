import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/home_controller.dart';
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
                double cardWidth = constraints.maxWidth > 600 ? (constraints.maxWidth / 4) : constraints.maxWidth;
                if (constraints.maxWidth > 600) {
                  return Container(
                    // padding: const EdgeInsets.all(kPadding),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: organizationDetails(),
                        ),
                        const SizedBox(height: 10.0,),
                       Wrap(spacing: 5,runSpacing: 5,
                        children: [
                            buildStatCard('Total Orders', (controller.reportStat.value.totalOrders??0).toString(), 200),
                    buildStatCard('Total Revenue', (controller.reportStat.value.totalRevenue??0.0).toString(), 200),
                    buildStatCard('Total Discount', (controller.reportStat.value.totalDiscount??0.0).toString(), 200),
                    buildStatCard('Total Tax', (controller.reportStat.value.totalTax??0.0).toString(), 200),
                   
                    // ...(controller.reportStat.value.mostOrderedItems??[]).map((item) {
                    //   return buildMostOrderedItemCard(item, cardWidth);
                    // }).toList(),   
                      ],
                       ),
                    // Build Most Ordered Items in a horizontal list
                    // buildMostOrderedItemCard('item', 200),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                width: Get.size.width * 0.3,
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
                                              fontSize: 16.0),
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
                                                  fontSize: 12.0),
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
                                            width: Get.size.width * 0.35,
                                            padding: const EdgeInsets.all(12),
                                            child: checkInCheckOutTable(
                                                constraints));
                                      }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: Get.size.width * 0.3,
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
                                              fontSize: 16.0),
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
                                                  fontSize: 12.0),
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
                                              width: Get.size.width * 0.35,
                                              // padding: const EdgeInsets.all(8),
                                              child: orderTable(constraints));
                                        })),
                                  ],
                                ),
                              ),
                            ),
                             Expanded(
                               child: Container(
                                width: Get.size.width * 0.3,
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
                                          "Most Order Items",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0),
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
                                                  fontSize: 12.0),
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
                                              child: mostOrderItemTable(constraints));
                                        })),
                                  ],
                                ),
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
                      const SizedBox(height: 10.0,),
                       Wrap(spacing: 2,runSpacing: 5,
                        children: [
                           buildStatCard('Total Orders', (controller.reportStat.value.totalOrders??0).toString(), 150),
                    buildStatCard('Total Revenue', (controller.reportStat.value.totalRevenue??0.0).toString(), 150),
                    buildStatCard('Total Discount', (controller.reportStat.value.totalDiscount??0.0).toString(), 150),
                    buildStatCard('Total Tax', (controller.reportStat.value.totalTax??0.0).toString(), 150),
                        ]),
                    //    ...(controller.reportStat.value.mostOrderedItems??[]).map((item) {
                    //   return buildMostOrderedItemCard(item, cardWidth);
                    // }).toList(),  ],
                      //  ),
                    // Build Most Ordered Items in a horizontal list
                    // ...(controller.reportStat.value.mostOrderedItems??[]).map((item) {
                    //   return buildMostOrderedItemCard(item, cardWidth);
                    // }).toList(),
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
                                    // width: double.maxFinite,
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
                      ])),

                       SingleChildScrollView(
                          child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Most Order Item",
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
                                child: mostOrderItemTable(constraints))),
                      ])),
                    ],
                  );
                }
              }),
            ),
          );
        })));
  }

  Widget buildStatCard(String title, String value, double width) {
    return Container(
      width: width,alignment: Alignment.center,
      height:Get.size.height*0.18,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blueAccent,
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
         
          Text(
            value,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Card builder for most ordered items
  // Widget buildMostOrderedItemCard( item, double width) {
  //   return Container(
  //     width: width,
  //     margin: const EdgeInsets.all(8.0),
  //     padding: const EdgeInsets.all(16.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(12),
  //       color: Colors.blue,
  //     ),
  //     child: const Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Item: ',
  //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(height: 8),
  //         Text('Quantity: '),
  //         Text('Price: '),
  //       ],
  //     ),
  //   );
  // }

  Widget checkInCheckOutTable(BoxConstraints constraints) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable( columnSpacing: 15, 
            columns: const <DataColumn>[
             
              DataColumn(
                label: Text(
                  'Employee Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'CheckIn At',
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
                  'CheckOut At',
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
      content:SizedBox(
             width: Get.size.width * 0.2,
            height:  Get.size.height * 0.15,
            child: SingleChildScrollView( scrollDirection: Axis.vertical,child: Text(descritption,style: const TextStyle(
              color: Colors.black,fontSize: 14.0
            ),))),
    );
  }

  Widget orderTable(BoxConstraints constraints) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 10,
            columns: const <DataColumn>[
             
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


  Widget mostOrderItemTable(BoxConstraints constraints) {
  final mostOrderedItems = controller.reportStat.value.mostOrderedItems;

  if (mostOrderedItems == null || mostOrderedItems.isEmpty) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      child: const Text(
        'No data available',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
      columnSpacing: 10,
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Item',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Qty',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Price',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: List.generate(mostOrderedItems.length, (index) {
        return DataRow(
          cells: <DataCell>[
            DataCell(SizedBox(
              width: constraints.maxWidth * 0.25,
              child: Text(
                mostOrderedItems[index].name ?? "",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )),
            DataCell(SizedBox(
              width: constraints.maxWidth * 0.25,
              child: Text(
                mostOrderedItems[index].quantity.toString(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )),
            DataCell(Text(
              mostOrderedItems[index].price.toString(),
            )),
          ],
        );
      }),
    ),
  );
}

}
