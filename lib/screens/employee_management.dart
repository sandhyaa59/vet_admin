import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/employee_management_controller.dart';
import 'package:vet_pharma/model/employee_add_request.dart';
import 'package:vet_pharma/model/employee_management_reponse.dart';
import 'package:vet_pharma/model/employee_update_request.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/utils/theme.dart';
import 'package:vet_pharma/widgets/appbar.dart';
import 'package:vet_pharma/widgets/cancel.dart';

// ignore: must_be_immutable
class EmployeeManagementScreen extends StatelessWidget {
  EmployeeManagementScreen({super.key});

  final controller = Get.find<EmployeeManagementController>();
  final formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBars(context),
      body: Obx(() {
        return LoadingOverlay(
          isLoading: controller.isLoading.value,
          child: SingleChildScrollView(
              child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            Get.dialog(addEmployeeForm(context));
                            await controller.initData();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                    color: Color(0xff596cff),
                                  ))),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Add Employee',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff596cff),
                              ),
                            ),
                          )),
                      const SizedBox(height: 20.0),
                      employeeDataTable(),
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          Get.dialog(addEmployeeForm(context));
                          await controller.initData();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                  color: Color(0xff596cff),
                                ))),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Add Employee',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xff596cff),
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(height: 20.0),
                  employeeDataTable()
                ],
              );
            }
          })),
        );
      }),
    );
  }

  Widget employeeDataTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: Get.size.width,
          child: GetBuilder<EmployeeManagementController>(
            init: controller,
            initState: (_) {},
            builder: (_) {
              return PaginatedDataTable(
                header: const Text(
                  "Employee",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                source: MyDataSource(controller.employeeDetailList,
                    controller.employeeManagement.value.totalData ?? 0),
                initialFirstRowIndex: 0,
                rowsPerPage: controller.pageSize.value,
                // showFirstLastButtons: true,
                onPageChanged: (newPage) async {
                  await controller.loadMore();
                },
                columnSpacing: 20,

                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'SN',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      ' Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Email',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Phone',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Created At',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Status',
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
              );
            },
          ),
        ));
  }

  Widget addEmployeeForm(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
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
                const Text("Add Employee",
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
          content: Form(
            key: formkey,
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
                            return 'Enter employee name';
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
                  SizedBox(
                    // width: MediaQuery.of(context).size.width * 0.3,
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: mobileNoController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your contact number';
                          }
                          if (value.length < 8) {
                            return 'Contact number should be at least 8 digits';
                          }
                          return null;
                        },
                        decoration: customInputDecoration(
                          labelText: "Contact",
                        )),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    // width: MediaQuery.of(context).size.width * 0.3,
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            String emailPattern =
                                r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                                r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                                r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                                r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                                r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                                r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                                r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                            RegExp regExp = RegExp(emailPattern);
                            if (!regExp.hasMatch(value)) {
                              return 'Enter a valid email address';
                            }
                          } else if (value.isEmpty) {
                            return "Enter a  email address";
                          }
                        },
                        decoration: customInputDecoration(
                          labelText: "Email",
                        )),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    // width: MediaQuery.of(context).size.width * 0.3,
                    child: TextFormField(
                        textInputAction: TextInputAction.done,
                        autofocus: true,
                        controller: passwordController,
                        // obscureText: controller.isVisible.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Password ';
                          }
                          if (value.length < 6) {
                            return 'Password should be at least 6 digits';
                          }
                          return null;
                        },
                        decoration: customInputDecoration(
                          labelText: "Password",
                        )),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: Get.size.width * 0.3,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            if (controller.isLoading.value == false) {
                              controller.isLoading.value = true;
                              Get.back();
                              EmployeeAddRequest addRequest =
                                  EmployeeAddRequest();
                              addRequest.email = emailController.text;
                              addRequest.password = passwordController.text;
                              addRequest.fullName = nameController.text;
                              addRequest.mobileNumber = mobileNoController.text;
                              var res =
                                  await controller.saveEmployee(addRequest);
                              Get.back();
                              if (res != null) {
                                await controller.initData();
                                Get.offAndToNamed(Routes.EMPLOYEE_MANAGEMENT);
                              }
                              formkey.currentState!.reset();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff596cff),
                        ),
                        child: const Text(
                          "Add Employee",
                          style: TextStyle(fontSize: 18.0),
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      } else {
        return SizedBox(
          height: Get.size.height,
          child: AlertDialog(
            titlePadding: const EdgeInsets.all(0),
            title: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xff596cff),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Add Employee",
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
            content: Form(
              key: formkey,
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
                              return 'Enter employee name';
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
                    SizedBox(
                      // width: MediaQuery.of(context).size.width * 0.3,
                      child: TextFormField(
                          controller: mobileNoController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your contact number';
                            }
                            return null;
                          },
                          decoration: customInputDecoration(
                            labelText: "Contact",
                          )),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      // width: MediaQuery.of(context).size.width * 0.3,
                      child: TextFormField(
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          controller: emailController,
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              String emailPattern =
                                  r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                                  r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                                  r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                                  r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                                  r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                                  r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                                  r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                              RegExp regExp = RegExp(emailPattern);
                              if (!regExp.hasMatch(value)) {
                                return 'Enter a valid email address';
                              }
                            } else if (value.isEmpty) {
                              return "Enter a  email address";
                            }
                          },
                          decoration: customInputDecoration(
                            labelText: "Email",
                          )),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      // width: MediaQuery.of(context).size.width * 0.3,
                      child: TextFormField(
                          textInputAction: TextInputAction.done,
                          autofocus: true,
                          controller: passwordController,
                          // obscureText: controller.isVisible.value,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Password ';
                            }
                            if (value.length < 6) {
                              return 'Password should be at least 6 digits';
                            }
                            return null;
                          },
                          decoration: customInputDecoration(
                            labelText: "Password",
                          )),
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: SizedBox(
                        // width: Get.size.width * 0.3,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                if (controller.isLoading.value == false) {
                                  controller.isLoading.value = true;
                                  EmployeeAddRequest addRequest =
                                      EmployeeAddRequest();
                                  addRequest.email = emailController.text;
                                  addRequest.password = passwordController.text;
                                  addRequest.fullName = nameController.text;
                                  addRequest.mobileNumber =
                                      mobileNoController.text;
                                  var res =
                                      await controller.saveEmployee(addRequest);
                                  Get.back();
                                  if (res != null) {
                                    await controller.initData();
                                    Get.offAndToNamed(
                                        Routes.EMPLOYEE_MANAGEMENT);
                                  }
                                  formkey.currentState!.reset();
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff596cff),
                            ),
                            child: const Text(
                              "Add Employee",
                              style: TextStyle(fontSize: 18.0),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}

