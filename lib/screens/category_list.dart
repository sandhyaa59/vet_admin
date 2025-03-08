import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/catgeory_controller.dart';
import 'package:vet_pharma/model/category.dart';
import 'package:vet_pharma/model/category_list_response.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/utils/loading_overlay.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/utils/theme.dart';
import 'package:vet_pharma/widgets/appbar.dart';
import 'package:vet_pharma/widgets/cancel.dart';

class CategoryList extends StatelessWidget {
  CategoryList({super.key});

  final controllers = Get.find<CategoryController>();
  // final controller = Get.find<PaymentController>();

  final formKeys = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController desecriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBars(context),
      body: Obx(() {
        return LoadingOverlay(
          isLoading: controllers.isLoading.value,
          child: SingleChildScrollView(
            child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.dialog(addCategoryForm(context));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                    color: Color(0xff596cff),
                                  ),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Add Category',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xff596cff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          // SizedBox(
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       // Get.dialog(addSubCategoryForm(context));
                          //     },
                          //     style: ElevatedButton.styleFrom(
                          //       backgroundColor: Colors.white,
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(8),
                          //         side: const BorderSide(
                          //           color: Color(0xff596cff),
                          //         ),
                          //       ),
                          //     ),
                          //     child: const Padding(
                          //       padding: EdgeInsets.all(16.0),
                          //       child: Text(
                          //         'Add Sub-Category',
                          //         style: TextStyle(
                          //           fontSize: 16.0,
                          //           color: Color(0xff596cff),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      categoryTable(context)
                    ],
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8),
                      child: SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.dialog(addCategoryForm(context));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: Color(0xff596cff),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Add Category',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff596cff),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    categoryTable(context)
                  ],
                );
              }
            }),
          ),
        );
      }),
    );
  }

  Widget categoryTable(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      child: SizedBox(
        width: Get.size.width, // Set the width to full screen
        child: PaginatedDataTable(
          columnSpacing: 20,
          header: const Text(
            "Category List",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          source: MyDataSource(controllers.dataList as List<CategoryData>,
              controllers.categoryList.value.totalData ?? 0, context),
          initialFirstRowIndex: 0,
          rowsPerPage: controllers.pageSize.value,
          onPageChanged: (newPage) async {
            await controllers.loadMoreData();
          },
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'SN',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                "Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            // DataColumn(
            //   label: Text(
            //     'Parent Category',
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            // ),
            DataColumn(
              label: Text(
                'Description',
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
      ),
    );
  }

  Widget addCategoryForm(BuildContext context) {
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
                const Text(
                  "Add Category",
                  textAlign: TextAlign.center,
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
          content: Form(
            key: formKeys,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: titleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Category name';
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
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        maxLines: 3,
                        controller: desecriptionController,
                        decoration: customInputDecoration(
                          labelText: "Description",
                        )),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: Get.size.width * 0.3,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formKeys.currentState!.validate()) {
                            if (controllers.isLoading.value == false) {
                              controllers.isLoading.value = true;
                              CategoryRequest addRequest = CategoryRequest();
                              addRequest.title = titleController.text;
                              addRequest.description =
                                  desecriptionController.text;

                              var res =
                                  await controllers.addCategory(addRequest);
                              Get.back();
                              if (res != null) {
                                await controllers.initData();
                                Get.offAndToNamed(Routes.CATEGORY);
                              }
                              controllers.initData();
                              formKeys.currentState!.reset();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff596cff),
                        ),
                        child: const Text(
                          "Add Categroy",
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
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
                const Text(
                  "Add Category",
                  textAlign: TextAlign.center,
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
          content: Form(
            key: formKeys,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: titleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Category name';
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
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextFormField(
                        textInputAction: TextInputAction.done,
                        autofocus: true,
                        maxLines: 3,
                        controller: desecriptionController,
                        decoration: customInputDecoration(
                          labelText: "Description",
                        )),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: Get.size.width * 0.3,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formKeys.currentState!.validate()) {
                            if (controllers.isLoading.value == false) {
                              controllers.isLoading.value = true;
                              CategoryRequest addRequest = CategoryRequest();
                              addRequest.title = titleController.text;
                              addRequest.description =
                                  desecriptionController.text;
                              var res =
                                  await controllers.addCategory(addRequest);

                              Get.back();
                              if (res != null) {
                                await controllers.initData();
                              }
                              controllers.initData();
                              formKeys.currentState!.reset();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff596cff),
                        ),
                        child: const Text(
                          "Add Categroy",
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        )),
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
  final List<CategoryData> categories;
  final int totalData;
  final BuildContext context;

  MyDataSource(this.categories, this.totalData, this.context);
  CategoryController controllers = Get.find<CategoryController>();

  @override
  DataRow? getRow(int index) {
    if (index >= categories.length) {
      return null;
    }
    return DataRow(
      cells: <DataCell>[
        DataCell(Text('${index + 1}')),
        DataCell(Text(categories[index].title ?? "")),
        // DataCell(Text(
        //     categories[index].parentCategoryName ?? "")),
        DataCell(
          SizedBox(
            // width: Get.size.width *
            //     0.3, // Adjust width for better readability
            child: Text(categories[index].description ?? ""),
          ),
        ),
        DataCell(
          InkWell(
            onTap: () async {
              if (categories[index].isActive == true) {
                await Get.dialog(
                  askConfirmation(
                    "Are you sure you want to deactivate this category?",
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () async {
                        var res = await controllers
                            .deactivate(categories[index].id ?? 0);
                        Get.back();
                        if (res != null) {
                          await controllers.initData();
                        }
                      },
                      child: const Text('Yes'),
                    ),
                  ),
                );
              } else {
                await Get.dialog(
                  askConfirmation(
                    "Are you sure you want to activate this category?",
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () async {
                        var res = await controllers
                            .activateCategory(categories[index].id ?? 0);
                        Get.back();
                        if (res != null) {
                          await controllers.initData();
                        }
                      },
                      child: const Text('Yes'),
                    ),
                  ),
                );
              }
              Get.offAllNamed(Routes.CATEGORY);
            },
            child: Obx(
              () => Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: (categories[index].isActive ?? false)
                      ? Colors.green
                      : Colors.red,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  (categories[index].isActive ?? false) ? "Active" : "Inactive",
                  style: const TextStyle(fontSize: 13.0, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        DataCell(
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.blue,
              size: 16.0,
            ),
            onPressed: () {
              titleController.text = categories[index].title ?? "";
              desecriptionController.text = categories[index].description ?? "";
              Get.dialog(updateCategoryForm(context));
            },
          ),
        ),
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

  final formKeys = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController desecriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  Widget updateCategoryForm(context) {
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
            const Text(
              "Update Category",
              textAlign: TextAlign.center,
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
      content: Form(
        key: formKeys,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextFormField(
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    controller: titleController,
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
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextFormField(
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    maxLines: 3,
                    controller: desecriptionController,
                    decoration: customInputDecoration(
                      labelText: "Description",
                    )),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: SizedBox(
                  width: Get.size.width * 0.3,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (formKeys.currentState!.validate()) {
                          if (controllers.isLoading.value == false) {
                            controllers.isLoading.value = true;
                            CategoryData addRequest = CategoryData();
                            addRequest.title = titleController.text;
                            addRequest.description =
                                desecriptionController.text;

                            var res =
                                await controllers.updateCategory(addRequest);
                            Get.back();
                            if (res != null) {
                              print('update catgeory');

                              Get.offAndToNamed(Routes.CATEGORY);
                            }
                            await controllers.initData();
                            formKeys.currentState!.reset();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff596cff),
                      ),
                      child: const Text(
                        "Update Categroy",
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
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
