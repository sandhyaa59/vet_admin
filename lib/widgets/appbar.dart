import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/utils/local_storage.dart';
import 'package:vet_pharma/utils/route.dart';
import 'package:vet_pharma/widgets/cancel.dart';

// class AppBarForAll extends StatelessWidget {
//   const AppBarForAll({super.key});

//   @override
PreferredSizeWidget AppBars(BuildContext context) {
  return AppBar(
    backgroundColor: const Color(0xff596cff),
    title: const Text('Trackyoe'),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
            radius: 16,
            backgroundColor: Colors.white,
            child: IconButton(
                onPressed: () async {
                  Get.dialog(askConfirmation(
                      "Are you sure you want to Logout ?",
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("No")),
                      TextButton(
                          onPressed: () async {
                            StorageUtil.clearAll();
                            Get.offAllNamed(Routes.LOGIN);
                          },
                          child: const Text("Yes"))));
                },
                icon: const Icon(
                  Icons.logout,
                  size: 16,
                ))),
      )
    ],
  );
}
// }