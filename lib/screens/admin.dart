import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/admin_controller.dart';
import 'package:vet_pharma/model/adminList_response.dart';
import 'package:vet_pharma/model/admin_add_request.dart';
import 'package:vet_pharma/model/update_admin_request.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/widgets/appbar.dart';

class AdminList extends StatelessWidget {
   AdminList({super.key});


final controller=Get.find<AdminController>();
final formkey = GlobalKey<FormState>();


TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController mobileNumberController = TextEditingController();
TextEditingController passwordController = TextEditingController();
bool showDetails=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBars(context),
      body: Obx(() {
        return LoadingOverlay(
            isLoading: controller.isLoading.value,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                    padding: const EdgeInsets.all(kPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       ElevatedButton(
                               
                                onPressed: () {
                                 Get.dialog(addAdmin());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                  )
                                ),
                                child:const Padding(
                                  padding:  EdgeInsets.all(16.0),
                                  child: Text(
                                    'Add Admin',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                        LayoutBuilder(builder: (context, constraints) {
                          if (constraints.maxWidth > 600) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: showDetails?2:0,
                                  child: SingleChildScrollView(
                                    child: Card(
                                        margin: const EdgeInsets.all(kPadding),
                                        elevation: 2.0,
                                        child: Container(
                                            padding:
                                                const EdgeInsets.all(kPadding),
                                            child: adminListTable(controller
                                                    .adminList.value.data ??
                                                []))),
                                  ),
                                ),
                                // showDetails?
                                // Flexible(
                                //   child: SingleChildScrollView(
                                //     child: Card(
                                //         margin: const EdgeInsets.all(kPadding),
                                //         elevation: 2.0,
                                //         child: Container(
                                //             padding:
                                //                 const EdgeInsets.all(kPadding),
                                //             child: adminDetails())),
                                //   ),
                                // ):SizedBox(),
                              ],
                            );
                          } else {
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                      margin: const EdgeInsets.all(kPadding),
                                      elevation: 2.0,
                                      child: Container(
                                          padding:
                                              const EdgeInsets.all(kPadding),
                                          child: adminListTable(
                                              controller.adminList.value.data ??
                                                  []))),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  // showDetails?
                                  // Card(
                                  //     margin: const EdgeInsets.all(kPadding),
                                  //     elevation: 2.0,
                                  //     child: Container(
                                  //         padding:
                                  //             const EdgeInsets.all(kPadding),
                                  //         child: adminDetails())):SizedBox(),
                                ],
                              ),
                            );
                          }
                        })
                      ],
                    ))));
      }),
    );
  }

  Widget adminListTable(List<Datum> users) {
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
                'Name',
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
                'Mobile Number',
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
                textAlign: TextAlign.center,
              ),
            ),
          ],
          rows: buildRows(users),
          
        ));
  }

  List<DataRow> buildRows(List<Datum> users) {
    int i = 0;
    return users.map((user) {
      i++;
      return DataRow(
        cells: <DataCell>[
          DataCell(
            Text(i.toString()),
          ),
          DataCell(Text(user.fullName ?? "")),
          DataCell(Text(user.email ?? "")),
          DataCell(Text(user.mobileNumber ?? "")),
          DataCell(InkWell(
            onTap: () async {
              if (user.isActive == true) {
                await controller.deactivate(user.id!);
              } else {
                await controller.activate(user.id!);
              }

              await controller.getAdminList();
              // Get.toNamed(Routes.ADMIN_LIST);
            },
            child: Container(
              // height: 6.0,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: (user.isActive ?? false) ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(18.0)),

              child: Text(
                (user.isActive ?? false) ? "Active" : "InActive",
                style: const TextStyle(fontSize: 13.0, color: Colors.white),
              ),
            ),
          )),
          DataCell(
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.visibility,
                    color: Colors.green,
                    size: 16.0,
                  ),
                  onPressed: () {
                    if(showDetails=true)
                    controller.viewAdmin(user.id!);
                    // Get.offNamed(Routes.ADMIN_LIST);
                  },

                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 16.0,
                  ),
                  onPressed: () async {
                    // if(controller.isDeleted==false)
                    await controller.delete(user.id!);

                    await controller.getAdminList();
                    // Get.toNamed(Routes.ADMIN_LIST);
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                    size: 16.0,
                  ),
                  onPressed: () async {
                    //  controller.adminList.value = edit;
                     controller.nameController.text =controller.viewAdminResponse.value.fullName??"";
                      controller.emailController.text =controller.viewAdminResponse.value.emailId ?? "";
                      controller.mobileNumberController.text =controller.viewAdminResponse.value.mobileNumber ?? "";
                            var     ids=   controller.viewAdminResponse.value.id;
                  editAdmin(ids);
                  print(ids);
                  
                  },
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();
  }
       

  Widget adminDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Full Name : ${controller.viewAdminResponse.value.fullName ?? ""}",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          "Email : ${controller.viewAdminResponse.value.emailId ?? ""}",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          "Mobile Number : ${controller.viewAdminResponse.value.mobileNumber ?? ""}",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                "Created On : ${controller.viewAdminResponse.value.createdOn?? ""}",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // SizedBox(height: 10.0),
            Text(
              "Modified by : ${controller.viewAdminResponse.value.modifiedOn ?? ""}",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15.0),
           ],
    );
  }


