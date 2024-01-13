import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/controller/organization_controller.dart';

final controller = Get.find<OrganizationController>();

Widget organizationDetails() {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff004792),
        ),
        borderRadius: BorderRadius.circular(8.0)),
    padding: const EdgeInsets.all(12.0),
    child: Column(
      children: [
        Text(
          controller.organizationDetail.value.name ?? "",
          style: const TextStyle(
              fontSize: 24.0,
              color: Color(0xff004792),
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10.0,
        ),
        RichText(
            text:  TextSpan(children: [
          TextSpan(
              text:  controller.organizationDetail.value.email ?? "",
              style:const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff004792),
                  fontWeight: FontWeight.w400)),
          TextSpan(
              text:  controller.organizationDetail.value.phoneNo ?? "",
              style:const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400))
        ])),
        const SizedBox(
          height: 8.0,
        ),
        RichText(
            text:  TextSpan(children: [
          TextSpan(
              text:  controller.organizationDetail.value.address ?? "",
              style:const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff004792),
                  fontWeight: FontWeight.w400)),
          TextSpan(
              text: "Pan Number: ${controller.organizationDetail.value.panNo ?? ""}",
              style:const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400))
        ])),
      ],
    ),
  );
}
