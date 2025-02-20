

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/product_controller.dart';
import 'package:vet_pharma/model/category_list_response.dart';
import 'package:vet_pharma/model/productadd_request.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/utils/theme.dart';
import 'package:vet_pharma/widgets/appbar.dart';

class ProductAddForm extends StatefulWidget {
  final Map<String, dynamic>? productData;
  const ProductAddForm({Key? key, this.productData}) : super(key: key);

  @override
  _ProductAddFormState createState() => _ProductAddFormState();
}

class _ProductAddFormState extends State<ProductAddForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController costPriceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  // final TextEditingController unitController = TextEditingController();

  //  'name': TextEditingController(),
//     'category': TextEditingController(),
//     'amount': TextEditingController(),
//     // 'discount': TextEditingController(),
//     'tax': TextEditingController(),
//     'brand': TextEditingController(),
//     'stock': TextEditingController(),
//     'price': TextEditingController(),
//     'costPrice': TextEditingController(),
//     'unit': TextEditingController(),
//     'description': TextEditingController(),

  final ProductController productController = Get.find<ProductController>();

  @override
void initState() {
  super.initState();
  productController.fetchCategory().then((_) {
    if (widget.productData != null) {
      nameController.text = widget.productData!['title'] ?? '';
      descriptionController.text = widget.productData!['description'] ?? '';
      priceController.text = widget.productData!["price"]?.toString() ?? "";
      stockController.text = widget.productData!["stock"]?.toString() ?? "";
      costPriceController.text = widget.productData!["costPrice"]?.toString() ?? "";
      brandController.text = widget.productData!["brand"]?.toString() ?? "";
      unitController.text = widget.productData!["unit"] ?? "";
      
      String categoryName = widget.productData!["category"] ?? "";

      if (productController.category.isNotEmpty) {
        final selectedCategory = productController.category.firstWhere(
          (element) => element.title == categoryName,
          orElse: () => productController.category.first, 
          
        );
        productController.selectedCategory.value = selectedCategory;
        print("Selected category: ${productController.selectedCategory.value.title}");

      }
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBars(context),
        body: SingleChildScrollView(
            child: Center(
                child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 400),
                        padding: const EdgeInsets.all(20),
                        // decoration: BoxDecoration(
                        //   color: Colors.white,
                        //   borderRadius: BorderRadius.circular(12),
                        //   boxShadow: [
                        //     const BoxShadow(
                        //       color: Colors.black12,
                        //       blurRadius: 5,
                        //       spreadRadius: 2,
                        //     ),
                        //   ],
                        // ),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.productData != null
                                      ? "Update Product"
                                      : "Add Product",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: nameController,
                                  textInputAction: TextInputAction.next,
                                  decoration: customInputDecoration(
                                      hintText: 'Name', labelText: 'Name'),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Please enter product name'
                                          : null,
                                ),
                                const SizedBox(height: 16),
                                _buildCategoryDropdown(),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: descriptionController,
                                  textInputAction: TextInputAction.next,
                                  decoration: customInputDecoration(
                                      hintText: 'Description',
                                      labelText: 'Description'),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Please enter description'
                                          : null,
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: priceController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  decoration: customInputDecoration(
                                      hintText: 'Price', labelText: 'Price'),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: stockController,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        decoration: customInputDecoration(
                                            hintText: 'Stock',
                                            labelText: 'Stock'),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: TextFormField(
                                        controller: unitController,
                                        // keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        decoration: customInputDecoration(
                                            hintText: 'kg/pcs',
                                            labelText: 'Unit'),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: costPriceController,
                                  textInputAction: TextInputAction.done,
                                  decoration: customInputDecoration(
                                      hintText: 'cost price',
                                      labelText: 'cost price'),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: brandController,
                                  textInputAction: TextInputAction.done,
                                  decoration: customInputDecoration(
                                      hintText: 'Brand', labelText: 'Brand'),
                                ),
                                const SizedBox(height: 16),
                                Obx(() => SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          print("Here for testing");
                                          if (_formKey.currentState!
                                              .validate()) {
                                            ProductAddRequest productRequest =
                                                ProductAddRequest();

                                            productRequest.title =
                                                nameController.text;
                                            productRequest.description =
                                                descriptionController.text;

                                            productRequest.categoryId =
                                                productController
                                                    .selectedCategory.value.id;
                                            productRequest.price = double.parse(
                                                priceController.text);
                                            productRequest.stock = double.parse(
                                                stockController.text);
                                            productRequest.costPrice =
                                                double.parse(
                                                    costPriceController.text);
                                            productRequest.brand =
                                                brandController.text;
                                            productRequest.unit =
                                                unitController.text;

                                            if (widget.productData != null) {
                                              productRequest.id =
                                                  widget.productData!['id'];
                                              print("Here for update");
                                              await productController
                                                  .updateProduct(
                                                      productRequest);
                                              Get.snackbar("Success",
                                                  "Product updated successfully!",
                                                  backgroundColor: Colors.blue,
                                                  colorText: Colors.white);
                                            } else {
                                              print("Here for save");
                                              var res = await productController
                                                  .saveProducts(productRequest);
                                              if (res != null) {
                                                Get.snackbar("Success",
                                                    "Product Saved Successfully");
                                              }
//       }
                                            }
                                            print("Here for done");
                                            Get.offAndToNamed(Routes.PRODUCT);
                                            await productController.initData();
                                            _formKey.currentState!.reset();
                                          }
                                        },
                                        child: productController.isLoading.value
                                            ? const CircularProgressIndicator()
                                            : Text(
                                                widget.productData != null
                                                    ? 'Update'
                                                    : 'Submit',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )))));
  }

  Widget _buildCategoryDropdown() {
    return Obx(() {
      return DropdownButtonFormField<CategoryListResponse>(
        decoration: customInputDecoration(labelText: "Category"),
        value: productController.selectedCategory.value,
        onChanged: (CategoryListResponse? value) {
          productController.selectedCategory.value =
              value ?? CategoryListResponse();
        },
        items: productController.category.map((value) {
          return DropdownMenuItem<CategoryListResponse>(
            value: value,
            child: Text(
              value.title ?? "",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          );
        }).toList(),
      );
    });
  }
}
