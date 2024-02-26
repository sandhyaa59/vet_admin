import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/organization_controller.dart';
import 'package:vet_pharma/screens/qr_screen.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/widgets/appbar.dart';
import 'package:vet_pharma/widgets/text.dart';

class OrganozationScreen extends StatelessWidget {
  OrganozationScreen({super.key});

  final controller = Get.find<OrganizationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBars(context),
        drawer: MyDrawer(),
        body: Obx(() => LoadingOverlay(
            isLoading: controller.isLoading.value,
            child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Center(
                  child: Container(
                    width: Get.width * 0.85,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8.0),),
                    padding: const EdgeInsets.all(kPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [organizationDetail(true)],
                    ),
                  ),
                );
              } else {
                return Container(
                  padding: const EdgeInsets.all(kPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [organizationDetail(false)],
                  ),
                );
              }
            }))));
  }

  Widget organizationDetail(bool flag) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showTitleContent("Organization Name : ",
              controller.organizationDetail.value.name ?? ""),
          const SizedBox(height: 8.0),
          showTitleContent(
              "Address : ", controller.organizationDetail.value.address ?? ""),
          const SizedBox(height: 8.0),
          showTitleContent(
              "Pan No : ", controller.organizationDetail.value.panNo ?? ""),
          const Divider(),
           const   Text("Details",
            style: TextStyle(
            color: Color(0xff004792),
            fontWeight: FontWeight.bold,
            fontSize: 20.0
            ),),
           const SizedBox(height: 8.0),
          showTitleContent(
              "Email : ", controller.organizationDetail.value.email ?? ""),
          const SizedBox(height: 8.0),
          showTitleContent(
              "Contact : ", controller.organizationDetail.value.phoneNo ?? ""),
          const SizedBox(height: 8.0),
          const Divider(),
       const   Text("Package",
            style: TextStyle(
            color: Color(0xff004792),
            fontWeight: FontWeight.bold,
            fontSize: 20.0
            ),
          ), const SizedBox(height: 8.0),
          showTitleContent("Package Name : ",
              controller.organizationDetail.value.packageName ?? ""),
          const SizedBox(height: 8.0),
          flag
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    showTitleContent(
                        "Duration : ",
                        controller.organizationDetail.value.duration
                                .toString() ),
                    showTitleContent(
                        "Expires On : ",
                        controller.organizationDetail.value.expiryDate.toString()
                               ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showTitleContent(
                        "Duration : ",
                        controller.organizationDetail.value.duration
                                .toString()),
                    const SizedBox(height: 8.0),
                    showTitleContent(
                        "Expires On : ",
                        controller.organizationDetail.value.expiryDate
                                .toString() 
                            ),
                  ],
                ),
          const Divider(),
           const   Text("Sms Service ",
            style: TextStyle(
            color: Color(0xff004792),
            fontWeight: FontWeight.bold,
            fontSize: 20.0
            ),),
          const SizedBox(height: 8.0),
          flag
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      showTitleContent(
                          "Sms Count : ",
                          controller.organizationDetail.value.smsCount
                                  .toString() ),
                      const SizedBox(height: 8.0),
                      showTitleContent(
                          "Remaining Sms Count : ",
                          controller.organizationDetail.value.remainingSmsCount
                                  .toString() 
                        ),
                    ])
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  showTitleContent(
                      "Sms Count : ",
                      controller.organizationDetail.value.smsCount.toString() ),
                  const SizedBox(height: 8.0),
                  showTitleContent(
                      "Remaining Sms Count : ",
                      controller.organizationDetail.value.remainingSmsCount
                              .toString() ),
                ]),
          const SizedBox(height: 8.0),
          showTitleContent(
              "Employee Count : ",
              controller.organizationDetail.value.employeeCount.toString() 
                  ),
                  const SizedBox(height: 10.0,),
                              ElevatedButton(onPressed: (){
                                Get.dialog(const Dialog(child: QRscreen(),));
                              }, child:const Text("Show QR"),)
        ],
      ),
    );
  }
}
