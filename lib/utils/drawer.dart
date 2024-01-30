// drawer.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/organization_controller.dart';

import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool isExpanded = false;
  OrganizationController controller = Get.put(OrganizationController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(12),
              child: controller.organizationDetail.value.name!=null ? 
               SingleChildScrollView(
                 child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.organizationDetail.value.name ?? "",
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Color(0xff596cff),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          controller.organizationDetail.value.address ?? "",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                              "Pan Number : ${controller.organizationDetail.value.panNo??""}",
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w400)),
                        const SizedBox(height: 10.0),
                        Text(controller.organizationDetail.value.phoneNo ?? "",
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w400))
                      ],

                             ),
               ):const Text("TRACKYOE",
              style:  TextStyle(color: Color(0xff596cff),
                              fontSize: 16.0, fontWeight: FontWeight.w800)
              )
            ),
            ListTile(
              onTap: () {
                Get.offAndToNamed(Routes.HOME);
              },
              leading: const Icon(
                Icons.dashboard,
                color: Color(0xff596cff),
              ),
              title: const Text(
                ' Dashboard',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(), ListTile(
              onTap: () {
                Get.offAndToNamed(Routes.EMPLOYEE_MANAGEMENT);
              },
              leading: const Icon(
                Icons.track_changes,
                color: Color(0xff596cff),
              ),
              title: const Text(
                ' Employee Management',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                Get.offAndToNamed(Routes.CHECKINCHECKOUT);
              },
              leading: const Icon(
                Icons.check,
                color: Color(0xff596cff),
              ),
              title: const Text(
                ' CheckIn - Check Out',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
           
             ListTile(
              onTap: () {
                Get.offAndToNamed(Routes.ADD_TASK);
              },
              leading: const Icon(
                Icons.task,
                color: Color(0xff596cff),
              ),
              title: const Text(
                ' Add Task',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),ListTile(
              onTap: () {
                Get.offAndToNamed(Routes.REPORT);
              },
              leading: const Icon(
                Icons.report,
                color: Color(0xff596cff),
              ),
              title: const Text(
                'Report',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                Get.offAndToNamed(Routes.ORDER);
              },
              leading: const Icon(
                Icons.shopping_bag,
                color: Color(0xff596cff),
              ),
              title: const Text(
                'Order',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            
            ListTile(
              onTap: () {
                Get.offAndToNamed(Routes.BILLING);
              },
              leading: const Icon(
                Icons.payments_outlined,
                color: Color(0xff596cff),
              ),
              title: const Text(
                ' Billing',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                Get.offAndToNamed(Routes.PAYMENT);
              },
              leading: const Icon(
                Icons.payment_outlined,
                color: Color(0xff596cff),
              ),
              title: const Text(
                ' Payment',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                Get.offAndToNamed(Routes.CUSTOMERLIST);
              },
              leading: const Icon(
                Icons.person_remove,
                color: Color(0xff596cff),
              ),
              title: const Text(
                ' Customer',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
