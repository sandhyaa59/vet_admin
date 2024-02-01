import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/report_controller.dart';
import 'package:vet_pharma/model/report_response.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/widgets/text.dart';

class ReportDetail extends StatelessWidget {
  ReportDetail({super.key});
  final controller = Get.find<ReportController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar:AppBar(
        backgroundColor: const Color(0xff596cff),
        title: const Text("Report Details"),
      ),
      body: Obx(() {
        return LoadingOverlay(
            isLoading: controller.isLoading.value,
            child: SingleChildScrollView(
              child: Align(
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
                                employeeDetails(),
                                const Divider(),
                                const SizedBox(height: 8.0),
                                customerOrderDetails(),
                                const SizedBox(height: 20.0),
                                const Divider(),
                                listStockTable(
                                    controller.selectedData.value.responses ??
                                        []),
                                const SizedBox(height: 20.0),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            padding: const EdgeInsets.all(kPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                employeeDetails(),
                                const Divider(),
                                const SizedBox(height: 8.0),
                                customerOrderDetails(),
                                const SizedBox(height: 20.0),
                                const Divider(),
                                listStockTable(
                                    controller.selectedData.value.responses ??
                                        []),
                                // const SizedBox(height: 20.0),
                              ],
                            ),
                          );
                        }
                      })),
                ),
              
            ));
      }),
    ));
  }

  Widget employeeDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showTitleContent(
          "Employee Name : ",
          controller.selectedData.value.employeeName.toString(),
        ), const SizedBox(height: 10.0),
        showTitleContent(
              "Employee Address : ",
              controller.selectedData.value.address.toString(),
            ),        const SizedBox(height: 10.0),
        showTitleContent(
          "Longitude : ",
          controller.selectedData.value.longitude.toString(),
        ),
        const SizedBox(height: 10.0),
        showTitleContent(
          "Latitude : ",
          controller.selectedData.value.latitude.toString(),
        ),const SizedBox(height: 10.0),
         showTitleContent(
          "Place of visit : ",
          controller.selectedData.value.placeOfVisit.toString(),
        ),
        const SizedBox(height: 10.0),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff596cff),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              onPressed: () async {
                openMap(controller.selectedData.value.latitude ?? 22.00,
                    controller.selectedData.value.longitude ?? 22.00);
              },
              child: const Text("Open Map")),
        ),
      ],
    );
  }

  Widget customerOrderDetails() {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showTitleContent(
                  "Customer Name : ",
                  controller.selectedData.value.customerName.toString(),
                ),
                showTitleContent(
                  "Added Date: ",
                  controller.selectedData.value.addedDateTime.toString(),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            showTitleContent(
              "Customer Address : ",
              controller.selectedData.value.customerAddress.toString(),
            ),const SizedBox(height: 10.0),
            showTitleContent(
              "Shop Name : ",
              controller.selectedData.value.shopName.toString(),
            ),
            const SizedBox(height: 10.0),
            showTitleContent(
              "Customer Pan : ",
              controller.selectedData.value.customerPan??"",
            ),
            const Divider(),
            const SizedBox(height: 10.0),
            const Text("Description ",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff004792),
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Text(controller.selectedData.value.description ?? "",
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w600)),
            ),
          ],
        );
      } else {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
         showTitleContent(
                  "Customer Name : ",
                  controller.selectedData.value.customerName.toString(),
                ),
          const SizedBox(height: 8.0),
           showTitleContent(
                  "Added Date : ",
                  controller.selectedData.value.addedDateTime??"",
                ),
          const SizedBox(height: 10.0),
         showTitleContent(
              "Customer Address : ",
              controller.selectedData.value.customerAddress??"",
            ),const SizedBox(height: 10.0),
         showTitleContent(
              "Shop Name : ",
              controller.selectedData.value.shopName??"",
            ),
            showTitleContent(
              "Customer Pan : ",
              controller.selectedData.value.customerPan??"",
            ),
          const SizedBox(height: 8.0),
          const Divider(),
          const SizedBox(height: 10.0),
          const Text("Description ",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff004792),
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 6.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
                borderRadius: BorderRadius.circular(8.0)),
            child: Text(controller.selectedData.value.description ?? "",
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w600)),
          ),
        ]);
      }
    });
  }

  listStockTable(List<StockInHand> inHand) {
    return Column(
      children: [
        const Center(
          child: Text(
            "Stock List",
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
                  DataCell(SizedBox(
                    child: Text(inHand[index].title ?? "",
                    overflow: TextOverflow.ellipsis,
                        maxLines: 3),
                  )),
                  DataCell(Text(inHand[index].quantity.toString())),
                ]);
              })),
        ),
      ],
    );
  }
}
