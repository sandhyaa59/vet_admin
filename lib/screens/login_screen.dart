import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/login_controller.dart';
import 'package:vet_pharma/screens/qr_screen.dart';
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
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double cardHeight = constraints.maxHeight > 400
                  ? 400
                  : constraints.maxWidth * 0.8;
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
                              'Login',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              controller: emailController,
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter your Email' : null,
                              decoration: customInputDecoration(
                                labelText: "Email",
                                hintText: "abc@gmail.com",
                              ),
                            ),
                            const SizedBox(height: 20),
                            Obx(() => TextFormField(
                                  autofocus: false,
                                  // textInputAction: TextInputAction.done,
                                  controller: passwordController,
                                  obscureText: !controller.isVisible.value,
                                  validator: (value) => value!.isEmpty
                                      ? 'Enter your Password'
                                      : null,
                                  decoration: customInputDecoration(
                                    iconButton: IconButton(
                                      onPressed: () =>
                                          controller.isVisible.toggle(),
                                      icon: Icon(
                                        controller.isVisible.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: const Color(0xff596cff),
                                      ),
                                    ),
                                    labelText: "Password",
                                    hintText: "*******",
                                  ),
                                )),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Obx(() => ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff596cff),
                                      padding: const EdgeInsets.all(16),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (controller.isLoading.isFalse) {
                                          controller.isLoading.value = true;
                                          try {
                                            final res = await controller.login(
                                                emailController.text,
                                                passwordController.text);
                                            if (res != null) {
                                              Get.offAllNamed(Routes.HOME);
                                            }
                                          } finally {
                                            controller.isLoading.value = false;
                                          }
                                        }
                                      }
                                    },
                                    child: controller.isLoading.value
                                        ? const CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          )
                                        : const Text(
                                            "LOGIN",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white),
                                          ),
                                  )),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () =>
                                  Get.dialog(const Dialog(child: QRscreen())),
                              child: const Text(
                                "Show QR",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
