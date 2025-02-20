import 'package:flutter/material.dart';



      Widget askConfirmation(String content,TextButton no,TextButton yes) {
    return AlertDialog(
      content: Text(content,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500
      ),),
      actions: <Widget>[
        no,yes
        // TextButton(
        //   onPressed: () {
        //     Get.back(); // Close the dialog
        //   },
        //   child: const Text(
        //     'No',
        //     style: TextStyle(
        //       color: Color(0xff596cff),
        //     ),
        //   ),
        // ),
        // TextButton(
        //   onPressed: () async {
        //     // await controller.cancel(controller.selectedOrder.value.id!);
        //     // Get.offAllNamed(Routes.ORDER);
        //   },
        //   child: const Text(
        //     'Yes',
        //     style: TextStyle(
        //       color: Color(0xff596cff),
        //     ),
        //   ),
        // ),
      ],
    );
  }