Widget addAdmin(){
  return AlertDialog(
      // contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      title: Container(
        padding: EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.blue
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Add admin",
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 18.0
                          )),
                        CircleAvatar(
                            child: 
                           IconButton(onPressed: (){
                              Get.back();
                            }, icon: const Icon(Icons.close,
                            color: Colors.white,))),
                      ],
                    ),
                  ),
      content: Form(
        key: formkey,
        child:  SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: Get.size.width*0.3,
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your username';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(kPadding),
                        // hintText:
                        labelText: "Name",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                  
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox( width: Get.size.width*0.3,
                    child: TextFormField(
                      controller: mobileNumberController,
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
                   
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(kPadding),
                        // hintText:
                        labelText: "Contact",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                  
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox( width: Get.size.width*0.3,
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
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(kPadding),
                        // hintText:
                        labelText: "Email",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                  
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox( width: Get.size.width*0.3,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: controller.isVisible.value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Password ';
                        }
                  
                        if (value.length < 6) {
                          return 'Password should be at least 6 digits';
                        }
                        return null;
                      },
                      
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(kPadding),
                          hintText: "*******",
                          labelText: "Password",
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          suffixIcon: IconButton(
                              onPressed: () {
                                controller.isVisible.value =
                                    !controller.isVisible.value;
                              },
                              icon: Obx(() => controller.isVisible.value
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility)))),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox( width: Get.size.width*0.3,
                  height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            if (controller.isLoading.value == false) {
                              controller.isLoading.value = true;
                              AdminAddRequest addRequest = AdminAddRequest();
                              addRequest.email = emailController.text;
                              addRequest.password = passwordController.text;
                              addRequest.fullName = nameController.text;
                              addRequest.mobileNumber = mobileNumberController.text;
                              var res = await controller.saveAdmin(addRequest);
                              if (res != null) {
                                Get.offAndToNamed(Routes.ADMIN);
                              }
                              formkey.currentState!.reset();
                            }
                          }
                        },
                        child: const Text("Add",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18.0
                        ),)),
                  )
                ],
              ),
            ),
         
      ),
    );
  }

  Widget editAdmin(val){
    return AlertDialog(
      titlePadding: EdgeInsets.all(0),
      title: Container(
        padding: EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.blue
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Edit admin",
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 18.0
                          )),
                        CircleAvatar(
                            child: 
                           IconButton(onPressed: (){
                              Get.back();
                            }, icon: const Icon(Icons.close,
                            color: Colors.white,))),
                      ],
                    ),
                  ),
      content: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 
                TextFormField(
                  controller: controller.nameController,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Enter your username';
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(kPadding),
                    // hintText:
                    // hintText: controller.editDetails.value.fullName,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),

                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: controller.mobileNumberController,
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
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(kPadding),
                    // hintText:
                    labelText: "Contact",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),

                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
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
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(kPadding),
                    // hintText:
                    labelText: "Email",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),

                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(width: Get.size.width*0.3,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          if (controller.isLoading.value == false) {
                            controller.isLoading.value = true;
                            UpdateAdminRequest updateRequest =
                                UpdateAdminRequest();
                
                            updateRequest.email = controller.emailController.text;
                            updateRequest.fullName =
                                controller.nameController.text;
                            updateRequest.mobileNumber =
                                controller.mobileNumberController.text;
                            updateRequest.id = controller.viewAdminResponse.value.id.toString();
                            var res =
                                await controller.getUpdateAdmin(updateRequest);
                            print(updateRequest.id);
                            if (res != null) {
                              Get.offAllNamed(Routes.ADMIN);
                            }
                            formkey.currentState!.reset();
                          }
                        }
                      },
                      child: const Text("Update",style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18.0
                        ),)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  
  }
}