// }
class MyDataSource extends DataTableSource {
  final List<EmployeeDetails> employeeDetails;
  final int totalData;

  MyDataSource(
    this.employeeDetails,
    this.totalData,
  );

  EmployeeManagementController controller =
      Get.find<EmployeeManagementController>();

  @override
  DataRow? getRow(int index) {
    if (index >= employeeDetails.length) {
      return null;
    }
    return DataRow(
      cells: <DataCell>[
        DataCell(Text('${index + 1}')),
        DataCell(Text(employeeDetails[index].fullName ?? "")),
        DataCell(Text(employeeDetails[index].email ?? "")),
        DataCell(Text(employeeDetails[index].mobileNumber ?? "")),
        DataCell(Text(employeeDetails[index].createdAt ?? "")),
        DataCell(InkWell(
          onTap: () async {
            if (employeeDetails[index].isActive == true) {
              await Get.dialog(askConfirmation(
                  "Are you sure you want to deactivate employee ?",
                  TextButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: const Text('No')),
                  TextButton(
                      onPressed: () async {
                        var res = await controller
                            .deactivate(employeeDetails[index].id!);
                        Get.back();
                        if (res != null) {
                          await controller.initData();
                        }
                      },
                      child: const Text('Yes'))));
            } else {
              await Get.dialog(askConfirmation(
                  "Are you sure you want to activate employee ?",
                  TextButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: const Text('No')),
                  TextButton(
                      onPressed: () async {
                        var res = await controller
                            .activate(employeeDetails[index].id!);
                        Get.back();
                        if (res != null) {
                          await controller.initData();
                        }
                      },
                      child: const Text('Yes'))));
            }
            Get.offAllNamed(Routes.EMPLOYEE_MANAGEMENT);
          },
          child: Obx(() => Container(
                // height: 6.0,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: (employeeDetails[index].isActive ?? false)
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.circular(18.0)),

                child: Text(
                  (employeeDetails[index].isActive ?? false)
                      ? "Active"
                      : "InActive",
                  style: const TextStyle(fontSize: 13.0, color: Colors.white),
                ),
              )),
        )),
        DataCell(
          Row(
            children: [
              IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 16.0,
                  ),
                  onPressed: () async {
                    await Get.dialog(askConfirmation(
                        "Are you sure you want to delete employee ?",
                        TextButton(
                            onPressed: () async {
                              Get.back();
                            },
                            child: const Text('No')),
                        TextButton(
                            onPressed: () async {
                              var res = await controller
                                  .delete(employeeDetails[index].id!);

                              Get.back();
                              if (res != null) {
                                Get.offAllNamed(Routes.EMPLOYEE_MANAGEMENT);
                              }
                            },
                            child: const Text('Yes'))));
                  }

                  // Get.toNamed(Routes.EMPLOYEE_MANAGEMENT);

                  ),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 16.0,
                ),
                onPressed: () async {
                  controller.selectedEmployeeDetail.value =
                      employeeDetails[index];
                  controller.nameController.text =
                      controller.selectedEmployeeDetail.value.fullName ?? "";
                  controller.emailController.text =
                      controller.selectedEmployeeDetail.value.email ?? "";
                  controller.mobileNumberController.text =
                      controller.selectedEmployeeDetail.value.mobileNumber ??
                          "";
                  Get.dialog(employeeUpdateForm());

                  // var context;
                  // Get.dialog(updateEmployeeForm(context));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  final formKey = GlobalKey<FormState>();
  Widget employeeUpdateForm() {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
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
                  const Text("Update Employee",
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
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: controller.nameController,
                        decoration: customInputDecoration(labelText: "Name"),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: controller.mobileNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                                  EmployeeUpdateRequest updateRequest =
                                      EmployeeUpdateRequest();
                                  updateRequest.email =
                                      controller.emailController.text;
                                  updateRequest.fullName =
                                      controller.nameController.text;
                                  updateRequest.mobileNumber =
                                      controller.mobileNumberController.text;
                                  updateRequest.id = controller
                                      .selectedEmployeeDetail.value.id!;
                                  var res = await controller
                                      .updateEmployee(updateRequest);
                                  Get.back();
                                  if (res != null) {
                                    Get.offAllNamed(Routes.EMPLOYEE_MANAGEMENT);
                                  }
                                  formKey.currentState!.reset();
                                }
                              }
                            },
                            child: const Text(
                              "Update Employee",
                              style: TextStyle(fontSize: 18.0),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ));
      } else {
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
                  const Text("Update Employee",
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
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: controller.nameController,
                        decoration: customInputDecoration(labelText: "Name"),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        autofocus: true,
                        controller: controller.mobileNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                      const SizedBox(height: 20.0),
                      Center(
                        child: SizedBox(
                          // width: Get.size.width * 0.3,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff596cff),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  if (controller.isLoading.value == false) {
                                    controller.isLoading.value = true;
                                    EmployeeUpdateRequest updateRequest =
                                        EmployeeUpdateRequest();
                                    updateRequest.email =
                                        controller.emailController.text;
                                    updateRequest.fullName =
                                        controller.nameController.text;
                                    updateRequest.mobileNumber =
                                        controller.mobileNumberController.text;
                                    updateRequest.id = controller
                                        .selectedEmployeeDetail.value.id!;
                                    var res = await controller
                                        .updateEmployee(updateRequest);
                                    Get.back();
                                    if (res != null) {
                                      Get.offAllNamed(
                                          Routes.EMPLOYEE_MANAGEMENT);
                                    }
                                    formKey.currentState!.reset();
                                  }
                                }
                              },
                              child: const Text(
                                "Update Employee",
                                style: TextStyle(fontSize: 18.0),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
      }
    });
  }

  @override
  int get rowCount {
    return totalData;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
