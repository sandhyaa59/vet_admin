// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:vet_pharma/controller/login_controller.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/utils/theme.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double cardHeight =
                constraints.maxHeight > 400 ? 400 : constraints.maxWidth * 0.8;
            double cardWidth =
                constraints.maxWidth > 400 ? 400 : constraints.maxWidth * 0.8;

            return SingleChildScrollView(
              child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(16),
                  child: Container(
                    width: cardWidth,
                    height: cardHeight,
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Center(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Login ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(textInputAction: TextInputAction.next,
                        autofocus: true,
                                  controller: emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your Email';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: customInputDecoration(
                                    labelText: "Email",
                                    hintText: "abc@gmail.com",
                                  )),
                              const SizedBox(height: 20),
                              Obx(() => TextFormField(textInputAction: TextInputAction.done,
                        autofocus: true,
                                  controller: passwordController,
                                  obscureText:
                                      controller.isVisible.value ? false : true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your Password';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: customInputDecoration(
                                    iconButton: IconButton(
                                        onPressed: () {
                                          controller.isVisible.value =
                                              !controller.isVisible.value;
                                        },
                                        icon: controller.isVisible.value
                                            ? const Icon(
                                                Icons.visibility_off,
                                                color: Color(0xff596cff),
                                              )
                                            : const Icon(Icons.visibility,
                                                color: Color(0xff596cff))),
                                    labelText: "Password",
                                    hintText: "*******",
                                  ))),
                              const SizedBox(
                                height: 20.0,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff596cff),
                                        padding: const EdgeInsets.all(16)),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (controller.isLoading.value ==
                                            false) {
                                          controller.isLoading.value = true;
                                          var res = await controller.login(
                                              emailController.text,
                                              passwordController.text);

                                          if (res != null) {
                                            Get.offAllNamed(Routes.HOME);
                                          } 
                                        }
                                      }
                                    },
                                    child: const Text(
                                      "LOGIN",
                                      style: TextStyle(fontSize: 20.0),
                                    )),
                              ),
                            ]),
                      ),
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }
}
