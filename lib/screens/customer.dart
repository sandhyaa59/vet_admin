import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/customer_controller.dart';
import 'package:vet_pharma/model/customer_add_request.dart';
import 'package:vet_pharma/model/customer_list_response.dart';
import 'package:vet_pharma/model/customer_update_request.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/utils/theme.dart';
import 'package:vet_pharma/widgets/appbar.dart';

// ignore: must_be_immutable
class CustomerScreen extends StatelessWidget {
  CustomerScreen({super.key});

  final controller = Get.find<CustomerController>();

  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
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
                          onPressed: () {
                           Get.dialog(addCustomerForm());
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
                              'Add Customer',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff596cff),
                              ),
                            ),
                          )),
                      const SizedBox(height: 20.0),
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 2.0,
                          child: Container(
                              // width: double.maxFinite,
                              padding: const EdgeInsets.all(12),
                              child: customerListTable())),
                    ],
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                      Get.dialog(addCustomerForm());
                              
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
                              'Add Customer',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff596cff),
                              ),
                            ),
                          )),
                      const SizedBox(height: 20.0),
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 2.0,
                          child: Container(
                            // width: double.maxFinite,
                            padding: const EdgeInsets.all(12),
                            child: customerListTable(),
                          )),
                    ],
                  ),
                ),
              );
            }
          })),
        );
      }),
    );
  }

  Widget updateCUstomer() {
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
            const Text("Update Customer",
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
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              SizedBox(
                //width: MediaQuery.of(context).size.width*0.3,
                child: TextFormField(
                  controller: controller.nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your name';
                    } else {
                      return null;
                    }
                  },
                  decoration: customInputDecoration(
                    labelText: "Name",
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                //width: MediaQuery.of(context).size.width*0.3,
                child: TextFormField(
                    controller: controller.mobileNoController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your contact number';
                      }

                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Contact number should contain only numeric characters';
                      }

                      if (value.length < 10) {
                        return 'Contact number should be at least 6 digits';
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
                // width: MediaQuery.of(context).size.width*0.3,
                child: TextFormField(
                    controller: controller.emailController,
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
                    decoration: customInputDecoration(labelText: "Email")),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                child: TextFormField(
                    controller: controller.addressController,
                    // obscureText: controller.isVisible.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your address ';
                      }
                      return null;
                    },
                    decoration: customInputDecoration(labelText: "Address")),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                  controller: controller.shopNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your shop name ';
                    }
                    return null;
                  },
                  decoration: customInputDecoration(labelText: "Shop Name")),
              const SizedBox(height: 20.0),
               SizedBox(
                  width: Get.size.width * 0.3,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (controller.isLoading.value == false) {
                            controller.isLoading.value = true;
                            CustomerUpdateRequest updateRequest =
                                CustomerUpdateRequest();
                            updateRequest.name = controller.nameController.text;
                            updateRequest.email =
                                controller.emailController.text;
                            updateRequest.mobileNumber =
                                controller.mobileNoController.text;
                            updateRequest.address =
                                controller.addressController.text;
                            updateRequest.shopName =
                                controller.shopNameController.text;
                            updateRequest.id =
                                controller.selectedCustomerList.value.id;

                            var res =
                                await controller.updateCustomers(updateRequest);
                            if (res != null) {
                              Get.back();
                              Get.offAndToNamed(Routes.CUSTOMERLIST);
                            }
                            formKey.currentState!.reset();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff596cff),
                      ),
                      child: const Text(
                        "Update Customer",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18.0),
                      )),
                
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customerListTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'SN',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Customer Name',
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
              'Shop Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Address',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Contact',
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
        ], rows: customerListRows(controller.customerList)));
  }

  List<DataRow> customerListRows(List<CustomerList> customerLists) {
    return List.generate(customerLists.length, (index) {
      return DataRow(
        cells: <DataCell>[
          DataCell(Text('${index + 1}')),
          DataCell(Text(customerLists[index].name ?? "")),
          DataCell(Text(customerLists[index].email ?? "")),
          DataCell(Text(customerLists[index].shopName ?? "")),
          DataCell(Text(customerLists[index].address ?? "")),
          DataCell(Text(customerLists[index].mobileNumber ?? "")),
          DataCell(InkWell(
            onTap: () async {
              if (customerLists[index].isActive == true) {
                await controller.deactivateCustomers(customerLists[index].id!);
              } else {
                await controller.activateCustomers(customerLists[index].id!);
              }

              await controller.initData();
              Get.toNamed(Routes.CUSTOMERLIST);
            },
            child: Container(
              // height: 6.0,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: (customerLists[index].isActive ?? false)
                      ? Colors.green
                      : Colors.red,
                  borderRadius: BorderRadius.circular(18.0)),
              child: Text(
                (customerLists[index].isActive ?? false)
                    ? "Active"
                    : "InActive",
                style: const TextStyle(fontSize: 13.0, color: Colors.white),
              ),
            ),
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
                    await controller.deleteCustomers(customerLists[index].id!);
                    await controller.initData();
                    Get.toNamed(Routes.CUSTOMERLIST);
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                    size: 16.0,
                  ),
                  onPressed: () async {
                    controller.selectedCustomerList.value =
                        customerLists[index];
                    controller.nameController.text =
                        controller.selectedCustomerList.value.name ?? "";
                    controller.emailController.text =
                        controller.selectedCustomerList.value.email ?? "";
                    controller.mobileNoController.text =
                        controller.selectedCustomerList.value.mobileNumber ??
                            "";
                    controller.shopNameController.text =
                        controller.selectedCustomerList.value.shopName ?? "";
                    controller.addressController.text =
                        controller.selectedCustomerList.value.address ?? "";
                    //  var ids= controller.selectedCustomerList.value.id;
                    controller.selectedCustomerList.value =customerLists[index];
                    Get.dialog(updateCUstomer());
                 await   controller.initData();
                     Get.toNamed(Routes.CUSTOMERLIST);
                  },
                ),
              ],
            ),
          )
        ],
      );
    });
  }

  Widget addCustomerForm() {
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
            const Text("Add Customer",
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
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              SizedBox(
                //width: MediaQuery.of(context).size.width*0.3,
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your name';
                    } else {
                      return null;
                    }
                  },
                  decoration: customInputDecoration(
                    labelText: "Name",
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                //width: MediaQuery.of(context).size.width*0.3,
                child: TextFormField(
                    controller: mobileNoController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your contact number';
                      }

                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Contact number should contain only numeric characters';
                      }

                      if (value.length < 10) {
                        return 'Contact number should be at least 6 digits';
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
                // width: MediaQuery.of(context).size.width*0.3,
                child: TextFormField(
                    controller: emailController,
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
                    decoration: customInputDecoration(labelText: "Email")),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                  controller: addressController,
                  // obscureText: controller.isVisible.value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address ';
                    }
                    return null;
                  },
                  decoration: customInputDecoration(labelText: "Address")),
              const SizedBox(height: 20.0),
              Center(
                child: SizedBox(
                  //width: MediaQuery.of(context).size.width*0.3,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (controller.isLoading.value == false) {
                            controller.isLoading.value = true;
                            CustomerAddRequest addRequest =
                                CustomerAddRequest();
                            addRequest.name = nameController.text;
                            addRequest.email = emailController.text;
                            addRequest.mobileNumber = mobileNoController.text;
                            addRequest.address = addressController.text;
                            var res = await controller.addCustomers(addRequest);
                            if (res != null) {
                              Get.back();
                              Get.offAndToNamed(Routes.CUSTOMERLIST);
                            }
                            formKey.currentState!.reset();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff596cff),
                      ),
                      child: const Text(
                        "Add Customer",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18.0),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
