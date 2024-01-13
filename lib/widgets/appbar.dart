import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/utils/local_storage.dart';
import 'package:vet_pharma/utils/route.dart';

// class AppBarForAll extends StatelessWidget {
//   const AppBarForAll({super.key});

//   @override
  PreferredSizeWidget AppBars(BuildContext context) {
    return  AppBar(
        backgroundColor:  const Color(0xff596cff),
        title: const Text('Vet Pharma'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: IconButton(
                    onPressed: () {
                      StorageUtil.clearAll();
                      Get.offAllNamed(Routes.LOGIN);
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