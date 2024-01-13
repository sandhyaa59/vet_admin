// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:vet_pharma/screens/bill_details_screen.dart';
import 'package:vet_pharma/screens/billing.dart';
import 'package:vet_pharma/screens/checkin-checkout.dart';
import 'package:vet_pharma/screens/customer.dart';
import 'package:vet_pharma/screens/employee_management.dart';
import 'package:vet_pharma/screens/homescreen.dart';
import 'package:vet_pharma/screens/login_screen.dart';
import 'package:vet_pharma/screens/order.dart';
import 'package:vet_pharma/screens/order_details_screen.dart';
import 'package:vet_pharma/screens/payment.dart';
import 'package:vet_pharma/screens/payment_details_screen.dart';
import 'package:vet_pharma/screens/report_details.screen.dart';
import 'package:vet_pharma/screens/report_screen.dart';
import 'package:vet_pharma/utils/bindings.dart';
import 'package:vet_pharma/utils/local_storage.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: Routes.LOGIN, page: () => LoginScreen(), binding: LoginBinding()),
    GetPage(
        name: Routes.HOME, page: () => HomeScreen(), bindings: [HomeBinding(),
        OrganizationBinding(),
        BillingBinding(),
        OrderBinding(),
        PaymentBinding()]),
    GetPage(
        name: Routes.CHECKINCHECKOUT,
        page: () => CheckInCheckOutScreen(),
        binding: CheckInCheckOutBinding()),
    
     GetPage(
        name: Routes.REPORT, page: () => ReportScreen(), binding: ReportBinding()), 
      GetPage(
        name: Routes.ORDER,
        page: () => OrderScreen(),
        binding: OrderBinding()), 
         GetPage(
        name: Routes.BILLING,
        page: () => BillingScreen(),
        binding: BillingBinding()),
  GetPage(
        name: Routes.PAYMENT,
        page: () => PaymentScreen(),
        binding: PaymentBinding()),

         GetPage(
        name: Routes.EMPLOYEE_MANAGEMENT,
        page: () => EmployeeManagementScreen(),
        binding: EmployeeManagementBinding()),
        
        GetPage(
        name: Routes.CUSTOMERLIST,
        page: () => CustomerScreen(),
        binding: CustomerBinding()),
        GetPage(
        name: Routes.REPORT_DETAILS,
        page: () => ReportDetailsScreen(),
        binding: ReportDetailBinding()
        ),
        GetPage(
        name: Routes.ORDER_DETAILS,
        page: () => OrderDetailsScreen(),
        binding:OrderDetailBinding()
        ),
        GetPage(
        name: Routes.BILL_DETAILS,
        page: () => BillDetailsScreen(),
        binding: BillDetailsBinding()
        ),
         GetPage(
        name: Routes.PAYMENT_DETAILS,
        page: () => PaymentDetailsScreen(),
        ),



        GetPage(
      name: Routes.INITIAL_LOAD,
      page: () => FutureBuilder(
        future: Future(() async {
          var token = await StorageUtil.getValue("token");
          if (token != null) {
            return "perfect";
          } else {
            return "login";
          }
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              Future.delayed(
                Duration.zero,
                () {
                  if (snapshot.data == "perfect") {
                    return Get.offAllNamed(Routes.HOME);
                  } else {
                    return Get.offAllNamed(Routes.LOGIN);
                  }
                },
              );
            }
          }
          return Container();
        },
      ),
    )
 

  ];
}

class Routes {
    static const String INITIAL_LOAD = "/initial-load";

  static const String HOME = "/home";
  static const String LOGIN = "/login";
  static const String CHECKINCHECKOUT = "/checkin-checkout";
  static const String EMPLOYEE = "/employee";
  static const String REPORT = "/report";
  static const String ORDER = "/order";
  static const String BILLING = "/billing";
  static const String PAYMENT = "/payment";
  static const String EMPLOYEE_MANAGEMENT = "/employee-management";
 static const String EMPLOYEE_UPDATE= "/employee-update";

  static const String CUSTOMERLIST = "/customer-list";
  static const String CUSTOMER_UPDATE = "/customer-update";


  static const String REPORT_DETAILS="/report-details";
  static const String ORDER_DETAILS="/order-details";
  static const String BILL_DETAILS="/bill-details";
  static const String PAYMENT_DETAILS="/payment-details";


}
