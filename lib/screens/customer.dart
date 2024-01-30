import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:vet_pharma/widgets/cancel.dart';
import 'package:vet_pharma/widgets/organization.dart';

// ignore: must_be_immutable
class CustomerScreen extends StatelessWidget {
  CustomerScreen({super.key});

  final controller = Get.find<CustomerController>();

  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
    TextEditingController customerPanNumberController = TextEditingController();


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
                      customerListTable(),
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
                  ),
                  customerListTable(),
                ],
              );
            }
          })),
        );
      }),
    );
  }

  Widget customerListTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: GetBuilder<CustomerController>(builder: (controller) {
          return SizedBox(
            width: Get.size.width,
            child: PaginatedDataTable(
              header: const Text(
                "Customers",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              source: MyDataSource(controller.customerList,
                  controller.customerListResponse.value.totalData ?? 0),
              initialFirstRowIndex: 0,
              rowsPerPage: controller.pageSize.value,
              // showFirstLastButtons: true,
              onPageChanged: (newPage) async {
                await controller.loadMoreData();
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
                    'Pan Number',
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
                    'Added At',
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
            ),
          );
        }));
  }

  Widget addCustomerForm() {
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
                    // width: Get.size.width * 0.3,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      autofocus: true,
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
                    // width: Get.size.width * 0.3,
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

                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Contact number should contain only numeric characters';
                          }

                          if (value.length < 7) {
                            return 'Contact number should be at least 7 digits';
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
                    // width: Get.size.width * 0.3,
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: emailController,
                        decoration: customInputDecoration(labelText: "Email")),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    // width: Get.size.width * 0.3,
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: addressController,
                        // obscureText: controller.isVisible.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address ';
                          }
                          return null;
                        },
                        decoration:
                            customInputDecoration(labelText: "Address")),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    // width: Get.size.width * 0.3,
                    child: TextFormField(
                        textInputAction: TextInputAction.done,
                        autofocus: true,
                        controller: shopNameController,
                        decoration:
                            customInputDecoration(labelText: "Shop Name")),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    // width: Get.size.width * 0.3,
                    child: TextFormField(
                        textInputAction: TextInputAction.done,
                        autofocus: true,
                        controller: customerPanNumberController,
                        decoration:
                            customInputDecoration(labelText: "Pan Number")),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: SizedBox(
                      width: Get.size.width * 0.3,
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
                                addRequest.mobileNumber =
                                    mobileNoController.text;
                                addRequest.address = addressController.text;
                                addRequest.shopName = shopNameController.text;
                                addRequest.customerPan=customerPanNumberController.text;
                                var res =
                                    await controller.addCustomers(addRequest);
                                Get.back();
                                if (res != null) {
                                  await controller.initData();
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
                            style: TextStyle(fontSize: 18.0),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
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
                    // width: Get.size.width * 0.3,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      autofocus: true,
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
                    // width: Get.size.width * 0.3,
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

                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Contact number should contain only numeric characters';
                          }

                          if (value.length < 7) {
                            return 'Contact number should be at least 7 digits';
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
                    // width: Get.size.width * 0.3,
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: emailController,
                        // keyboardType: TextInputType.emailAddress,

                        decoration: customInputDecoration(labelText: "Email")),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    // width: Get.size.width * 0.3,
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: addressController,
                        // obscureText: controller.isVisible.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address ';
                          }
                          return null;
                        },
                        decoration:
                            customInputDecoration(labelText: "Address")),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    // width: Get.size.width * 0.3,
                    child: TextFormField(
                        textInputAction: TextInputAction.done,
                        autofocus: true,
                        controller: shopNameController,
                        decoration:
                            customInputDecoration(labelText: "Shop Name")),
                  ),const SizedBox(height: 20.0),
                  SizedBox(
                    // width: Get.size.width * 0.3,
                    child: TextFormField(
                        textInputAction: TextInputAction.done,
                        autofocus: true,
                        controller: customerPanNumberController,
                        decoration:
                            customInputDecoration(labelText: "Pan Number")),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: SizedBox(
                      // width: Get.size.width * 0.3,
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
                                addRequest.mobileNumber =
                                    mobileNoController.text;
                                addRequest.address = addressController.text;
                                addRequest.shopName = shopNameController.text;
                                addRequest.customerPan=customerPanNumberController.text;
                                var res =
                                    await controller.addCustomers(addRequest);
                                Get.back();
                                if (res != null) {
                                  await controller.initData();
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
                            style: TextStyle(fontSize: 18.0),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}

class MyDataSource extends DataTableSource {
  final List<CustomerList> customerLists;
  final int totalData;

  MyDataSource(
    this.customerLists,
    this.totalData,
  );

  CustomerController controller = Get.find<CustomerController>();

  @override
  DataRow? getRow(int index) {
    if (index >= customerLists.length) {
      return null;
    }
    return DataRow(
      cells: <DataCell>[
        DataCell(Text('${index + 1}')),
        DataCell(SizedBox(
          //width: Get.width * 0.2,
          child: Text(
            customerLists[index].name ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )),
        DataCell(SizedBox(
          //  width: Get.width * 0.18,
          child: Text(
            customerLists[index].email ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )),
        DataCell(SizedBox(
          //width: Get.width * 0.2,
          child: Text(
            customerLists[index].shopName ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )),
         DataCell(SizedBox(
          //width: Get.width * 0.2,
          child: Text(
            customerLists[index].customerPan ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )),
        DataCell(SizedBox(
          child: Text(
            customerLists[index].address ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )),
        DataCell(Text(customerLists[index].mobileNumber ?? "")),
        DataCell(Text(customerLists[index].addedDateTime ?? "")),
        DataCell(InkWell(
          onTap: () async {
            if (customerLists[index].isActive == true) {
              await Get.dialog(askConfirmation(
                  "Are you sure you want to deactivate customer ?",
                  TextButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: const Text('No')),
                  TextButton(
                      onPressed: () async {
                        var res = await controller
                            .deactivateCustomers(customerLists[index].id!);
                        Get.back();
                        if (res != null) {
                         
                          await controller.initData();
                        }
                      },
                      child: const Text('Yes'))));
            } else {
              await Get.dialog(askConfirmation(
                  "Are you sure you want to activate customer ?",
                  TextButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: const Text('No')),
                  TextButton(
                      onPressed: () async {
                        var res = await controller
                            .activateCustomers(customerLists[index].id!);
                        Get.back();
                        if (res != null) {
                          await controller.initData();
                        }
                      },
                      child: const Text('Yes'))));
            }
            Get.offAllNamed(Routes.CUSTOMERLIST);
          },
          // onTap: () async {

          //   } else {

          //   }
          //   await controller.initData();
          // },
          child: Container(
            // height: 6.0,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: (customerLists[index].isActive ?? false)
                    ? Colors.green
                    : Colors.red,
                borderRadius: BorderRadius.circular(18.0)),
            child: Text(
              (customerLists[index].isActive ?? false) ? "Active" : "InActive",
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
                    await Get.dialog(askConfirmation(
                        "Are you sure you want to delete customer ?",
                        TextButton(
                            onPressed: () async {
                              Get.back();
                            },
                            child: const Text('No')),
                        TextButton(
                            onPressed: () async {
                              var res = await controller
                                  .deleteCustomers(customerLists[index].id!);

                              Get.back();
                              if (res != null) {
                               
                                await controller.initData();
                                Get.offAndToNamed(Routes.CUSTOMERLIST);
                              }
                            },
                            child: const Text('Yes'))));
                  }),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 16.0,
                ),
                onPressed: () async {
                  controller.selectedCustomerList.value = customerLists[index];
                  controller.nameController.text =
                      controller.selectedCustomerList.value.name ?? "";
                  controller.emailController.text =
                      controller.selectedCustomerList.value.email ?? "";
                  controller.mobileNoController.text =
                      controller.selectedCustomerList.value.mobileNumber ?? "";
                  controller.shopNameController.text =
                      controller.selectedCustomerList.value.shopName ?? "";
                  controller.addressController.text =
                      controller.selectedCustomerList.value.address ?? "";
                  //  var ids= controller.selectedCustomerList.value.id;
                  controller.selectedCustomerList.value = customerLists[index];
                  Get.dialog(updateCUstomer());
                  await controller.initData();
                  controller.isLoading.value = false;
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  int get rowCount {
    return totalData;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  final formKey = GlobalKey<FormState>();
  Widget updateCUstomer() {
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
                      textInputAction: TextInputAction.next,
                      autofocus: true,
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
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: controller.mobileNoController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
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
                        decoration: customInputDecoration(labelText: "Email")),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: controller.addressController,
                        // obscureText: controller.isVisible.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address ';
                          }
                          return null;
                        },
                        decoration:
                            customInputDecoration(labelText: "Address")),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                      textInputAction: TextInputAction.done,
                      autofocus: true,
                      controller: controller.shopNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your shop name ';
                        }
                        return null;
                      },
                      decoration:
                          customInputDecoration(labelText: "Shop Name")),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    // width: Get.size.width * 0.3,
                    child: TextFormField(
                        textInputAction: TextInputAction.done,
                        autofocus: true,
                        controller:controller. panNumberController,
                        decoration:
                            customInputDecoration(labelText: "Pan Number")),
                  ),
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
                              updateRequest.name =
                                  controller.nameController.text;
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
                                  updateRequest.customerPan=controller.panNumberController.text;

                              var res = await controller
                                  .updateCustomers(updateRequest);
                              Get.back();
                              if (res != null) {
                                Get.offAllNamed(Routes.CUSTOMERLIST);
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
                          style: TextStyle(fontSize: 18.0),
                        )),
                  )
                ],
              ),
            ),
          ),
        );
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
                      textInputAction: TextInputAction.next,
                      autofocus: true,
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
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: controller.mobileNoController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
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
                        decoration: customInputDecoration(labelText: "Email")),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: controller.addressController,
                        // obscureText: controller.isVisible.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address ';
                          }
                          return null;
                        },
                        decoration:
                            customInputDecoration(labelText: "Address")),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                      textInputAction: TextInputAction.done,
                      autofocus: true,
                      controller: controller.shopNameController,
                      decoration:
                          customInputDecoration(labelText: "Shop Name")),
                  const SizedBox(height: 20.0),
                  TextFormField(
                      textInputAction: TextInputAction.done,
                      autofocus: true,
                      controller: controller.panNumberController,
                     
                      decoration:
                          customInputDecoration(labelText: "Pan Number")),
                  const SizedBox(height: 20.0),
                  Center(
                    child: SizedBox(
                      // width: Get.size.width * 0.3,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (controller.isLoading.value == false) {
                                controller.isLoading.value = true;
                                CustomerUpdateRequest updateRequest =
                                    CustomerUpdateRequest();
                                updateRequest.name =
                                    controller.nameController.text;
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
updateRequest.customerPan=controller.panNumberController.text;
                                var res = await controller
                                    .updateCustomers(updateRequest);
                                Get.back();
                                if (res != null) {
                                  Get.offAllNamed(Routes.CUSTOMERLIST);
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
                            style: TextStyle(fontSize: 18.0),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
