import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/organization_controller.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/theme.dart';

final controller = Get.find<OrganizationController>();

Widget organizationDetails() {
  return Obx(() {
    return  Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xff004792),
            ),
            borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              controller.organizationDetail.value.name ?? "",
              style: const TextStyle(
                  fontSize: 24.0,
                  color: Color(0xff004792),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Row(mainAxisSize: MainAxisSize.min,
             children: [
              Text(controller.organizationDetail.value.email ?? "",
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff004792),
                      fontWeight: FontWeight.w400)),
              Text(" | ${controller.organizationDetail.value.phoneNo ?? ""}",
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w400))
            ]),
            const SizedBox(height: 8.0),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Text(controller.organizationDetail.value.address ?? "",
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff004792),
                      fontWeight: FontWeight.w400)),
              Text(
                  " |  Pan Number : ${controller.organizationDetail.value.panNo ?? ""}",
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w400))
            ])
          ],
        ),
     
    );
  });
}

final formKey=GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController panNoController = TextEditingController();
    TextEditingController emailController = TextEditingController();
 Widget organizationUpdateForm() {
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
            const Text("Update Organization",
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
      content: SingleChildScrollView(
        child: Container(
            // padding: EdgeInsets.all(12),
            child: Column(children: [
          Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: customInputDecoration(labelText: "Name"),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: mobileNoController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (!RegExp(r'^[0-9]+$').hasMatch(value!)) {
                          return 'Contact number should contain only numeric characters';
                        }

                        if (value.length < 10) {
                          return 'Contact number should be at least 10 digits';
                        }
                        return null;
                      },
                      decoration: customInputDecoration(labelText: "Contact"),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller:addressController,
                     
                      validator: (value) {
                        if (value!.isEmpty) {
                           
                            return 'Enter a valid  address';
                          
                        }
                        return null;
                      },
                      decoration: customInputDecoration(labelText: "Address"),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller:emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          String emailPattern =
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$';
                          RegExp regExp = RegExp(emailPattern);
                          if (!regExp.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                        }
                        return null;
                      },
                      decoration: customInputDecoration(labelText: "Email"),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller:panNoController,
                      validator: (value) {
                        if (value!.isEmpty) {
                         
                            return 'Enter a valid pan number';
                         
                        }
                        return null;
                      },
                      decoration: customInputDecoration(labelText: "Pan Number"),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: Get.size.width * 0.3,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff596cff),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (controller.isLoading.value == false) {
                                controller.isLoading.value = true;
                                // EmployeeUpdateRequest updateRequest =
                                //     EmployeeUpdateRequest();
                                // updateRequest.email =
                                //     controller.emailController.text;
                                // updateRequest.fullName =
                                //     controller.nameController.text;
                                // updateRequest.mobileNumber =
                                //     controller.mobileNumberController.text;
                                // updateRequest.id =
                                //     controller.selectedEmployeeDetail.value.id!;
                                // var res = await controller
                                //     .updateEmployee(updateRequest);
                                // print(updateRequest.id);
                                // if (res != null) {
                                //   Get.back();
                                //   Get.offAllNamed(Routes.EMPLOYEE_MANAGEMENT);
                                // }
                                formKey.currentState!.reset();
                              }
                            }
                          },
                          child: const Text(
                            "Update Organization",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18.0),
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
        ])),
      ),
    );
  }
